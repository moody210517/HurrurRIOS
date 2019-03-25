//
//  MyNavViewController.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyNavViewController.h"
#import "CGlobal.h"

@interface MyNavViewController ()

@end

@implementation MyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.hidden = true;
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage imageNamed:@""];
    
    
//    UIFont* font = [UIFont fontWithName:@"Tw Cen MT" size:17];
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:font}];
    
    UIFont* font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightHeavy];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:font}];
    self.navigationBar.barTintColor = [CGlobal colorWithHexString:@"008080" Alpha:1.0f];
    self.navigationBar.tintColor = [UIColor whiteColor];
    
    
    //    UIImage*image = [UIImage imageNamed:@"ico_topbar_back"];
    //    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // back icon left arrow color
    //    //        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:Constants.COLOR_TOOLBAR_TEXT];
    //    let titleDict: [String:Any] = [NSForegroundColorAttributeName: Constants.COLOR_TOOLBAR_TEXT]
    //    self.navigationBar.titleTextAttributes = titleDict
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-500, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
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
