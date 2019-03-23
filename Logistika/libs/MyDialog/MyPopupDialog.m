//
//  MyPopupDialog.m
//  SchoolApp
//
//  Created by TwinkleStar on 11/28/15.
//  Copyright © 2015 apple. All rights reserved.
//

#import "MyPopupDialog.h"
#import "UIView+Property.h"

@implementation MyPopupDialog

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setup:(UIView*) view backgroundDismiss:(BOOL) dismiss backgroundColor:(UIColor*) color {
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = YES;
    
    view.xo = self;
    _contentview = view;
//    _contentview.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
    _contentview.center = self.center;
    [self addSubview:_contentview];
    
    _backgroundview = [[UIView alloc]initWithFrame:frame];
    _backgroundview.alpha = 0.0;
    _backgroundview.backgroundColor = color;
    
    [self insertSubview:_backgroundview belowSubview:_contentview];
    
    if(dismiss){
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickView:)];
        [_backgroundview addGestureRecognizer:gesture];
    }
}
-(void)setupForFullScreen:(UIView*)view Frame:(CGRect)rect{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = YES;
    
    view.xo = self;
    _contentview = view;
    [self addSubview:_contentview];
    _contentview.frame = rect;
    
    
    _backgroundview = [[UIView alloc]initWithFrame:frame];
    _backgroundview.backgroundColor = [UIColor clearColor];
    _backgroundview.alpha = 0.0;
//    _backgroundview.backgroundColor = [CGlobal colorWithHexString:@"231f20" Alpha:1.0];
//    _backgroundview.backgroundColor = [UIColor purpleColor];
    
    [self insertSubview:_backgroundview belowSubview:_contentview];
    
    UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ClickView:)];
    gesture.direction = UISwipeGestureRecognizerDirectionUp;
//    gesture.direction = UISwipeGestureRecognizerDirectionUp;
    [_backgroundview addGestureRecognizer:gesture];
    _backgroundview.userInteractionEnabled = true;
}
-(void)setLayout:(CGSize) rect{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.frame = frame;
    _contentview.frame = CGRectMake(0, 0, rect.width, rect.height);
    _contentview.center = self.center;
    
    _backgroundview.frame = frame;
    
//    [self layoutIfNeeded];
}
-(void)handleGesture:(UISwipeGestureRecognizer*)gesture{
    [self dismissPopup];
}
-(void) ClickView:(id) sender{
    [self dismissPopup];
}
-(void)showPopup:(UIView*) root{
    [root addSubview:self];
    [self showAnimation];
    _isShowing = true;
}

-(void)showAnimation{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundview.alpha = 0.2;
    }];
}
-(void)dismissPopup{
    [self removeFromSuperview];
    _isShowing = false;
}
@end
