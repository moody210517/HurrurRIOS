//
//  NSUserDefaults+CustomFontAdditions.h
//  Wordpress News App
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSUserDefaults (CustomFontAdditions)

- (UIFont *)fontForKey:(NSString *)fontKey;
- (void)setFont:(UIFont *)font forKey:(NSString *)fontKey;

@end
