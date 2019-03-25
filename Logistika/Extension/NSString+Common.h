//
//  NSString+Common.h
//  SchoolApp
//
//  Created by TwinkleStar on 11/29/15.
//  Copyright © 2015 apple. All rights reserved.
//

#ifndef NSString_Common_h
#define NSString_Common_h


#endif /* NSString_Common_h */

@interface NSString (Common)

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;
-(NSString *)removeLastString;
@end

