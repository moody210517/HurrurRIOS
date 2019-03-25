//
//  InfoView1.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "InfoView1.h"

@implementation InfoView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGFloat)getHeight{
    
    CGRect scRect = [[UIScreen mainScreen] bounds];
    scRect.size.width = MIN(scRect.size.width -32,320);
    scRect.size.height = 20;
    
    CGSize size = [self.stackRoot systemLayoutSizeFittingSize:scRect.size withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityDefaultLow];
    //        NSLog(@"widthwidth %f height %f",size.width,size.height);
    
    NSLog(@"height estimated %f",size.height);
    
    return size.height;
}
@end
