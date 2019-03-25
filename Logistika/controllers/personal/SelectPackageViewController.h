//
//  SelectPackageViewController.h
//  Logistika
//
//  Created by BoHuang on 4/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderModel.h"
#import "UIUnderlinedButton.h"
#import "MenuViewController.h"

@interface SelectPackageViewController : MenuViewController
@property (strong,nonatomic) OrderModel* cameraOrderModel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray* views;
@property (weak, nonatomic) IBOutlet UIUnderlinedButton *btnUploadMore;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;

@property (copy, nonatomic) NSString* string;
@end
