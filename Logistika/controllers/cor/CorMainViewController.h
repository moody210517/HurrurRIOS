//
//  CorMainViewController.h
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ColoredButton.h"
#import "GCPlaceholderTextView.h"
#import "BorderTextField.h"
#import "BorderTextView.h"

@interface CorMainViewController : MenuViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet BorderTextField *txtTruck;
@property (weak, nonatomic) IBOutlet BorderTextField *txtName;
@property (weak, nonatomic) IBOutlet BorderTextField *txtEmail;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPhone;

@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *txtBrief;
@property (weak, nonatomic) IBOutlet ColoredButton *btnAction;

@property (weak, nonatomic) IBOutlet UIView* txtBrief_bottom;
@end
