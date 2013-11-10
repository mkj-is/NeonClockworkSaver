//
//  NSUserDefaults_ColorSupport.h
//  Neon Clockwork
//
//  Created by Matěj Kašpar Jirásek on 12.09.12.
//
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults(ColorSupport)

- (void)setColor:(NSColor *)aColor forKey:(NSString *)aKey;
- (NSColor *)colorForKey:(NSString *)aKey;
+ (NSData *)dataForColor:(NSColor *)aColor;

@end
