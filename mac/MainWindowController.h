#import <Cocoa/Cocoa.h>

@class TimeDisplayView;

@interface MainWindowController : NSObject {
	IBOutlet NSMenu *       statusItemMenu_;
    IBOutlet TimeDisplayView * timeDisplay_;

    NSStatusItem *          statusItem_;
	NSTimer *				timer_;
    NSDate *                startTime_;
	NSTimeInterval			remainingTime_;
    int                     defaultTime_;

    NSImage *               statusItemImage_;
    NSDictionary *          strFlashAttr_;

    int                     flashesRemaining_;
}

- (IBAction)start5min:(id)sender;
- (IBAction)start15min:(id)sender;
- (IBAction)start30min:(id)sender;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)pauseResume:(id)sender;

- (IBAction)ok:(id)sender;

@end
