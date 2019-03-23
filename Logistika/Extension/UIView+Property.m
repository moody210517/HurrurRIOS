//
//  UIView+Property.m
//  JellyRole
//
//  Created by BoHuang on 3/24/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import "UIView+Property.h"
#import <objc/runtime.h>
@implementation UIView (Property)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setXo:(UIView *)xo{
    objc_setAssociatedObject(self, @"kDHStyleKey", xo, OBJC_ASSOCIATION_RETAIN);
}
- (UIView*)xo
{
    return objc_getAssociatedObject(self, @"kDHStyleKey");
}
-(void)setDrawerView:(LeftView *)drawerView{
    objc_setAssociatedObject(self, @"drawerView", drawerView, OBJC_ASSOCIATION_RETAIN);
}
-(LeftView*)drawerView{
    return objc_getAssociatedObject(self, @"drawerView");
}
-(void)setDrawerLayout:(ECDrawerLayout *)drawerLayout{
    objc_setAssociatedObject(self, @"drawerLayout", drawerLayout, OBJC_ASSOCIATION_RETAIN);
}
-(ECDrawerLayout*)drawerLayout{
    return objc_getAssociatedObject(self, @"drawerLayout");
}
@end




