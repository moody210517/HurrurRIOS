//
//  UIView+Animation.h
//  Fit
//
//  Created by Twinklestar on 7/20/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)

-(void)slideInFromLeft:(NSTimeInterval) interval Delegate:(id)cDelegate Bounds:(CGRect)bound;
-(void)slideInFromRight:(NSTimeInterval) interval Delegate:(id)cDelegate Bounds:(CGRect)bound;
@end
