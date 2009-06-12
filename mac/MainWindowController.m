#import "MainWindowController.h"

@implementation MyLabel

- (id) initWithCoder: (NSCoder *) coder
{
	self = [super initWithCoder: coder];
	if (!self)
		return nil;

	trackingTag = 0;
		
	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];		
	[nc addObserver: self
		   selector: @selector(resetBounds:)
			   name: NSViewFrameDidChangeNotification object: nil];

    return self;
}

- (void)mouseEntered:(NSEvent *)theEvent
{
	[self setBackgroundColor:[NSColor blueColor]];
}

- (void)mouseExited:(NSEvent *)theEvent
{
	[self setBackgroundColor:[NSColor windowBackgroundColor]];
}

- (void) resetBounds: (NSNotification *) notification
{
    if (trackingTag)
        [self removeTrackingRect: trackingTag];
    trackingTag = [self addTrackingRect: [self bounds] owner: self userData: nil assumeInside: NO];
}

@end

@implementation MainWindowController

- (void)awakeFromNib
{
	[[NSApplication sharedApplication] setDelegate:self];
}

- (IBAction)start:(id)sender
{

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
