//
//  MyWebView.m
//  Logistika
//
//  Created by BoHuang on 7/12/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView

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
            for (id subview in self.subviews)
                if ([[subview class] isSubclassOfClass: [UIScrollView class]]){
                    ((UIScrollView *)subview).bouncesZoom = false;
                    ((UIScrollView *)subview).alwaysBounceVertical = false;
                    ((UIScrollView *)subview).alwaysBounceHorizontal = false;
                    ((UIScrollView *)subview).bounces = false;
                    //((UIScrollView *)subview).bounces = NO;
                }
            
            break;
        }
    }
}
@end
