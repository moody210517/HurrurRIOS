//
//  MenuItem.m
//  Logistika
//
//  Created by BoHuang on 6/8/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuItem.h"
#import "CGlobal.h"
@implementation MenuItem

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
            // selected
            self.backgroundColor = [CGlobal colorWithHexString:@"000000" Alpha:0.6];
            self.lblTitle.textColor = [CGlobal colorWithHexString:@"008080" Alpha:1.0];
            self.backgroundColor = [CGlobal colorWithHexString:@"aaaaaa" Alpha:0.5];
            break;
        }
        default:{
            self.backgroundColor = [CGlobal colorWithHexString:@"000000" Alpha:0.8];
            self.lblTitle.textColor = [CGlobal colorWithHexString:@"ffffff" Alpha:1.0];
            self.backgroundColor = [UIColor clearColor];
            break;
        }
    }
    [self customInit];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self customInit];
    }
    return self;
}
-(void)customInit{
    if (self.lblTitle!=nil) {
        self.lblTitle.bsize = 15;
    }
}
@end
