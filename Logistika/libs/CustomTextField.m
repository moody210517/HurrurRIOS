//
//  CustomTextField.m
//  ResignDate
//
//  Created by Twinklestar on 4/14/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawPlaceholderInRect:(CGRect)rect
{
    UIColor *colour = [UIColor whiteColor];
    
    if ([self.placeholder respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        // iOS7 and later
        NSDictionary *attributes = @{NSForegroundColorAttributeName: colour, NSFontAttributeName: self.font};
        CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
        if (self.textAlignment == NSTextAlignmentCenter) {
            [self.placeholder drawAtPoint:CGPointMake(rect.size.width/2-boundingRect.size.width/2, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
        }else{
            [self.placeholder drawAtPoint:CGPointMake(0, (rect.size.height/2)-boundingRect.size.height/2) withAttributes:attributes];
        }
        
    }
    else {
        // iOS 6
        [colour setFill];
        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByTruncatingTail alignment:self.textAlignment];
    }
}
@end
