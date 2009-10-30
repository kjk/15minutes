#import "TimeDisplayView.h"

@implementation TimeDisplayView

- (void)awakeFromNib
{
	fontAttributes_ = [[NSDictionary dictionaryWithObjectsAndKeys:
				   [[NSColor darkGrayColor] colorWithAlphaComponent:1.0], NSForegroundColorAttributeName, 
				   [NSFont fontWithName:@"Arial Bold" size:48], NSFontAttributeName,
				   nil] retain];
    
	seconds_ = 15*60;
}

- (void) setSeconds:(int)seconds {
    if (seconds == seconds_)
        return;
    seconds_ = seconds;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)r {
	CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextSaveGState(ctx);
    
    int minutes = seconds_ / 60;
    int seconds = seconds_ % 60;
    NSString *text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
	NSSize size = [text sizeWithAttributes:fontAttributes_];	
	NSRect rect = NSMakeRect(self.bounds.size.width / 2.0 - size.width / 2.0, 
							 self.bounds.size.height / 2.0 - size.height / 2.0, 
							 size.width, 
							 size.height);
#if 0
    float colComponents[4] = { 1.0, 1.0, 1.0, 1.0 };
    CMProfileRef prof = NULL;
    CMGetSystemProfile(&prof);
    CGColorSpaceRef rgbSpace = CGColorSpaceCreateWithPlatformColorSpace(prof);
	CGColorRef shadowCol = CGColorCreate(rgbSpace, colComponents);
	CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 5.0, shadowCol);
	CGColorRelease(shadowCol);
#endif

	[text drawInRect:rect withAttributes:fontAttributes_];
    
	CGContextRestoreGState(ctx);
}

- (void) dealloc {
	[fontAttributes_ release];
	[super dealloc];
}

@end
