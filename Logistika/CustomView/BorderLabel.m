//
//  BorderLabel.m
//  JellyRole
//
//  Created by BoHuang on 3/23/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "BorderLabel.h"

@implementation BorderLabel

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
        case 3:{
            // red border
            self.layer.borderColor = [UIColor redColor].CGColor;
            self.backgroundColor = [UIColor whiteColor];
            break;
        }
        case 2:{
            // black border
            self.layer.borderColor = [UIColor blackColor].CGColor;
            self.backgroundColor = [UIColor whiteColor];
            break;
        }
        case 1:{
            // white border
            self.layer.borderColor = [UIColor whiteColor].CGColor;
            self.backgroundColor = [UIColor whiteColor];
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
-(void)setBorderWidth:(CGFloat)borderWidth{
    if (borderWidth>0) {
        self.layer.borderWidth = borderWidth;
        self.layer.masksToBounds = true;
    }else{
        self.layer.borderWidth = 0;
        self.layer.masksToBounds = true;
    }
}
-(void)setCornerRadious:(CGFloat)cornerRadious{
    if (cornerRadious>0) {
        self.layer.cornerRadius = cornerRadious;
        self.layer.masksToBounds = true;
    }
    _cornerRadious = cornerRadious;
}
@end
