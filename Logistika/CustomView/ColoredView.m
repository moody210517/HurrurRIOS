//
//  ColoredView.m
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredView.h"
#import "CGlobal.h"

@implementation ColoredView

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
-(void)setBackMode:(NSInteger)backMode{
    switch (backMode) {
        case 14:{
            // orderframe small rect
            UIView* shadowView = self;
            shadowView.backgroundColor= COLOR_RESERVED;
            [shadowView.layer setCornerRadius:2.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.1f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:3.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            break;
        }
        case 13:{
//            self.backgroundColor = [UIColor redColor];
//            self.layer.masksToBounds = false;
//            self.layer.backgroundColor = [UIColor redColor].CGColor;
            self.backgroundColor = COLOR_RESERVED;
            break;
        }
        case 12:{
            // card box white for shadow panel in review order, confirmed.
            UIView* shadowView = self;
            shadowView.backgroundColor= [UIColor whiteColor];
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.1f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:8.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
//            shadowView.layer.masksToBounds = true;
            
            break;
        }
        case 11:{
            // date time pickup date time box
            UIView* shadowView = self;
            shadowView.backgroundColor= COLOR_RESERVED;
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.1f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:8.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            break;
        }
        case 10:{
            // date time exptdeted price box
            UIView* shadowView = self;
            shadowView.backgroundColor= [CGlobal colorWithHexString:@"ffffff" Alpha:1.0f];
            [shadowView.layer setCornerRadius:8.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:1.2f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:8.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 8.0f)];
            break;
        }
        case 9:{
            // card view white
            UIView* shadowView = self;
            shadowView.backgroundColor= [CGlobal colorWithHexString:@"ffffff" Alpha:1.0f];
            [shadowView.layer setCornerRadius:5.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.1f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            break;
        }
        case 8:{
            // head part yellow background
            UIView* shadowView = self;
            shadowView.backgroundColor= COLOR_SECONDARY_THIRD;
            [shadowView.layer setCornerRadius:0.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            break;
        }
        case 7:{
            // d3d3d3
            UIColor* clr = [CGlobal colorWithHexString:@"d3d3d3" Alpha:1.0f];
            self.backgroundColor = clr;
            break;
        }
        case 6:{
            // card view white
            UIView* shadowView = self;
            shadowView.backgroundColor= [CGlobal colorWithHexString:@"ffffff" Alpha:1.0f];
            [shadowView.layer setCornerRadius:5.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.1f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:5.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            break;
        }
        case 5:{
            // head part
            UIView* shadowView = self;
//            shadowView.backgroundColor= [CGlobal colorWithHexString:@"eeeeee" Alpha:1.0f];
            shadowView.backgroundColor= [CGlobal colorWithHexString:@"e9e9e9" Alpha:1.0f];
            [shadowView.layer setCornerRadius:0.0f];
            [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [shadowView.layer setBorderWidth:0.0f];
            [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
            [shadowView.layer setShadowOpacity:1.0];
            [shadowView.layer setShadowRadius:2.0];
            [shadowView.layer setShadowOffset:CGSizeMake(0.0f, 2.0f)];
            
            
            break;
        }
        case 4:{
            self.backgroundColor = [UIColor blueColor];
            break;
        }
        case 3:{
            // highlight menu view
            self.backgroundColor = [UIColor darkGrayColor];
            break;
        }
        case 2:{
            // white view
            self.backgroundColor = [CGlobal colorWithHexString:@"ffffff" Alpha:1.0f];
            break;
        }
        case 1:{
            // blue tone view
            self.backgroundColor = COLOR_PRIMARY;
            break;
        }
        default:
        {
            self.backgroundColor = [UIColor clearColor];
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
@end
