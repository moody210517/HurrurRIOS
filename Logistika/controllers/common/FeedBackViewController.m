//
//  FeedBackViewController.m
//  Logistika
//
//  Created by BoHuang on 4/20/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "FeedBackViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "AppDelegate.h"
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btnSubmit addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    _btnSubmit.tag = 200;
    EnvVar*env = [CGlobal sharedId].env;
    
//    self.txtFeedback.placeholder = @"Feedback";
//    self.txtFeedback.layer.borderWidth = 1;
//    self.txtFeedback.layer.borderColor = [UIColor blackColor].CGColor;
//    self.txtFeedback.layer.masksToBounds = true;
    
    // Do any additional setup after loading the view.
    
    NSArray* fields = @[self.txtFirst,self.txtLast,self.txtFeedback];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-40, 30);
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        [field addBotomLayer:frame];
    }
    
    self.view.backgroundColor = COLOR_PRIMARY;
    self.viewRoot.backgroundColor = COLOR_SECONDARY_THIRD;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.topBarView.caption.text = @"Feedback";
}
-(NSMutableDictionary*)checkInput{
    NSString* mFirst = _txtFirst.text;
    NSString* mEmail = _txtLast.text;
    NSString* feed = _txtFeedback.text;
    NSArray* ctrls = @[_txtFirst,_txtLast,_txtFeedback];
    for (UITextField*ctrl in ctrls) {
        NSString* label = ctrl.text;
        if ([label isEqualToString:@""]) {
            [CGlobal AlertMessage:@"Please enter all info" Title:nil];
            [ctrl becomeFirstResponder];
            return nil;
        }
    }
    
    if (![CGlobal isValidEmail:mEmail]) {
        [CGlobal AlertMessage:@"Invalid Email" Title:nil];
        [_txtLast becomeFirstResponder];
        return nil;
    }
    EnvVar*env = [CGlobal sharedId].env;
    
    NSDictionary* tdata = @{@"user_mode":@"0"
                            ,@"name":mFirst
                            ,@"email":mEmail
                            ,@"feedback":feed
                            ,@"id":@"0"};
    
    NSMutableDictionary* data = [[NSMutableDictionary alloc] initWithDictionary:tdata];
    if (env.mode == c_PERSONAL) {
        data[@"user_id"] = env.user_id;
    }else{
        data[@"user_id"] = env.corporate_user_id;
    }
    return data;
}
-(void)feedback:(NSMutableDictionary*)data{
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_URL Path:@"feedback" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                int ret = [dict[@"result"] intValue] ;
                if ([dict[@"result"] intValue] == 400) {
                    [CGlobal AlertMessage:@"Failed" Title:nil];
                    [CGlobal stopIndicator:self];
                    return;
                }
                EnvVar*env = [CGlobal sharedId].env;
                env.feedback_id = [NSString stringWithFormat:@"%d",ret];
                [CGlobal AlertMessage:@"Success" Title:nil];
                
                // goto main page.
                AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [delegate goHome:self];
            }
            
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    NSMutableDictionary*data = [self checkInput];
    if (data!=nil) {
        UIAlertController* ac = [[UIAlertController alloc] init];
        UIAlertAction* ac1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // feedback
            [self feedback:data];
        }];
        UIAlertAction* ac2 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [ac addAction:ac1];
        [ac addAction:ac2];
        
        [ac setModalPresentationStyle:UIModalPresentationFormSheet];
        UIPopoverPresentationController* popPresenter =  ac.popoverPresentationController;
        popPresenter.sourceView = sender;
        
        [self presentViewController:ac animated:true completion:^{
            
        }];
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
