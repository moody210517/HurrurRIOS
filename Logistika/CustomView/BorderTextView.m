//
//  BorderTextView.m
//  Logistika
//
//  Created by BoHuang on 6/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BorderTextView.h"
#import "CGlobal.h"

@implementation BorderTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
            
        case 1:{
            // only bottom border
            if (_bottomLine==nil) {
                CALayer *border = [CALayer layer];
                CGFloat borderWidth = g_txtBorderWidth;
                border.borderColor = [UIColor darkGrayColor].CGColor;
                CGRect frame =CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height);
                border.frame = frame;
                border.borderWidth = borderWidth;
                [self.layer addSublayer:border];
                self.layer.masksToBounds = YES;
                
                
                _bottomLine = border;
                self.delegate = self;
            }
            
            break;
        }
        default:
        {
            break;
        }
    }
    _backMode = backMode;
}

-(void)addBotomLayer:(CGRect)param{
    if (_bottomLine!=nil) {
        [_bottomLine removeFromSuperlayer];
        _bottomLine = nil;
    }
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = g_txtBorderWidth;
    border.borderColor = [UIColor darkGrayColor].CGColor;
    CGRect frame =CGRectMake(0, param.size.height - borderWidth, param.size.width, param.size.height);
    border.frame = frame;
    border.borderWidth = borderWidth;
    [self.layer addSublayer:border];
    self.layer.masksToBounds = YES;
        
    _bottomLine = border;
    
    self.delegate = self;
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 5, 5);
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (_bottomLine != nil) {
        CALayer *border = _bottomLine;
        border.borderColor = COLOR_PRIMARY.CGColor;
        border.borderWidth = g_txtBorderWidth;
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (_bottomLine != nil) {
        CALayer *border = _bottomLine;
        border.borderColor = [UIColor lightGrayColor].CGColor;
        border.borderWidth = g_txtBorderWidth;
    }
}
@end
