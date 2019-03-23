//
//  CameraOrderViewController.h
//  Logistika
//
//  Created by BoHuang on 4/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionDelegate.h"
#import "OrderModel.h"
#import "MenuViewController.h"
#import "UIUnderlinedButton.h"

@interface CameraOrderViewController : MenuViewController<ActionDelegate,UITableViewDelegate,UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UIStackView *stackContent;
@property (strong,nonatomic) OrderModel* cameraOrderModel;

@property (strong, nonatomic) NSMutableArray* views;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *btnUploadMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;

@property (weak, nonatomic) IBOutlet UIView *viewExceed;
@property (weak, nonatomic) IBOutlet UILabel *lblExceed;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
