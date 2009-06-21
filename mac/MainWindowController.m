#import "MainWindowController.h"

@implementation MyLabel

- (id)initWithCoder: (NSCoder *) coder
{
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
	[super dealloc];
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [self setBackgroundColor: [NSColor whiteColor]];
    [self setNeedsDisplay: YES];	
}

- (void)mouseExited:(NSEvent *)theEvent
{
	[self setBackgroundColor: [NSColor windowBackgroundColor]];
    [self setNeedsDisplay: YES];	
}

- (void)mouseDown:(NSEvent *)theEvent 
{
    SEL action = [self action];
    id target = [self target];
    [self sendAction:action to:target];
}

- (void) resetBounds: (NSNotification *) notification
{
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

- (NSFont*)timeFont {
    return timeFont_;
}

- (void)setSeconds:(int)seconds
{
    seconds_ = seconds;
    int minutes = seconds/60;
    seconds = seconds % 60;
    NSString *txt = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    [textTime_ setTitleWithMnemonic:txt];
}

- (void)setMinutes:(int)minutes {
    [self setSeconds:minutes*60];
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

- (void)awakeFromNib
{
	[[NSApplication sharedApplication] setDelegate:self];
    [self setSeconds:15*60];
}

- (void)timerFunc
{
	seconds_ = seconds_ - 1;
	if (seconds_ <= 0)
	{
		[timer_ invalidate];
		[timer_ release];
		timer_ = nil;
	}
}

- (IBAction)start:(id)sender
{
	timer_ = [NSTimer timerWithTimeInterval: 0.1f
									target: self
								  selector: @selector (timerFunc:)
								  userInfo: nil
								   repeats: YES];
    [startTime_ release];
    startTime_ = [NSDate date];
}

- (IBAction)pause:(id)sender
{
	
}

- (IBAction)pauseResume:(id)sender
{
	
}

- (IBAction)stop:(id)sender
{
	
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return YES;
}

@end
