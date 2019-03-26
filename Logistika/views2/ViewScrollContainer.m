//
//  ViewScrollContainer.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ViewScrollContainer.h"

@implementation ViewScrollContainer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)firstProcess{
    self.views = [[NSMutableArray alloc] init];
    self.bouncesZoom = false;
    self.alwaysBounceVertical = false;
    self.alwaysBounceHorizontal = false;
    self.bounces = false;
}
-(void)addOneView:(UIView*)view{
    [self.stackView addArrangedSubview:view];
    [self.views addObject:view];
    
    self.bouncesZoom = false;
    self.alwaysBounceVertical = false;
    self.alwaysBounceHorizontal = false;
    self.bounces = false;
}
-(void)setCellSpace:(CGFloat)space{
    
}
@end
