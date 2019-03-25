//
//  AddressChooser.m
//  Logistika
//
//  Created by kangta on 3/24/19.
//  Copyright © 2019 BoHuang. All rights reserved.
//

#import "AddressChooser.h"
#import "PickupLocationViewController.h"

@implementation AddressChooser

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnMyAddress:(id)sender {
    
}

- (IBAction)btnSelectNewAddress:(id)sender {
    if([_type isEqualToString:@"source"] == true){
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            PickupLocationViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickupLocationViewController"];
            vc.type = @"3";
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self.navigationController pushViewController:vc animated:true];
                [self.vc presentViewController:vc animated:true completion:nil];
            });
    }else{
        
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            PickupLocationViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PickupLocationViewController"];
            vc.type = @"4";
            dispatch_async(dispatch_get_main_queue(), ^{
                //[self.navigationController pushViewController:vc animated:true];
                [self.vc presentViewController:vc animated:true completion:nil];
            });
        
    }
        
}

-(void)firstProcess:(NSDictionary*)data{
    if (data!=nil) {
        self.type = data[@"type"];
        self.vc = data[@"view"];
    }
    
}

@end
