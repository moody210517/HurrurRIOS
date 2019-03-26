//
//  DateTimeViewController.h
//  Logistika
//
//  Created by BoHuang on 4/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "BorderView.h"
#import "BorderTextField.h"
#import "ColoredView.h"


@interface DateTimeViewController : BasicViewController
@property (weak, nonatomic) IBOutlet ColoredView *viewPrice1;
@property (weak, nonatomic) IBOutlet ColoredView *viewPrice2;
@property (weak, nonatomic) IBOutlet ColoredView *viewPrice3;

@property (weak, nonatomic) IBOutlet ColoredView *viewPrice1_b;
@property (weak, nonatomic) IBOutlet ColoredView *viewPrice2_b;
@property (weak, nonatomic) IBOutlet ColoredView *viewPrice3_b;

@property (weak, nonatomic) IBOutlet UILabel *lblEstimatedPickup;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice1_1;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice1_2;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice1_3;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice2_1;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice2_2;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice2_3;

@property (weak, nonatomic) IBOutlet UILabel *lblPrice3_1;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice3_2;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice3_3;

@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtTime;
@property (weak, nonatomic) IBOutlet UIButton *btnReview;

@property (weak, nonatomic) IBOutlet UIView *viewExpress;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *const_EMAIL_TOP;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *const_MAIN_TOP;
@property (weak, nonatomic) IBOutlet BorderTextField *txtEmailAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblEstimatedPickLabel;

@end



