//
//  PersonalMainViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PersonalMainViewController.h"
#import "CGlobal.h"
#import "PhotoUploadViewController.h"
#import "SelectItemViewController.h"
#import "SelectPackageViewController.h"
#import "OrderHistoryViewController2.h"
#import "Logistika-Swift.h"

@interface PersonalMainViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) NSTimer* timer;
@property (nonatomic,assign) BOOL blinkStatus;
@property (nonatomic,assign) BOOL allowed;
@end

@implementation PersonalMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_PRIMARY;
    self.contentView.backgroundColor = COLOR_SECONDARY_THIRD;
    
    self.btnContinue.hidden = true;
    // Do any additional setup after loading the view.
    
    [self.txtCholocate addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
   [self.txtCholocate setTintColor:[UIColor whiteColor]];
    
    self.timer = [NSTimer
                      scheduledTimerWithTimeInterval:(NSTimeInterval)(0.6)
                      target:self
                      selector:@selector(blink)
                      userInfo:nil
                      repeats:TRUE];
    self.blinkStatus = NO;
    self.blinkingView.hidden = true;
    self.allowed = true;
    
    self.txtCholocate.delegate = self;
    
    
    if( g_cityModels.count == 0){
        [self getCity];
    }
}
-(void)blink{
    if(_blinkStatus == NO){
        _blinkingView.backgroundColor = [UIColor whiteColor];
        _blinkStatus = YES;
    }else {
        _blinkingView.backgroundColor = [UIColor clearColor];
        _blinkStatus = NO;
    }
}
-(void)textFieldDidChange:(UITextField*)textField{
    if (textField == self.txtCholocate) {
        NSString* pp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(pp.length > 0){
            self.btnContinue.hidden = false;
        }else{
            self.btnContinue.hidden = true;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [CGlobal clearData];
    
    [self.topBarView updateCaption];
    
    EnvVar* env = [CGlobal sharedId].env;
    env.quote = false;
}
- (IBAction)menu1:(id)sender {
//    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
//    PhotoUploadViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PhotoUploadViewController"];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        vc.limit =  g_limitCnt;
//        g_ORDER_TYPE = g_CAMERA_OPTION;
//        [self.navigationController pushViewController:vc animated:true];
//    });
    
    [self requestCameraPermissionsIfNeeded];
    
   
}
- (IBAction)menu2:(id)sender {
    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    SelectItemViewController* vc = [ms instantiateViewControllerWithIdentifier:@"SelectItemViewController"];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        g_ORDER_TYPE = g_ITEM_OPTION;
        [self.navigationController pushViewController:vc animated:true];
    });
}
- (IBAction)menu3:(id)sender {
    if(self.txtCholocate.text.length>0){
        UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
        SelectPackageViewController* vc = [ms instantiateViewControllerWithIdentifier:@"SelectPackageViewController"];
        vc.string = self.txtCholocate.text;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            g_ORDER_TYPE = g_PACKAGE_OPTION;
            [self.navigationController pushViewController:vc animated:true];
        });
    }
    
    
}
- (IBAction)reveal2:(UIButton*)sender {
    if(sender.tag == 2){
        // bottom one
        self.layer1.hidden = false;
        self.layer2.hidden = !self.layer2.hidden;
                
        
        if(self.allowed == false){
            self.blinkingView.hidden = true;
        }else{
            if (self.layer2.hidden) {
//                NSString* pp = [self.txtCholocate.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                NSString* pp = self.txtCholocate.text;
                if (pp.length > 0) {
                    self.blinkingView.hidden = true;
                }else{
                    self.blinkingView.hidden = false;
                }
                
            }else{
                self.blinkingView.hidden = true;
            }
        }
        
    }else if(sender.tag == 1){
        
        self.layer2.hidden = false;
        self.layer1.hidden = !self.layer1.hidden;
        
//        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
//        OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            vc.param1 = 1;
//            self.navigationController.navigationBar.hidden = true;
//            self.navigationController.viewControllers = @[vc];
//        });
        
        
    }
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    self.allowed = false;
    self.blinkingView.hidden = true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    self.allowed = false;
    self.blinkingView.hidden = true;
}


- (void)requestCameraPermissionsIfNeeded {
    
    // check camera authorization status
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized: { // camera authorized
            // do camera intensive stuff
            [self gotoCamer];
        }
            break;
        case AVAuthorizationStatusNotDetermined: { // request authorization
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if(granted) {
                        // do camera intensive stuff
                        
                        [self gotoCamer];
                        
                    } else {
                        //[self notifyUserOfCameraAccessDenial];
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied: {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not Authorized" message:@"Please go to Settings and enable the camera for this app to use this feature." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                
                
            });
        }
            break;
        default:
            break;
    }
}

-(void) gotoCamer{
    UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
    PhotoViewController* vc = [ms instantiateViewControllerWithIdentifier:@"PhotoViewController"];
    dispatch_async(dispatch_get_main_queue(), ^{
        vc.limit =  g_limitCamera;
        g_ORDER_TYPE = g_CAMERA_OPTION;
        [self.navigationController pushViewController:vc animated:true];
    });
}
-(void) getCity{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"get_cities" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                if ([dict[@"result"] intValue] == 200) {
                    [CGlobal stopIndicator:self];
                    
                    LoginResponse* data = [[LoginResponse alloc] initWithDictionary:dict];
                    if (data.cities.count > 0) {
                        g_cityModels = data.cities;
                        g_cityBounds = [g_cityModels[0] getGeofences];
                        return;
                    }else{
                        [CGlobal AlertMessage:@"Fail" Title:nil];
                    }
                    
                }else{
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }
                
                
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}

@end
