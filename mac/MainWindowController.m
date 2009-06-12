#import "MainWindowController.h"

@implementation MyLabel

- (id)initWithCoder: (NSCoder *) coder
{
	self = [super initWithCoder: coder];
	if (!self)
		return nil;

	trackingTag = 0;

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

- (void)setSeconds:(int)aSeconds
{
	seconds = aSeconds;
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
    if (trackingTag)
        [self removeTrackingRect: trackingTag];
    trackingTag = [self addTrackingRect: [self bounds]
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

- (void)awakeFromNib
{
	[[NSApplication sharedApplication] setDelegate:self];
	seconds = 15*60;
	[self setRemainingTime:seconds];
}

- (void)setRemainingTime:(int)seconds
{
	
}

- (void)timerFunc
{
	seconds = seconds - 1;
	if (seconds <= 0)
	{
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}

- (IBAction)start:(id)sender
{
	timer = [NSTimer timerWithTimeInterval: 1.0f
									target: self
								  selector: @selector (timerFunc:)
								  userInfo: nil
								   repeats: YES];	
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
