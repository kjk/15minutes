#import <Cocoa/Cocoa.h>
#import "MAAttachedWindow.h"

@class TimeDisplayView;

@interface MyAttachedWindow : MAAttachedWindow
- (void)mouseDown:(NSEvent *)theEvent;
@end

@interface MainWindowController : NSObject {
	IBOutlet NSMenu *           statusItemMenu_;
    IBOutlet TimeDisplayView *  timeDisplay_;
    IBOutlet NSView *           timesUpView_;
    IBOutlet NSTextField *      timesUpTextField_;
    MyAttachedWindow *          attachedWindow_;

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
