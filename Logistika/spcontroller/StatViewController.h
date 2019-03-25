//
//  StatViewController.h
//  Logistika
//
//  Created by BoHuang on 9/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontLabel.h"
#import "ColoredLabel.h"


@interface StatViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;
@property (weak, nonatomic) IBOutlet FontLabel *lblLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIView *myIndicator;

@end
