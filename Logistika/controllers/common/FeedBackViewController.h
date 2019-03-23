//
//  FeedBackViewController.h
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ColoredButton.h"
#import "GCPlaceholderTextView.h"
#import "BorderTextField.h"


@interface FeedBackViewController : MenuViewController
@property (weak, nonatomic) IBOutlet BorderTextField *txtFirst;
@property (weak, nonatomic) IBOutlet BorderTextField *txtLast;
@property (weak, nonatomic) IBOutlet BorderTextField *txtFeedback;
//@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *txtFeedback;

@property (weak, nonatomic) IBOutlet UIView *viewRoot;
@property (weak, nonatomic) IBOutlet ColoredButton *btnSubmit;
@end
