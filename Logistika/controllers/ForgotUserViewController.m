//
//  ForgotUserViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ForgotUserViewController.h"
#import "NetworkParser.h"
#import "CGlobal.h"
#import "AppDelegate.h"

@interface ForgotUserViewController ()

@end

@implementation ForgotUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblMessage.hidden = true;
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    _stack2.hidden = true;
    
    [_btnSubmit setTitle:@"CONTINUE" forState:UIControlStateNormal];
    
    _btnSubmit.tag = 200;
    
    NSArray* fields = @[self.txtPhone,self.txtAnswer];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 30);
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        [field addBotomLayer:frame];
        if (field == self.txtPhone) {
            field.validateMode = 2;
            field.validateLength = 10;
        }
//        field.backMode = 1;
    }
    self.txtPhone.text = @"+91";
    NSAttributedString* attr_str = self.txtAnswer.attributedPlaceholder;
    [attr_str enumerateAttributesInRange:NSMakeRange(0, [attr_str length])
                                 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                              usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop) {
                                  UIColor *fgColor = [attributes objectForKey:NSForegroundColorAttributeName];
                                  self.lblReceiverPhone.textColor = fgColor;
                              }];
    
    
    [self.txtPhone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self updateHintText];
}
-(void)textFieldDidChange:(UITextField*)textField{
    if (textField == self.txtPhone ) {
        [self updateHintText];
    }
}
-(void)updateHintText{
    if (self.txtPhone.text.length>3) {
        self.lblReceiverPhone.hidden = true;
    }else{
        self.lblReceiverPhone.hidden = false;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Forgot User Name";
    self.navigationController.navigationBar.hidden =false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickAction:(UIView*)sender {
    int tag = (int)sender.tag;
    if (tag == 200) {
        if ([self checkInput1]) {
            EnvVar* env = [CGlobal sharedId].env;
            NSString*mName = [CGlobal getValidPhoneNumber:_txtPhone.text Output:1 Prefix:@"+91" Length:10];
            
            
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            params[@"phone"] = mName;
            if (self.segIndex == 0) {
                params[@"type"] = [NSString stringWithFormat:@"%d",c_PERSONAL];
            }else{
                params[@"type"] = [NSString stringWithFormat:@"%d",c_CORPERATION];
            }
            
            NetworkParser* manager = [NetworkParser sharedManager];
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest2:params BasePath:FORGOT Path:@"getQuestionFromPhoneCustomer" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                if (error == nil) {
                    if (dict!=nil && dict[@"result"] != nil) {
                        //
                        if([dict[@"result"] intValue] == 200){
                            NSDictionary* data = dict[@"data"];
                            NSString* question = data[@"question"];
                            
                            self.lblQuestion.text = question;
                            self.stack2.hidden = false;
                            [self.btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
                            self.btnSubmit.tag = 201;
                        }else {
                            NSString*message = @"We didn't find the phone";
                            [CGlobal AlertMessage:message Title:nil];
                        }
                    }else{
                        NSString*message = @"We didn't find the phone";
                        [CGlobal AlertMessage:message Title:nil];
                    }
                }else{
                    NSLog(@"Error");
                }
                [CGlobal stopIndicator:self];
            } method:@"POST"];
        }
    }else{
        if ([self checkInput2]) {
            NSString*mName = _txtPhone.text;
            NSString*mAnswer= _txtAnswer.text;
            
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            params[@"phone"] = mName;
            params[@"answer"] = mAnswer;
            
            NetworkParser* manager = [NetworkParser sharedManager];
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest2:params BasePath:FORGOT Path:@"forgotUserNameCustomer" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                if (error == nil) {
                    if (dict!=nil && dict[@"result"] != nil) {
                        //
                        if([dict[@"result"] intValue] == 200){
                            NSDictionary* data = dict[@"data"];
                            NSString* email = data[@"email"];
                            
                            [self showPassword:email];
                        }else if([dict[@"result"] intValue] == 500){
                            self.lblMessage.hidden = false;
                            NSString*message = @"Fail to send Sms or Email";
                            [CGlobal AlertMessage:message Title:nil];
                        }else {
                            NSString*message = @"We didn't find the details in our records. Please try again";
                            [CGlobal AlertMessage:message Title:nil];
                        }
                    }else{
                        NSString*message = @"We didn't find the details in our records. Please try again";
                        [CGlobal AlertMessage:message Title:nil];
                    }
                }else{
                    NSLog(@"Error");
                }
                [CGlobal stopIndicator:self];
            } method:@"POST"];
        }
    }
    
}
-(void)showPassword:(NSString*)password{
    NSString*message = [[NSBundle mainBundle] localizedStringForKey:@"recovery_email" value:@"" table:nil];
    NSString* de = [NSString stringWithFormat:@"Email : %@",password];
    de = [[NSBundle mainBundle] localizedStringForKey:@"alert_forgot_username" value:@"" table:nil];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Text Sent" message:de delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    alert.tag = 200;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    int tag = (int)alertView.tag;
    if (tag == 200) {
        if (buttonIndex == 0) {
            g_page_type = @"";
            // go home
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}
-(BOOL)checkInput2{
    NSString*mName = _txtPhone.text;
    NSString*mAnswer= _txtAnswer.text;
    if ([mName length ] == 0 || [mAnswer length] == 0) {
        [CGlobal AlertMessage:@"Please Input All Info" Title:nil];
        return false;
    }
    return true;
}
-(BOOL)checkInput1{
    NSString*mName = _txtPhone.text;
    if ([mName length ] == 0) {
        [CGlobal AlertMessage:@"Please Input All Info" Title:nil];
        return false;
    }
    return true;
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
