//
//  OrderFrameContainer.m
//  Logistika
//
//  Created by BoHuang on 7/11/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "OrderFrameContainer.h"
#import "OrderFrameExpand.h"
#import "OrderFrameSmall.h"

@implementation OrderFrameContainer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)addMyView:(UIView*)sender{
    if(sender == nil){
        return;
    }
    if([self.vc_Small superview]!=nil){
        [self.vc_Small removeFromSuperview];
    }
    if([self.vc_Expand superview]!=nil){
        [self.vc_Expand removeFromSuperview];
    }
    
    UIView* insertingView = sender;
    UIView* targetView = self;
    
    [targetView addSubview:insertingView];
    NSLayoutConstraint *topConst = [NSLayoutConstraint constraintWithItem:insertingView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    
    NSLayoutConstraint *leadingConst = [NSLayoutConstraint constraintWithItem:insertingView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *trailingConst = [NSLayoutConstraint constraintWithItem:insertingView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    
    insertingView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:[[NSArray alloc] initWithObjects:topConst, leadingConst,trailingConst, nil]];
    
    if ([sender isKindOfClass:[OrderFrameSmall class]]) {
        OrderFrameSmall* fContent = (OrderFrameSmall*)sender;
       
        
        if (fContent.original_data == nil) {
            [fContent firstProcess:self.original_data];
        }
         self.constraint_Container_Height.constant = fContent.constraint_Height.constant;
    }else if ([sender isKindOfClass:[OrderFrameExpand class]]) {
        OrderFrameExpand* fContent = (OrderFrameExpand*)sender;
        
        
        if (fContent.original_data == nil) {
            [fContent firstProcess:self.original_data];
        }
        self.constraint_Container_Height.constant = fContent.constraint_Height.constant;
    }
    _vc_Current = sender;
}
@end
