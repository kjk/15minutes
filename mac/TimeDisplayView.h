#import <QuartzCore/QuartzCore.h>

@interface TimeDisplayView : NSView {
    NSDictionary *      fontAttributes_;
    int                 seconds_;
}

- (void)setSeconds:(int)seconds;

@end
