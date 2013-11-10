/**
 * Adds methods for saving and getting NSColor from/to user defaults. Based on tutorial from Apple.
 *
 * @author Matěj Kašpar Jirásek http://mkj.is
 * @see https://developer.apple.com/library/mac/documentation/cocoa/conceptual/DrawColor/Tasks/StoringNSColorInDefaults.html
 *
 */

#import <Foundation/Foundation.h>

@interface NSUserDefaults(ColorSupport)

/**
 * Saves color for key.
 *
 * @param aColor the color to be saved
 * @param aKey the key where the color will be saved
 */
- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey;

/**
 * Gets the color from user defaults.
 *
 * @param aKey the key where the color will be saved
 * @returns the color which was stored in the defaults
 */
- (NSColor *)colorForKey:(NSString *)aKey;

/**
 * Helper method for converting color into the data
 *
 * @param aColor the color to be converted
 * @returns the data for the color
 */
+ (NSData *)dataForColor:(NSColor *)aColor;

@end
