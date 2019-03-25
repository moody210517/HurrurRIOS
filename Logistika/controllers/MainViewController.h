//
//  MainViewController.h
//  Logistika
//
//  Created by BoHuang on 4/18/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "MyPopupDialog.h"
#import "BorderTextField.h"
#import "FontLabel.h"

@interface MainViewController : UIViewController<ViewDialogDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (weak, nonatomic) IBOutlet BorderTextField *txtUsername;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIImageView *img_phone;

@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (copy, nonatomic) NSString* phone;
@property (weak, nonatomic) IBOutlet FontLabel *lblLabel;
@property (weak, nonatomic) IBOutlet FontLabel *lblTest;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_Width;
@property (weak, nonatomic) IBOutlet UILabel *lblTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_Username_Width;

@end
