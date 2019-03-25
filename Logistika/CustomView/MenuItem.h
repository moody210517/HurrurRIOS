//
//  MenuItem.h
//  Logistika
//
//  Created by BoHuang on 6/8/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"

@interface MenuItem : UIView

@property (nonatomic,weak) IBOutlet FontLabel* lblTitle;
@property (nonatomic) IBInspectable NSInteger backMode;

@end
