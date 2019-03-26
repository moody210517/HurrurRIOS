//
//  ForgotPasswordViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "NetworkParser.h"
#import "CGlobal.h"
#import "AppDelegate.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblMessage.hidden = true;
    _stack2.hidden = true;
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    
    [_btnSubmit setTitle:@"CONTINUE" forState:UIControlStateNormal];
    _btnSubmit.tag = 200;
    
    NSArray* fields = @[self.txtUsername,self.txtPassword];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 30);
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        [field addBotomLayer:frame];
//        field.backMode = 1;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Forgot Password";
    self.navigationController.navigationBar.hidden =false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickAction:(UIView*)sender {
    int tag =(int)sender.tag;
    if (tag == 200) {
        if ([self checkInput1]) {
            EnvVar* env = [CGlobal sharedId].env;
            NSString*mName = _txtUsername.text;
            
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            params[@"email"] = mName;
            if (self.segIndex == 0) {
                params[@"type"] = [NSString stringWithFormat:@"%d",c_PERSONAL];
            }else{
                params[@"type"] = [NSString stringWithFormat:@"%d",c_CORPERATION];
            }
            
            NetworkParser* manager = [NetworkParser sharedManager];
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest2:params BasePath:FORGOT Path:@"getQuestionFromEmailCustomer" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
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
//                            self.lblMessage.hidden = false;
                            NSString*message = @"We didn't find the email";
                            [CGlobal AlertMessage:message Title:nil];
                        }
                    }else{
                        NSString*message = @"We didn't find the email";
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
            NSString*mName = _txtUsername.text;
            NSString*mAnswer= _txtPassword.text;
            
            NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
            params[@"email"] = mName;
            params[@"answer"] = mAnswer;
            
            NetworkParser* manager = [NetworkParser sharedManager];
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest2:params BasePath:FORGOT Path:@"forgotPasswordCustomer" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                if (error == nil) {
                    if (dict!=nil && dict[@"result"] != nil) {
                        //
                        if([dict[@"result"] intValue] == 200){
                            NSDictionary* data = dict[@"data"];
                            NSString* password = data[@"password"];
                            
                            [self showPassword:password];
                        }else {
                            NSString*message = @"We didn’t find the details in our records. Please try again";
                            [CGlobal AlertMessage:message Title:nil];
                        }
                    }else{
                        NSString*message = @"We didn’t find the details in our records. Please try again";
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
    NSString*message = @"Email Sent";
    NSString* de = [CGlobal decrypt:password];
    de = [[NSBundle mainBundle] localizedStringForKey:@"alert_forgot_password" value:@"" table:nil];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:message message:de delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
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
-(BOOL)checkInput1{
    NSString*mName = _txtUsername.text;
    if ([mName length ] == 0) {
        [CGlobal AlertMessage:@"Please Input All info" Title:nil];
        return false;
    }
    return true;
}
-(BOOL)checkInput2{
    NSString*mName = _txtUsername.text;
    NSString*mAnswer= _txtPassword.text;
    if ([mName length ] == 0 || [mAnswer length] == 0) {
        [CGlobal AlertMessage:@"Please Input All info" Title:nil];
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
