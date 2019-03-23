//
//  PaymentViewController.h
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"

@interface tmpPaymentViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgCard;

@property (weak, nonatomic) IBOutlet UIButton *btnPickOrder;
@property (weak, nonatomic) IBOutlet UIView *viewPayment;

@property (weak, nonatomic) IBOutlet UITextField *txtPaymentCard;
@property (weak, nonatomic) IBOutlet UITextField *txtCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtMM;
@property (weak, nonatomic) IBOutlet UITextField *txtYYYY;
@property (weak, nonatomic) IBOutlet UITextField *txtCVC;
@end
