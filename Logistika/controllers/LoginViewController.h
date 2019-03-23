//
//  LoginViewController.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "BorderTextField.h"

@interface LoginViewController : BasicViewController
@property (weak, nonatomic) IBOutlet BorderTextField *txtUsername;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;

@property (assign, nonatomic) NSInteger segIndex;
@end
