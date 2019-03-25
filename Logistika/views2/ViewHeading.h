//
//  ViewHeading.h
//  Logistika
//
//  Created by BoHuang on 6/15/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ColoredView.h"
#import "ColoredLabel.h"


@interface ViewHeading : ColoredView

@property (nonatomic,weak) IBOutlet ColoredLabel* lblTitle;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Height;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Leading;

@property (nonatomic) IBInspectable NSInteger headMode;

@property (nonatomic) IBInspectable NSInteger titleTheme;
@end
