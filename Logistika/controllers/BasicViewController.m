//
//  BasicViewController.m
//  Logistika
//
//  Created by BoHuang on 5/11/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "IQKeyboardManager.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "TrackMapViewController.h"
#import "ReturnDelegate.h"

@interface BasicViewController ()
@property (nonatomic,strong) IQKeyboardReturnKeyHandler* returnKeyHandler;
//@property (nonatomic,strong) ReturnDelegate* myDelegate;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    [self listSubviewsOfView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    self.returnKeyHandler = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        
        statusBar.backgroundColor = COLOR_PRIMARY_BAR;
    }
}


-(void)orderTracking:(NSString*)trackId{
    if (self.navigationController!=nil) {
        [CGlobal showIndicator:self];
        NetworkParser* manager = [NetworkParser sharedManager];
        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
        params[@"track_id"] = trackId;
        params[@"type"] = [NSNumber numberWithInt:g_mode];
        
        [manager ontemplateGeneralRequest2:params BasePath:@"" Path:@"/Track/order_track_by_trackid" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
            if (error == nil) {
                if (dict!=nil && dict[@"result"] != nil) {
                    //
                    if([dict[@"result"] intValue] == 200){
                        OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                        if (response.orderTrackModel!=nil) {
                            response.orderTrackModel.type = @"200";
                            
                            UIStoryboard*ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                            TrackMapViewController* vc = [ms instantiateViewControllerWithIdentifier:@"TrackMapViewController"];
                            vc.orderResponse = response;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.navigationController pushViewController:vc animated:true];
                            });
                            [CGlobal stopIndicator:self];
                            return;
                        }
                    }else if ([dict[@"result"] intValue] == 300){
                        OrderResponse* response = [[OrderResponse alloc] initWithDictionary_track:dict];
                        if (response.orderTrackModel!=nil) {
                            response.orderTrackModel.type = @"300";
                            
                            UIStoryboard*ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                            TrackMapViewController* vc = [ms instantiateViewControllerWithIdentifier:@"TrackMapViewController"];
                            vc.orderResponse = response;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.navigationController pushViewController:vc animated:true];
                            });
                            [CGlobal stopIndicator:self];
                            return;
                        }
                    }
                }
            }else{
                NSLog(@"Error");
            }
            [CGlobal AlertMessage:@"Fail" Title:nil];
            [CGlobal stopIndicator:self];
        } method:@"POST"];
    }
}

- (void)listSubviewsOfView:(UIView *)view {
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return; // COUNT CHECK LINE
    
    for (UIView *subview in subviews) {
        
        // Do what you want to do with the subview
        NSLog(@"%@", subview);
        if ([subview isKindOfClass:[UITextField class]]) {
            [self actionForTextField:subview];
        }
        
        
        // List the subviews of subview
        [self listSubviewsOfView:subview];
    }
}
-(void)actionForTextField:(UITextField*)txtField{
    txtField.returnKeyType = UIReturnKeyDone;
    [txtField addTarget:self action:@selector(textFieldDoneTapped:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
-(void)textFieldDoneTapped:(UITextField*)txtField{
    [txtField resignFirstResponder];
}
@end
