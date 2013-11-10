/**
 * Neon Clockwork screen saver for OS X Mavericks.
 *
 * @author Matěj Kašpar Jirásek http://mkj.is
 * @version 1.0
 * @see https://github.com/mkj-is/NeonClockworkSaver
 *
 */

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
