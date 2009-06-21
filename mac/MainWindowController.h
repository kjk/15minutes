#import <Cocoa/Cocoa.h>

@interface MyLabel : NSTextField 
{
	NSTrackingRectTag	trackingTag_;
	int					seconds_;
}

@end

@interface MainWindowController : NSObject
{
	IBOutlet NSWindow *		window_;

	IBOutlet MyLabel *		text5min_;
	IBOutlet MyLabel *		text15min_;
	IBOutlet MyLabel *		text30min_;
	IBOutlet MyLabel *		text1hr_;

	IBOutlet NSTextField *	textTime_;

	IBOutlet NSButton *		buttonStart_;
	IBOutlet NSButton *		buttonStop_;
	IBOutlet NSButton *		butttonResume_;
	
	NSTimer *				timer_;
    NSDate *                startTime_;
	int						seconds_;
}

- (IBAction)start:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)stop:(id)sender;

@end
