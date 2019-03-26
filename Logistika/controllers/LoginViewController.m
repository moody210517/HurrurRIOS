//
//  LoginViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "LoginViewController.h"
#import "CGlobal.h"
#import "ForgotPasswordViewController.h"
#import "ForgotUserViewController.h"
#import "NetworkParser.h"
#import "TblAddress.h"
#import "PersonalMainViewController.h"
#import "AppDelegate.h"
#import "MyNavViewController.h"
#import "AESCrypt.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
    // Do any additional setup after loading the view.
    [_btnSignIn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btnForgotPassword addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [_btnForgotUsername addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnSignIn.tag = 200;
    _btnForgotPassword.tag = 201;
    _btnForgotUsername.tag = 202;
    _txtPassword.secureTextEntry = true;
    
    EnvVar* env = [CGlobal sharedId].env;
    if (self.segIndex == 0) {
        _txtUsername.text= env.username;
        _txtPassword.text= env.password;
    }else{
        _txtUsername.text= env.cor_email;
        _txtPassword.text= env.cor_password;
    }
    if (g_isii) {
        if (self.segIndex == 0) {
            _txtUsername.text= @"sumanth3004@gmail.com";
            _txtPassword.text= @"hurryr12";
        }else{
            _txtUsername.text= @"corp@corp.com";
            _txtPassword.text= @"password9";
        }
    }
    
    NSArray* fields = @[_txtUsername,_txtPassword];
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        field.backMode = 1;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Log In";
}
-(void)clickView:(UIView*)sender{
        
    int tag = (int)sender.tag;
    switch (tag) {
        case 200:
        {
            NSString* username = _txtUsername.text;
            NSString* password = _txtPassword.text;
            if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
                [CGlobal AlertMessage:@"Please Input all Info" Title:nil];
                if ([username isEqualToString:@""]) {
                    [_txtUsername becomeFirstResponder];
                }else if([password isEqualToString:@""]){
                    [_txtPassword becomeFirstResponder];
                }
                return;
            }
            if (![CGlobal isValidEmail:username]) {
                [CGlobal AlertMessage:@"Invalid Email" Title:nil];
                return;
            }
            NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
            data[@"email"] = username;
            NSData *nsdata = [password
                              dataUsingEncoding:NSUTF8StringEncoding];
            
            // Get NSString from NSData object in Base64
            NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:0];
            
            data[@"password"] = [base64Encoded stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            if (_segIndex == 0) {
                data[@"user_type"] = [NSString stringWithFormat:@"%d",c_PERSONAL];
            }else{
                data[@"user_type"] = [NSString stringWithFormat:@"%d",c_CORPERATION];
            }
            
            
            NetworkParser* manager = [NetworkParser sharedManager];
            [CGlobal showIndicator:self];
            [manager ontemplateGeneralRequest2:data BasePath:BASE_URL Path:@"login" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
                if (error == nil) {
                    // succ
                    if (dict[@"result" ]!=nil) {
                        if ([dict[@"result"] intValue] == 400) {
                            [CGlobal AlertMessage:@"We don't recognise the User Name and Password. Please try again." Title:nil];
                            [CGlobal stopIndicator:self];
                            return;
                        }
                    }
                    EnvVar* env = [CGlobal sharedId].env;
                    TblUser* user = [[TblUser alloc] initWithDictionary:dict];
                    [user saveResponse:_segIndex Password:_txtPassword.text];
                    
                    
                    // LoginProcess
                    if (_segIndex == 0) {
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                        PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PersonalMainViewController"] ;
                        MyNavViewController* nav = [[MyNavViewController alloc] initWithRootViewController:vc];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                            delegate.window.rootViewController = nav;
                        });
                    }else{
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Cor" bundle:nil];
                        PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CorMainViewController"] ;
                        MyNavViewController* nav = [[MyNavViewController alloc] initWithRootViewController:vc];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                            delegate.window.rootViewController = nav;
                        });
                    }
                    
                }else{
                    // error
                    NSLog(@"Error");
                }
                
                [CGlobal stopIndicator:self];
            } method:@"POST"];
            break;
        }
        case 201:{
            // forgot password
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ForgotPasswordViewController*vc = [ms instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"] ;
            vc.segIndex = self.segIndex;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:true];
            });
            break;
        }
        case 202:{
            // user forgot
            UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ForgotUserViewController*vc = [ms instantiateViewControllerWithIdentifier:@"ForgotUserViewController"] ;
            vc.segIndex = self.segIndex;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController pushViewController:vc animated:true];
            });
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
