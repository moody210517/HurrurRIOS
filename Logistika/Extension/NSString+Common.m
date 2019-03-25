//
//  NSString+Common.m
//  SchoolApp
//
//  Created by TwinkleStar on 11/29/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSString+Common.h";
@implementation NSString (Common)
-(BOOL)isBlank {
    if([[self stringByStrippingWhitespace] isEqualToString:@""])
        return YES;
    return NO;
}

-(BOOL)contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return (range.location != NSNotFound);
}

-(NSString *)stringByStrippingWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to {
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}
-(NSString *)removeLastString{
    if ([self isBlank]) {
        return @"";
    }
    NSInteger count = [self length] -1;
    return [self substringToIndex:count];
}
@end