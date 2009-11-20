#import "MainWindowController.h"
#import "TimeDisplayView.h"
#import "MAAttachedWindow.h"

enum {
    kMenuItemStart5min = 1,
    kMenuItemStart15min = 2,
    kMenuItemStart30min = 3,

    kMenuItemPauseResumeTag = 4,
    kMenuItemStopTag = 5,
};

@interface NSStatusItem (hack)
- (NSRect)hackFrame;
@end

@implementation NSStatusItem (hack)
- (NSRect)hackFrame
{
    return [_fWindow frame];
}
@end

@interface MyAttachedWindow : MAAttachedWindow
- (void)mouseDown:(NSEvent *)theEvent;
@end

@implementation MyAttachedWindow

- (void)mouseDown:(NSEvent *)theEvent {
    [super mouseDown:theEvent];
    [self orderOut:nil];
}
@end

@interface MainWindowController (Private)

- (void)timerFunc;
- (void)stopTimer;
- (void)startFlashingTimer;

@end

@implementation MainWindowController

- (void)setDisplayTime:(int)seconds {
    [timeDisplay_ setSeconds:seconds];

    NSString *timeStr = [NSString stringWithFormat:@"%2d:%02d", seconds / 60, seconds % 60];
    [statusItem_ setTitle:timeStr];
}

- (void)setSeconds:(int)seconds {
    remainingTime_ = (NSTimeInterval)seconds;
    [self setDisplayTime:seconds];
}

- (void)setDefaultTime:(int)seconds {
    defaultTime_ = seconds;
    [self setSeconds:defaultTime_];
}

- (void)resetTime {
    [self setSeconds:defaultTime_];
}

- (void)setMinutes:(int)minutes {
    [self setDefaultTime:minutes*60];
}

- (void)setRunningMenuState {
    [[statusItemMenu_ itemWithTag:kMenuItemPauseResumeTag] setEnabled:YES];
    [[statusItemMenu_ itemWithTag:kMenuItemStopTag] setEnabled:YES];
    
    [[statusItemMenu_ itemWithTag:kMenuItemStart5min] setEnabled:NO];
    [[statusItemMenu_ itemWithTag:kMenuItemStart15min] setEnabled:NO];
    [[statusItemMenu_ itemWithTag:kMenuItemStart30min] setEnabled:NO];    
}

- (void)setStoppedMenuState {
    [[statusItemMenu_ itemWithTag:kMenuItemPauseResumeTag] setEnabled:NO];
    [[statusItemMenu_ itemWithTag:kMenuItemStopTag] setEnabled:NO];
    
    [[statusItemMenu_ itemWithTag:kMenuItemStart5min] setEnabled:YES];
    [[statusItemMenu_ itemWithTag:kMenuItemStart15min] setEnabled:YES];
    [[statusItemMenu_ itemWithTag:kMenuItemStart30min] setEnabled:YES];
}

- (void)awakeFromNib {

    NSBundle *bundle = [NSBundle mainBundle];
    statusItemImage_  = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"timer" ofType:@"png"]];

    strFlashAttr_ = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [NSFont menuBarFontOfSize:0], NSFontAttributeName,
                    [NSColor redColor], NSBackgroundColorAttributeName,
                    [NSColor blackColor], NSForegroundColorAttributeName, nil];

    [statusItemMenu_ setAutoenablesItems:NO];

    statusItem_ = [[[NSStatusBar systemStatusBar] 
				   statusItemWithLength:NSVariableStatusItemLength]
				  retain];
    [statusItem_ setImage:statusItemImage_];
	[statusItem_ setHighlightMode:YES];
	[statusItem_ setMenu:statusItemMenu_];

    NSRect frm = [statusItem_ hackFrame];
    NSPoint attachedWindowPos = NSMakePoint(NSMidX(frm), NSMinY(frm));
    attachedWindowPos.y -= 20; // move down - this is in flipped coordinates

    attachedWindow_ = [[MyAttachedWindow alloc] initWithView:timesUpView_
                                            attachedToPoint:attachedWindowPos	 
                                                   inWindow:nil
                                                      onSide:MAPositionBottom 
                                                  atDistance:1.0];
    [timesUpTextField_ setTextColor:[attachedWindow_ borderColor]];
     
	[[NSApplication sharedApplication] setDelegate:self];
    [self setMinutes:15];
    [self setStoppedMenuState];
}

- (void)dealloc {
    [strFlashAttr_ release];
    [super dealloc];
}

- (IBAction)ok:(id)sender {
    [self stopTimer];
    [self resetTime];
}

- (void)finished {
    [self stopTimer];
    [self setStoppedMenuState];
    [self startFlashingTimer];
    [attachedWindow_ makeKeyAndOrderFront:self];
    [NSApp makeKeyAndOrderFront:self];
}

- (void)timerFunc {
    NSDate *now = [NSDate date];
    NSTimeInterval passed = [now timeIntervalSinceDate:startTime_];
    [startTime_ release];
    startTime_ = [now retain];
    int prevRemainingSeconds = (int)remainingTime_;
    remainingTime_ -= passed;
    int remainingSeconds = (int)remainingTime_;
    if (prevRemainingSeconds == remainingSeconds)
        return;
    // set to 0 to cover the case where we went below zero while main thread
    // couldn't receive timer events (e.g. while holding the menu open) 
    if (remainingSeconds < 0)
        remainingSeconds = 0;
    [self setDisplayTime:remainingSeconds];
    if (remainingSeconds == 0) {
        [self finished];
    }
}

- (void)stopTimer {
	[timer_ invalidate];
    timer_ = nil;
    [startTime_ release];
    startTime_ = nil;
}

- (void)startTimer {
    timer_ = [NSTimer timerWithTimeInterval:0.1f
                                     target:self
                                   selector:@selector(timerFunc)
                                   userInfo:nil
                                    repeats:YES];
    startTime_ = [[NSDate date] retain];
    [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSDefaultRunLoopMode];
}

- (void)flashTimerFunc {
    NSString *timeStr = @"0:00";
    if (0 == (flashesRemaining_ % 2)) {
        NSAttributedString *title = [[NSAttributedString alloc] 
                                     initWithString:timeStr
                                     attributes: strFlashAttr_];
        [statusItem_ setTitle:(NSString*)title];        
    }
    else {
        [statusItem_ setTitle:timeStr];
    }
    --flashesRemaining_;
    if (0 == flashesRemaining_)
        [self ok:self];
}

- (void)startFlashingTimer {
    timer_ = [NSTimer timerWithTimeInterval:0.5f
                                     target:self
                                   selector:@selector(flashTimerFunc)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSDefaultRunLoopMode];
    flashesRemaining_ = 24;
}

- (IBAction)start:(id)sender {
    [[statusItemMenu_ itemWithTag:kMenuItemPauseResumeTag] setTitle:@"Pause"];

    [self setRunningMenuState];
    [self startTimer];
}

- (IBAction)start5min:(id)sender {
    //[self setDefaultTime:2];
    [self setMinutes:5];
    [self start:sender];
}

- (IBAction)start15min:(id)sender {
    [self setMinutes:15];
    [self start:sender];
}

- (IBAction)start30min:(id)sender {
    [self setMinutes:30];
    [self start:sender];
}

- (void)pause {
    [self stopTimer];
    [[statusItemMenu_ itemWithTag:kMenuItemPauseResumeTag] setTitle:@"Resume"];
}

- (void)resume {
    [[statusItemMenu_ itemWithTag:kMenuItemPauseResumeTag] setTitle:@"Pause"];
    [self startTimer];
}

- (BOOL)isPaused {
    if (timer_)
        return NO;
    return YES;
}

- (IBAction)pauseResume:(id)sender {
    if ([self isPaused]) {
        [self resume];
    } else {
        [self pause];
    }
}

- (IBAction)stop:(id)sender {
    [self stopTimer];
    [self resetTime];
    [self setStoppedMenuState];
}

@end
