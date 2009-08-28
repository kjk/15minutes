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

- (void)timerFunc;
- (void)stopTimer;
- (void)startFlashingTimer;

@end

@implementation MainWindowController

- (NSNumber*)timeFontSize {
    NSNumber *size = [NSNumber numberWithInt:24];
    return size;
}

- (void)setDisplayTime:(int)seconds {
    int minutes = seconds/60;
    seconds = seconds % 60;
    NSString *txt = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    [textTime_ setTitleWithMnemonic:txt];
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
    [self setMinutes:15];
    //[self setDefaultTime:5];
}

- (void)setLabelsHidden:(BOOL)hidden {
    [text5min_   setHidden:hidden];
    [text15min_  setHidden:hidden];
    [text30min_  setHidden:hidden];
    [text1hr_    setHidden:hidden];    
}

- (IBAction)ok:(id)sender {
    [self stopTimer];
    [buttonOk_ setHidden:YES];
    [buttonStart_ setHidden:NO];
    [self setLabelsHidden:NO];
    [window_ setBackgroundColor:[NSColor whiteColor]];
    [self resetTime];
}

- (void)finished {
    [buttonOk_ setHidden:NO];
    [buttonStart_ setHidden:NO];
    [buttonStop_ setHidden:YES];
    [buttonPauseResume_ setHidden:YES];
    [self stopTimer];
    [self startFlashingTimer];
    [NSApp arrangeInFront:self];
    if ([window_ isMiniaturized])
        [window_ deminiaturize:self];
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
    if (0 == (flashesRemaining_ % 2))
        [window_ setBackgroundColor:[NSColor redColor]];
    else
        [window_ setBackgroundColor:[NSColor whiteColor]];
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
    [self setLabelsHidden:YES];
    [buttonStart_       setHidden:YES];
    [buttonStop_        setHidden:NO];
    [buttonPauseResume_ setTitle:@"Pause"];
    [buttonPauseResume_ setHidden:NO];
    [self startTimer];
}

- (void)pause {
    [self stopTimer];
    [buttonPauseResume_ setTitle:@"Resume"];
    [buttonPauseResume_ setHidden:NO];
}

- (void)resume {
    [buttonPauseResume_ setTitle:@"Pause"];
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
    [window_ setBackgroundColor:[NSColor whiteColor]];
    [self setLabelsHidden:NO];
    [buttonStart_       setHidden:NO];
    [buttonStop_        setHidden:YES];
    [buttonPauseResume_ setHidden:YES];

    [self stopTimer];
    [self resetTime];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
	return YES;
}

@end
