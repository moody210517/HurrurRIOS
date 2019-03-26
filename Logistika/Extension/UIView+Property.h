//
//  UIView+Property.h
//  JellyRole
//
//  Created by BoHuang on 3/24/17.
//  Copyright © 2017 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDrawerLayout.h"
#import "LeftView.h"

@interface UIView (Property)

@property (nonatomic, strong) UIView* xo;
@property (nonatomic, strong) LeftView* drawerView;
@property (nonatomic, strong) ECDrawerLayout* drawerLayout;

@end
