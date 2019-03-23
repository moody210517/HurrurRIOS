//
//  ReturnDelegate.m
//  Logistika
//
//  Created by q on 11/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ReturnDelegate.h"

@implementation ReturnDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
@end
