#import "MainWindowController.h"

@implementation MyLabel

- (id)initWithCoder: (NSCoder *) coder {
	self = [super initWithCoder: coder];
	if (!self)
		return nil;

	trackingTag_ = 0;

	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];		
	[nc addObserver: self
		   selector: @selector(resetBounds:)
			   name: NSViewFrameDidChangeNotification
			 object: nil];

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
	[super dealloc];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self setBackgroundColor: [NSColor lightGrayColor]];
    [self setNeedsDisplay: YES];	
}

- (void)mouseExited:(NSEvent *)theEvent {
	[self setBackgroundColor: [NSColor whiteColor]];
    [self setNeedsDisplay: YES];	
}

- (void)mouseDown:(NSEvent *)theEvent {
    SEL action = [self action];
    id target = [self target];
    [self sendAction:action to:target];
}

- (void) resetBounds: (NSNotification *) notification {
    if (trackingTag_)
        [self removeTrackingRect: trackingTag_];
    trackingTag_ = [self addTrackingRect:[self bounds]
                                   owner: self
                                userData: nil
                            assumeInside: NO];
}

@end

@interface MainWindowController (Private)

- (void)setRemainingTime:(int)seconds;
- (void)timerFunc;

@end

@implementation MainWindowController

- (NSNumber*)timeFontSize {
    NSNumber *size = [NSNumber numberWithInt:24];
    return size;
}

- (void)setTime:(int)seconds {
    int minutes = seconds/60;
    seconds = seconds % 60;
    NSString *txt = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    [textTime_ setTitleWithMnemonic:txt];
}

- (void)setSeconds:(int)seconds {
    totalTime_ = seconds;
    [self setTime:seconds];
}

- (void)setDefaultTime:(int)seconds {
    defaultTime_ = seconds;
    [self setSeconds:defaultTime_];
}

- (void)setMinutes:(int)minutes {
    [self setDefaultTime:minutes*60];
}

- (IBAction)fiveMinutes:(id)sender {
    [self setMinutes:5];
}

- (IBAction)fifteenMinutes:(id)sender {
    [self setMinutes:15];
}

- (IBAction)thirtyMinutes:(id)sender {
    [self setMinutes:30];
}

- (IBAction)sixtyMinutes:(id)sender {
    [self setMinutes:60];
}

- (void)awakeFromNib {
	[[NSApplication sharedApplication] setDelegate:self];
    [window_ setBackgroundColor:[NSColor whiteColor]];
    [self willChangeValueForKey:@"timeFontSize"];
    [self didChangeValueForKey:@"timeFontSize"];
    [self setDefaultTime:5];
    paused_ = NO;
}

- (void)setLabelsHidden:(BOOL)hidden {
    [text5min_   setHidden:hidden];
    [text15min_  setHidden:hidden];
    [text30min_  setHidden:hidden];
    [text1hr_    setHidden:hidden];    
}

- (IBAction)ok:(id)sender {
    [buttonOk_ setHidden:YES];
    [buttonStart_ setHidden:NO];
    [self setLabelsHidden:NO];
    [window_ setBackgroundColor:[NSColor whiteColor]];
    [self setTime:defaultTime_];
}

- (void)finished {
    [buttonOk_ setHidden:NO];
    [buttonStart_ setHidden:NO];
    [buttonStop_ setHidden:YES];
    [buttonPauseResume_ setHidden:YES];
    // TODO: start a timer that flashes window background
    [timer_ release];
    timer_ = nil;
    [window_ setBackgroundColor:[NSColor redColor]];
    [NSApp arrangeInFront:self];
    // TODO: unminimize if minimized
}

- (void)timerFunc {
    NSDate *now = [NSDate date];
    NSTimeInterval passed = [now timeIntervalSinceDate:startTime_];
    if (passed == prevPassed_)
        return;
    prevPassed_ = passed;
    int remaining = (int)totalTime_ - (int)passed;
    [self setTime:remaining];
    if (remaining <= 0) {
        // set to 0 to cover the case where we went below zero while main thread
        // couldn't receive timer events (e.g. while holding the menu open) 
        [self setTime:0];
        [self finished];
    }
}

- (IBAction)start:(id)sender {
    [self setLabelsHidden:YES];
    [buttonStart_       setHidden:YES];
    [buttonStop_        setHidden:NO];
    [buttonPauseResume_ setTitle:@"Pause"];
    [buttonPauseResume_ setHidden:NO];

    [startTime_ release];
    startTime_ = [[NSDate date] retain];

	timer_ = [NSTimer timerWithTimeInterval:0.1f
									target:self
								  selector:@selector(timerFunc)
								  userInfo:nil
								   repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer_ forMode:NSDefaultRunLoopMode];
}

- (void)pause {
    // TODO: stop the timer
    [buttonPauseResume_ setTitle:@"Resume"];
    [buttonPauseResume_ setHidden:NO];
    paused_ = YES;
}

- (void)resume {
    // TODO: resume the timer
    [buttonPauseResume_ setTitle:@"Pause"];
    //[buttonPauseResume_ setHidden:NO];
    paused_ = NO;
}

- (IBAction)pauseResume:(id)sender {
    if (paused_) {
        [self resume];
    } else {
        [self pause];
    }
}

- (IBAction)stop:(id)sender {
    [self setLabelsHidden:NO];
    [buttonStart_       setHidden:NO];
    [buttonStop_        setHidden:YES];
    [buttonPauseResume_ setTitle:@"Pause"];
    [buttonPauseResume_ setHidden:YES];

    [timer_ release];
    timer_ = nil;
    [self setTime:defaultTime_];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
	return YES;
}

@end
