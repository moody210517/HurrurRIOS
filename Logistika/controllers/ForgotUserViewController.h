//
//  ForgotUserViewController.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "BorderTextField.h"

@interface ForgotUserViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UILabel *lblLabel;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@property (weak, nonatomic) IBOutlet BorderTextField *txtAnswer;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@property (assign, nonatomic) NSInteger segIndex;

@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UIStackView *stack1;

@property (weak, nonatomic) IBOutlet UIStackView *stack2;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblReceiverPhone;
@end
