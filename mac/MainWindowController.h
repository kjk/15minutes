#import <Cocoa/Cocoa.h>

@interface MyLabel : NSTextField {
	
	
}

/*
- (void)mouseEntered:(NSEvent *)theEvent;
- (void)mouseExited:(NSEvent *)theEvent;
*/

@end

@interface MainWindowController : NSObject {
	IBOutlet NSWindow *	window;
	IBOutlet MyLabel *	text5min;
	IBOutlet MyLabel *	text15min;
	IBOutlet MyLabel *	text30min;
	IBOutlet MyLabel *	text1hr;

	IBOutlet NSTextField *	textTime;

	IBOutlet NSButton *		buttonStart;
	IBOutlet NSButton *		buttonStop;
	IBOutlet NSButton *		butttonResume;
}

- (IBAction)start:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)stop:(id)sender;

@end
