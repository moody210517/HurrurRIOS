//
//  PickAddressProfileViewController.m
//  Logistika
//
//  Created by BoHuang on 4/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PickAddressProfileViewController.h"
#import "CGlobal.h"

@interface PickAddressProfileViewController ()

@end

@implementation PickAddressProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.swSelect setOn:false];
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    
    EnvVar*env = [CGlobal sharedId].env;
    _txtPickAddress.text = env.address1;
    _txtPickCity.text = env.city;
    _txtPickState.text = env.state;
    _txtPickPincode.text = env.pincode;
    _txtPickLandMark.text = env.landmark;
    _txtPickPhone.text = env.phone;
    _txtArea.text = env.address2;
    
    NSArray* fields = @[self.txtPickAddress,self.txtPickCity,self.txtPickState,self.txtPickPincode,self.txtPickPhone,self.txtPickLandMark,self.txtArea];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 35);
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        [field addBotomLayer:frame];
    }
    [self.txtPickPincode setKeyboardType:UIKeyboardTypeNumberPad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickContinue:(id)sender {
    if ([self.swSelect isOn]) {
        // pickup
        NSDictionary* data = @{@"type":self.type
                               ,@"address":_txtPickAddress.text
                               ,@"city":_txtPickCity.text
                               ,@"state":_txtPickState.text
                               ,@"pincode":_txtPickPincode.text
                               ,@"landmark":_txtPickLandMark.text
                               ,@"phone":_txtPickPhone.text
                               ,@"area":_txtArea.text};
        [[NSNotificationCenter defaultCenter] postNotificationName:GLOBALNOTIFICATION_ADDRESSPICKUP object:data];
        
        [self.navigationController popViewControllerAnimated:true];
    }else{
        // no pickup
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
