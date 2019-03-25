//
//  PaymentViewController.h
//  Logistika
//
//  Created by BoHuang on 4/24/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "PayUManager.h"

@interface PaymentViewController : BasicViewController

@property (weak, nonatomic) IBOutlet UIButton *btnPickOrder;
@property (weak, nonatomic) IBOutlet UITextField *txtPaymentCard;
//@property (weak, nonatomic) IBOutlet UIView *sprVPaymentSelection;

@end
