
#import "NSUserDefaults+ColorSupport.h"

@implementation NSUserDefaults (ColorSupport)

- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey
{
    [self setObject:[[self class] dataForColor:aColor] forKey:aKey];
}

- (NSColor *)colorForKey:(NSString *)aKey
{
    NSColor *theColor = nil;
    NSData *theData = [self dataForKey:aKey];
    if (theData != nil)
        theColor = (NSColor *)[NSUnarchiver unarchiveObjectWithData:theData];
    return theColor;
}

+ (NSData *)dataForColor:(NSColor *)aColor
{
    return [NSArchiver archivedDataWithRootObject:aColor];
}

@end