
#import "NeonClockworkView.h"
#import "NSUserDefaults+ColorSupport.h"

@implementation NeonClockworkView

static NSString * const ModuleName = @"is.mkj.neonclockworksaver";

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
	self = [super initWithFrame:frame isPreview:isPreview];

	if (self) 
	{
		ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];

	    [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSUserDefaults dataForColor:[NSColor colorWithCalibratedRed:0.976 green:0.000 blue:0.627 alpha:1]], @"seconds",
                                        [NSUserDefaults dataForColor:[NSColor colorWithCalibratedRed:0.624 green:0.000 blue:0.996 alpha:1]], @"minutes",
                                        [NSUserDefaults dataForColor:[NSColor colorWithCalibratedRed:0.208 green:0.616 blue:0.996 alpha:1]], @"hours",
                                        [NSUserDefaults dataForColor:[NSColor blackColor]], @"background", nil]];
        
		[self setAnimationTimeInterval:1.0];
	}
	
	return self;
}

- (void)animateOneFrame
{
    ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
    
    // Define some variables for convenient computing
    NSSize size = [self bounds].size;
    NSPoint center = NSMakePoint(size.width/2, size.height/2);
    NSBezierPath *path;
    
    // Redraw background
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    NSBezierPath *background = [NSBezierPath bezierPathWithRect:rect];
    [[defaults colorForKey:@"background"] set];
    [background fill];
    
    // Get the time (will be used for angle)
    NSDate *time = [NSDate date];
    int seconds, minutes, hours;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"s"];
    seconds = [[dateFormatter stringFromDate:time] intValue];
    [dateFormatter setDateFormat:@"m"];
    minutes = [[dateFormatter stringFromDate:time] intValue];
    [dateFormatter setDateFormat:@"H"];
    hours = [[dateFormatter stringFromDate:time] intValue];
    int morning = 1;
    if (hours > 12)
    {
        hours = hours - 12;
        morning = 0;
    }
    if (minutes % 2 == 1 && seconds == 0)
    {
        seconds = 60;
    }
    if (hours % 2 == 1 && minutes == 0)
    {
        minutes = 60;
    }
    
    // Draw seconds
    [[defaults colorForKey:@"seconds"] set];
    path = [[NSBezierPath alloc] init];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: size.height/4
                                 startAngle: 90
                                   endAngle: 90-seconds*6
                                  clockwise: minutes % 2 == 0 || seconds == 60 ? 1 : 0];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: ((size.height/4)/3.5)*2.5
                                 startAngle: 90-seconds*6
                                   endAngle: 90
                                  clockwise: minutes % 2 == 0 || seconds == 60 ? 0 : 1];
    [path fill];
    
    // Draw minutes
    [[defaults colorForKey:@"minutes"] set];
    path = [[NSBezierPath alloc] init];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: ((size.height/4)/3.5)*2.5
                                 startAngle: 90
                                   endAngle: 90-minutes*6
                                  clockwise: hours % 2 == 0 || minutes == 60 ? 1 : 0];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: ((size.height/4)/3.5)*1.5
                                 startAngle: 90-minutes*6
                                   endAngle: 90
                                  clockwise: hours % 2 == 0 || minutes == 60 ? 0 : 1];
    [path fill];
    
    // Draw minutes
    [(NSColor *)[defaults colorForKey:@"hours"] set];
    path = [[NSBezierPath alloc] init];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: ((size.height/4)/3.5)*1.5
                                 startAngle: 90
                                   endAngle: 90-hours*30
                                  clockwise: morning];
    [path appendBezierPathWithArcWithCenter: center
                                     radius: ((size.height/4)/3.5)*0.5
                                 startAngle: 90-hours*30
                                   endAngle: 90
                                  clockwise: morning == 1 ? 0 : 1];
    [path fill];
}

- (BOOL)hasConfigureSheet
{
	return YES;
}

- (NSWindow *)configureSheet
{

	if (!configSheet)
	{
		
        if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
		{
			NSLog( @"Failed to load configure sheet." );
			NSBeep();
            return nil;
		}
	}
    
    ScreenSaverDefaults *defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
    
    secondsColor.color = [defaults colorForKey:@"seconds"];
    minutesColor.color = [defaults colorForKey:@"minutes"];
    hoursColor.color = [defaults colorForKey:@"hours"];
    backgroundColour.color = [defaults colorForKey:@"background"];
	
	return configSheet;
}

- (IBAction)cancelClick:(id)sender
{
	[[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction)okClick:(id)sender
{
	ScreenSaverDefaults *defaults;

	defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
                        
	// Update our defaults
	[defaults setColor:secondsColor.color forKey:@"seconds"];
    [defaults setColor:minutesColor.color forKey:@"minutes"];
    [defaults setColor:hoursColor.color forKey:@"hours"];
    [defaults setColor:backgroundColour.color forKey:@"background"];
	 
	// Save the settings to disk
	[defaults synchronize];
	 
	// Close the sheet
	[[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction)defaultsClicked:(id)sender
{
    ScreenSaverDefaults *defaults;
    
	defaults = [ScreenSaverDefaults defaultsForModuleWithName:ModuleName];
    
    [defaults removeObjectForKey:@"seconds"];
    [defaults removeObjectForKey:@"minutes"];
    [defaults removeObjectForKey:@"hours"];
    [defaults removeObjectForKey:@"background"];
    
    [defaults synchronize];
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction)linkClicked:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://mkj.is"]];
}

@end
