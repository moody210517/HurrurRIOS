//
//  TermControllerViewController.m
//  Logistika
//
//  Created by BoHuang on 6/6/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "TermViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
@interface TermViewController ()

@end

@implementation TermViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadContent];
    self.view.backgroundColor = COLOR_SECONDARY_THIRD;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.topBarView.caption.text = @"Contact Us";
    self.title = @"Terms and Conditions";
}
-(void)loadContent{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_URL Path:@"term" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                //
                [CGlobal showWebView:dict[@"result"] WEBVIEW:_webview];
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
    
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
