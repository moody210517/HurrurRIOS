//
//  PickAddressProfileViewController.h
//  Logistika
//
//  Created by BoHuang on 4/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "BorderTextField.h"
@interface PickAddressProfileViewController : BasicViewController
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickAddress;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickCity;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickState;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickPincode;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickPhone;
@property (weak, nonatomic) IBOutlet BorderTextField *txtPickLandMark;
@property (weak, nonatomic) IBOutlet BorderTextField *txtArea;

@property (weak, nonatomic) IBOutlet UISwitch *swSelect;

@property (copy, nonatomic) NSString* type;
@end
