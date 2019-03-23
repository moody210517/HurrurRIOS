//
//  ColoredButton.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredButton.h"
#import "CGlobal.h"
@implementation ColoredButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        //[self customInit];
    }
    return self;
}
-(void)setHighlighted:(BOOL)highlighted{
    switch (_backMode) {
        default:
            if(_backMode>=6){
                if(highlighted) {
                    self.backgroundColor = self.cl_highLight;
                } else {
                    self.backgroundColor = self.cl_Primary;
                }
                
            }
            break;
        case 12:
        case 5:
            if(highlighted) {
                self.backgroundColor = [UIColor lightGrayColor];
            } else {
                self.backgroundColor = COLOR_PRIMARY;
            }
//            UIView* shadowView = self;
//            [shadowView.layer setCornerRadius:0.0f];
//            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//            [shadowView.layer setBorderWidth:0.0f];
//            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
//            [shadowView.layer setShadowOpacity:1.0];
//            [shadowView.layer setShadowRadius:5.0];
//            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            break;
        
    }
    [super setHighlighted:highlighted];
}
-(void)setLevel:(NSInteger)level{
    _level = level;
    switch (level) {
        case 1:{
            UIView* shadowView = self;
            [shadowView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
            break;
        }
        default:
            break;
    }
}
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 12:{
            self.backgroundColor = COLOR_PRIMARY;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            
            
            UIView* shadowView = self;
            shadowView.backgroundColor= COLOR_PRIMARY;
            [shadowView.layer setCornerRadius:4.0f];
            
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 4.0f)];
            shadowView.layer.masksToBounds = false;
            
            [self setTitle:[self.titleLabel.text uppercaseString] forState:UIControlStateNormal];
            break;
        }
        case 11:{
            UIColor* clr = [CGlobal colorWithHexString:@"626262" Alpha:1.0];
            [self setTitleColor:clr forState:UIControlStateNormal];
            break;
        }
        case 10:{
            // ORDER HISTORY RESCHEDULE PICKUP BUTTON
            self.cl_Primary = [CGlobal colorWithHexString:@"620b94" Alpha:1.0];
            self.cl_highLight = [UIColor lightGrayColor];
            
            UIView* shadowView = self;
            shadowView.backgroundColor= self.cl_Primary;
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:2.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            shadowView.layer.masksToBounds = false;
            
            self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.textAlignment = UITextAlignmentCenter;
            break;
        }
        case 9:{
            // ORDER HISTORY CANCEL BUTTON
            self.cl_Primary = [CGlobal colorWithHexString:@"b54d00" Alpha:1.0];
            self.cl_highLight = [UIColor lightGrayColor];
            
            UIView* shadowView = self;
            shadowView.backgroundColor= self.cl_Primary;
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:2.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            shadowView.layer.masksToBounds = false;
            break;
        }
        case 8:{
            // ORDER HISTORY TRACK BUTTON
            self.cl_Primary = [CGlobal colorWithHexString:@"1786ff" Alpha:1.0];
            self.cl_highLight = [UIColor lightGrayColor];
            
            UIView* shadowView = self;
            shadowView.backgroundColor= self.cl_Primary;
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            shadowView.layer.masksToBounds = false;
            break;
        }
        case 7:{
            // DASHBOARD I WANT ORDER
            self.cl_Primary = [CGlobal colorWithHexString:@"FFCC00" Alpha:1.0f];
            self.cl_highLight = [UIColor lightGrayColor];
            
            UIView* shadowView = self;
            shadowView.backgroundColor= self.cl_Primary;
            [shadowView.layer setCornerRadius:20.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            shadowView.layer.masksToBounds = false;
            break;
        }
        case 6:{
            // DASHBOARD I WANT SEND
            self.cl_Primary = [CGlobal colorWithHexString:@"c1c1c1" Alpha:1.0f];
            self.cl_highLight = [UIColor lightGrayColor];
            
            UIView* shadowView = self;
            shadowView.backgroundColor= self.cl_Primary;
            [shadowView.layer setCornerRadius:20.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            shadowView.layer.masksToBounds = false;
            break;
        }
        case 5:{
            // NORMAL PRIMARY BUTTON WITH CLICK HIGHLIGHT
            self.backgroundColor = COLOR_PRIMARY;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
            
            
            UIView* shadowView = self;
            shadowView.backgroundColor= COLOR_PRIMARY;
            [shadowView.layer setCornerRadius:8.0f];
            
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            shadowView.layer.masksToBounds = false;
            
            if(self.level == 1){
                // back white
                [shadowView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
            }else{
                // back other something
                [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            }
            
            [self setTitle:[self.titleLabel.text uppercaseString] forState:UIControlStateNormal];
            break;
        }
        case 4:{
            // Sign in button
            self.backgroundColor = [CGlobal colorWithHexString:@"6f7575" Alpha:1.0f];
            [self setTitleColor:[CGlobal colorWithHexString:@"ffffff" Alpha:1.0f] forState:UIControlStateNormal];
            // set font
            
            UIFont* font = [UIFont fontWithName:@"Verdana-Bold" size:15];
            self.titleLabel.font = font;
            break;
        }
        case 3:{
            // bottom banner button
            self.backgroundColor = COLOR_PRIMARY;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            UIFont* font = [UIFont boldSystemFontOfSize:17.5];
            self.titleLabel.font = font;
            
            [self setTitle:[self.titleLabel.text uppercaseString] forState:UIControlStateNormal];
            break;
        }
        case 1:{
            // Sign in button
            self.backgroundColor = [CGlobal colorWithHexString:@"d3d3d3" Alpha:1.0f];
            [self setTitleColor:[CGlobal colorWithHexString:@"2f4f4f" Alpha:1.0f] forState:UIControlStateNormal];
            // set font
            UIFont* font = [UIFont fontWithName:@"Verdana" size:15];
            self.titleLabel.font = font;
            
            self.titleLabel.text = [self.titleLabel.text uppercaseString];
            break;
        }
        case 2:{
            // review order white textcolor primary back
            self.backgroundColor = COLOR_PRIMARY;
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            break;
        }
        default:
        {
            
            break;
        }
    }
    _backMode = backMode;
}
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
-(void)setMsize:(CGFloat)msize{
    if (msize > 0) {
        //        UIFont* font = [UIFont boldSystemFontOfSize:msize];
        //        self.font = font;
        UIFont* font = [UIFont fontWithName:@"Verdana" size:msize];
        self.font = font;
    }
}
-(void)setBsize:(CGFloat)bsize{
    if (bsize > 0) {
        UIFont* font = [UIFont fontWithName:@"Verdana-Bold" size:bsize];
        self.font = font;
    }
}
-(void)setOsize:(CGFloat)osize{
    if (osize > 0) {
        UIFont* font = [UIFont fontWithName:@"Orbitron-Medium" size:osize];
        self.font = font;
    }
}
@end
