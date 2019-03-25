//
//  MenuViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "CGlobal.h"
#import "LeftView.h"
#import "UIView+Property.h"

#import "AboutUsViewController.h"
#import "CameraOrderTableViewCell.h"
#import "CancelPickViewController.h"
#import "ContactUsViewController.h"
#import "CorMainViewController.h"
#import "FeedBackViewController.h"
#import "MainViewController.h"
#import "OrderHisCorViewController.h"
#import "OrderHistoryViewController2.h"
#import "PersonalMainViewController.h"
#import "PolicyViewController.h"
#import "ProfileViewController.h"
#import "QuoteCorViewController.h"
#import "QuoteViewController.h"
#import "RescheduleViewController.h"
#import "SelectItemViewController.h"
#import "SelectPackageViewController.h"
#import "SignupViewController.h"
#import "TrackingCorViewController.h"
#import "TrackingViewController.h"
#import "NetworkParser.h"
#import "TrackMapViewController.h"
#import "Logistika-Swift.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [CGlobal initMenu:self];
    [self.topBarView customLayout:self];
    
    LeftView* leftView = self.view.drawerView;
    if ([self isKindOfClass:[ProfileViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[0]];
    }else if ([self isKindOfClass:[QuoteViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[1]];
    }else if ([self isKindOfClass:[QuoteCorViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[1]];
    }else if ([self isKindOfClass:[OrderHisCorViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[2]];
    }else if ([self isKindOfClass:[OrderHistoryViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[2]];
    }else if ([self isKindOfClass:[RescheduleViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[3]];
    }else if ([self isKindOfClass:[CancelPickViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[4]];
    }else if ([self isKindOfClass:[AboutUsViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[4]];
    }else if ([self isKindOfClass:[ContactUsViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[5]];
    }else if ([self isKindOfClass:[FeedBackViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[6]];
    }else if ([self isKindOfClass:[PolicyViewController class]]) {
        [leftView setCurrentMenu:c_menu_title[7]];
    }else {
        [leftView setCurrentMenu:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.topBarView updateCaption];
    self.navigationController.navigationBar.hidden = true;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
