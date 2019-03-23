//
//  MyBaseView.m
//  Burped
//
//  Created by BoHuang on 6/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyBaseView.h"

@implementation MyBaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setData:(NSDictionary*)data{
    self.inputData = data;
    self.vc = data[@"vc"];
    self.aDelegate = data[@"aDelegate"];
//    self.model = data[@"model"];
    
}
@end
