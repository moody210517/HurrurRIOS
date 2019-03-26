//
//  ViewHeading.m
//  Logistika
//
//  Created by BoHuang on 6/15/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ViewHeading.h"
#import "CGlobal.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@implementation ViewHeading

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setHeadMode:(NSInteger)headMode{
    switch (headMode) {
        case 1:
            _constraint_Height.constant = 30;
            _constraint_Leading.constant = 20;
            break;
        default:
            _constraint_Height.constant = 30;
            _constraint_Leading.constant = 20;
            break;
    }
    
}

-(void)setTitleTheme:(NSInteger)titleTheme{
    switch (titleTheme) {
        case 2:
            
            break;
        case 1:
            
            self.backgroundColor = COLOR_RESERVED;
            
            self.layer.cornerRadius = 8.0f;
            self.layer.masksToBounds = true;
            
            break;
            
        default:
            break;
    }
    
}
@end


