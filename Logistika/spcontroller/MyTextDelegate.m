//
//  MyTextDelegate.m
//  Logistika
//
//  Created by BoHuang on 5/16/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyTextDelegate.h"

@implementation MyTextDelegate

-(instancetype)init{
    self = [super init];
    _mode =  0;
    self.controllers = [[NSMutableArray alloc] init];
    return self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
-(void)setMode:(int)mode{
    _mode = mode;
    switch (_mode) {
        case 2:
        {
            for (int i=0; i<_controllers.count; i++) {
                UITextField* f = self.controllers[i];
                f.text = @"+91";
            }
            break;
        }
        default:
            break;
    }
}
-(void)addTextField:(UITextField*)textField{
    [self.controllers addObject:textField];
    textField.delegate = self;
}
-(BOOL)isValid:(NSString*)text{
    switch (self.mode) {
        case 2:
        {
            NSString* ppp = [text stringByReplacingOccurrencesOfString:@"+" withString:@""];
            ppp = [ppp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if (ppp.length == self.length) {
                return true;
            }
            break;
        }
        default:
            break;
    }
    return false;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (self.mode) {
        case 2:{
            if (textField.text.length <= 3) {
                if (range.location < 3) {
                    return NO;
                }
            }
        }
        case 1:{
            if (string.length + textField.text.length > self.length) {
                NSLog(@"%d",string.length + textField.text.length);
                return NO;
            }
        }
        case 0:
        {
            // allow backspace
            if (!string.length)
            {
                return YES;
            }
            
            // Prevent invalid character input, if keyboard is numberpad
            if (textField.keyboardType == UIKeyboardTypeNumberPad)
            {
                if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet].location != NSNotFound)
                {
                    // BasicAlert(@"", @"This field accepts only numeric entries.");
                    return NO;
                }
            }
            
            // verify max length has not been exceeded
            //    NSString *proposedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
            //
            //    if (proposedText.length > 4) // 4 was chosen for SSN verification
            //    {
            //        // suppress the max length message only when the user is typing
            //        // easy: pasted data has a length greater than 1; who copy/pastes one character?
            //        if (string.length > 1)
            //        {
            //            // BasicAlert(@"", @"This field accepts a maximum of 4 characters.");
            //        }
            //
            //        return NO;
            //    }
            //    
            //    // only enable the OK/submit button if they have entered all numbers for the last four of their SSN (prevents early submissions/trips to authentication server)
            //    self.answerButton.enabled = (proposedText.length == 4);
            
            return YES;
            break;
        }
            
            
        default:{
            break;
        }
            
    }
    return YES;
}
@end
