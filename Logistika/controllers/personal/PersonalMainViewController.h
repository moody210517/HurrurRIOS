//
//  PersonalMainViewController.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "ColoredView.h"


@interface PersonalMainViewController : MenuViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet ColoredView *btnContinue;
@property (weak, nonatomic) IBOutlet UITextField *txtCholocate;
@property (weak, nonatomic) IBOutlet UIButton *btnRealContinue;
@property (weak, nonatomic) IBOutlet UIView *layer1;
@property (weak, nonatomic) IBOutlet UIView *layer2;
@property (weak, nonatomic) IBOutlet UIView *blinkingView;

@end
