//
//  ConfirmBar.h
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDrawerLayout.h"

@interface ConfirmBar : UIView
@property(nonatomic,weak) IBOutlet NSLayoutConstraint* constraint_Height;

@property(nonatomic,weak) IBOutlet UILabel* caption;
@property(nonatomic,weak) IBOutlet UIImageView* imgMenu;
@property(nonatomic,weak) IBOutlet UIImageView* imgHome;

@property(nonatomic,weak) IBOutlet UIButton* btnMenu;
@property(nonatomic,weak) IBOutlet UIButton* btnHome;

@property(nonatomic,strong) ECDrawerLayout* drawerLayout;
@property(nonatomic,strong) UIViewController* vc;

-(void)customLayout:(UIViewController*)vc;

-(void)updateCaption;
@end
