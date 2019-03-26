//
//  NSUserDefaults+CustomFontAdditions.m
//  Wordpress News App
//

#import "NSUserDefaults+CustomFontAdditions.h"
#import <UIKit/UIKit.h>

NSString * const PSCustomFontsKey        = @"PSCustomFontsKey";
NSString * const PSCustomFontKeyFontName = @"PSCustomFontKeyFontName";
NSString * const PSCustomFontKeyFontSize = @"PSCustomFontKeyFontSize";

@implementation NSUserDefaults (CustomFontAdditions)

- (UIFont *)fontForKey:(NSString *)fontKey;
{
    NSDictionary *fonts = [self dictionaryForKey:PSCustomFontsKey];
    
    UIFont *font = nil;
    
    if (fonts) {
        NSDictionary *fontComponents = [fonts valueForKey:fontKey];
        
        NSString *fontName = [fontComponents valueForKey:PSCustomFontKeyFontName];
        CGFloat   size     = [[fontComponents valueForKey:PSCustomFontKeyFontSize] floatValue];
        
        font = [UIFont fontWithName:fontName size:size];
    }
    
    return font;
}

- (void)setFont:(UIFont *)font forKey:(NSString *)fontKey;
{
    NSMutableDictionary *fonts = [[self dictionaryForKey:PSCustomFontsKey] mutableCopy];
    
    if (!fonts) {
        fonts = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    
    NSDictionary *fontComponents = @{PSCustomFontKeyFontName: font.fontName,
                                    PSCustomFontKeyFontSize: @(font.pointSize)};
    
    [fonts setValue:fontComponents forKey:fontKey];
    
    [self setObject:fonts forKey:PSCustomFontsKey];
}

@end
