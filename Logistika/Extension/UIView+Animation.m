//
//  UIView+Animation.m
//  Fit
//
//  Created by Twinklestar on 7/20/16.
//
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)slideInFromLeft:(NSTimeInterval) interval Delegate:(id)cDelegate Bounds:(CGRect)bound{
    CATransition* slideTr = [[CATransition alloc] init];
    if (cDelegate!=nil) {
        slideTr.delegate = cDelegate;
    }
    
    slideTr.type = kCATransitionPush;
    slideTr.subtype = kCATransitionFromLeft;
    slideTr.duration = interval;
    slideTr.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    slideTr.fillMode = kCAFillModeRemoved;
    
    [self.layer addAnimation:slideTr forKey:@"slideInFromLeftTransition"];
}
-(void)slideInFromRight:(NSTimeInterval) interval Delegate:(id)cDelegate Bounds:(CGRect)bound{
    CATransition* slideTr = [[CATransition alloc] init];
    if (cDelegate!=nil) {
        slideTr.delegate = cDelegate;
    }
    
    slideTr.type = kCATransitionPush;
    slideTr.subtype = kCATransitionFromRight;
    slideTr.duration = interval;
    slideTr.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    slideTr.fillMode = kCAFillModeRemoved;
    
    [self.layer addAnimation:slideTr forKey:@"slideInFromRightTransition"];
}
@end
