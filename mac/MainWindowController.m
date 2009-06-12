#import "MainWindowController.h"

@implementation MyLabel

- (void)mouseEntered:(NSEvent *)theEvent
{
	[self setBackgroundColor:[NSColor blueColor]];
}

- (void)mouseExited:(NSEvent *)theEvent
{
	[self setBackgroundColor:[NSColor windowFrameColor]];
}

@end

@implementation MainWindowController

- (void)awakeFromNib
{
	[[NSApplication sharedApplication] setDelegate:self];
	[window setAcceptsMouseMovedEvents:YES];
	[window setAcceptsMouse
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
