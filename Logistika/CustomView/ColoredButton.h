//
//  ColoredButton.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ColoredButton : UIButton
@property (nonatomic) IBInspectable NSInteger level;
@property (nonatomic) IBInspectable NSInteger backMode;
@property (nonatomic) IBInspectable CGFloat cornerRadious;

@property (nonatomic) IBInspectable UIColor* cl_highLight;
@property (nonatomic) IBInspectable UIColor* cl_Primary;

@property (nonatomic) IBInspectable CGFloat msize;
@property (nonatomic) IBInspectable CGFloat bsize;
@property (nonatomic) IBInspectable CGFloat osize;
@end
