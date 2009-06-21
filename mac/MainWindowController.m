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
    [self setBackgroundColor: [NSColor whiteColor]];
    [self setNeedsDisplay: YES];	
}

- (void)mouseExited:(NSEvent *)theEvent {
	[self setBackgroundColor: [NSColor windowBackgroundColor]];
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
    [self willChangeValueForKey:@"timeFontSize"];
    [self didChangeValueForKey:@"timeFontSize"];
    [self setMinutes:15];
    paused_ = NO;
}

- (void)timerFunc {
    NSDate *now = [NSDate date];
    NSTimeInterval passed = [now timeIntervalSinceDate:startTime_];
    if (passed == prevPassed_)
        return;
    prevPassed_ = passed;
    int remaining = (int)totalTime_ - (int)passed;
    [self setTime:remaining];
    if (0 == remaining)
        [self stop:nil];
}

- (IBAction)start:(id)sender {
    [text5min_          setHidden:YES];
    [text15min_         setHidden:YES];
    [text30min_         setHidden:YES];
    [text1hr_           setHidden:YES];
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
    [text5min_          setHidden:NO];
    [text15min_         setHidden:NO];
    [text30min_         setHidden:NO];
    [text1hr_           setHidden:NO];
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
