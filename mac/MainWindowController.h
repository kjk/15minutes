#import <Cocoa/Cocoa.h>

@interface MyLabel : NSTextField {
	NSTrackingRectTag	trackingTag_;
	int					seconds_;
}
@end

@interface MainWindowController : NSObject {
	IBOutlet NSWindow *		window_;

	IBOutlet MyLabel *		text5min_;
	IBOutlet MyLabel *		text15min_;
	IBOutlet MyLabel *		text30min_;
	IBOutlet MyLabel *		text1hr_;

	IBOutlet NSTextField *	textTime_;

	IBOutlet NSButton *		buttonStart_;
    IBOutlet NSButton *     buttonOk_;
    IBOutlet NSButton *     buttonPauseResume_;
	IBOutlet NSButton *		buttonStop_;

	NSTimer *				timer_;
    NSDate *                startTime_;
    NSTimeInterval          prevPassed_;
	NSTimeInterval			totalTime_;
    int                     defaultTime_;
    BOOL                    paused_;
}

- (NSNumber*)timeFontSize;

- (IBAction)fiveMinutes:(id)sender;
- (IBAction)fifteenMinutes:(id)sender;
- (IBAction)thirtyMinutes:(id)sender;
- (IBAction)sixtyMinutes:(id)sender;
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)pauseResume:(id)sender;
- (IBAction)ok:(id)sender;

@end
