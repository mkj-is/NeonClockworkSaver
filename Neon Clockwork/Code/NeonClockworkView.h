//
//  MyScreenSaverView.h
//  Cocoa Dev Central: Write a Screen Saver: Part 1
//

#import <ScreenSaver/ScreenSaver.h>

@interface NeonClockworkView : ScreenSaverView 
{
	IBOutlet id configSheet;
	IBOutlet NSColorWell *secondsColor;
	IBOutlet NSColorWell *minutesColor;
	IBOutlet NSColorWell *hoursColor;
    IBOutlet NSColorWell *backgroundColour;
}

@end
