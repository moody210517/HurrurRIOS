//
//  CustomScrollView.m
//  Logistika
//
//  Created by q on 3/30/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

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
            // prevent scroll outsize of content size
            // by un checking bounce
            self.bouncesZoom = false;
            self.alwaysBounceVertical = false;
            self.alwaysBounceHorizontal = false;
            self.bounces = false;
            break;
        }
    }
}
@end
