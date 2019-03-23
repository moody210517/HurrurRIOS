//
//  AppDelegate.h
//  Logistika
//
//  Created by BoHuang on 4/18/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
-(void)defaultLogin;
-(void)defaultIntro;

-(void)goHome:(UIViewController*)origin;
-(void)loadBasicData;

@property (strong,nonatomic) CLLocationManager *locationManager;
-(void)startLocationService;
@end

