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
    IBOutlet NSButton *     buttonPauseResume_;
	IBOutlet NSButton *		buttonStop_;
    
    NSFont *                timeFont_;
	
	NSTimer *				timer_;
    NSDate *                startTime_;
	int						seconds_;
}

- (NSFont*)timeFont;

- (IBAction)fiveMinutes:(id)sender;
- (IBAction)fifteenMinutes:(id)sender;
- (IBAction)thirtyMinutes:(id)sender;
- (IBAction)sixtyMinutes:(id)sender;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)pauseResume:(id)sender;

@end
