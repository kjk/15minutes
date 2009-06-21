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

- (void)setSeconds:(int)seconds
{
	seconds_ = seconds;
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
	/* TODO: change the time in the display */
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

- (void)setSeconds:(int)seconds
{
    seconds_ = seconds;
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

- (IBAction)resume:(id)sender
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
