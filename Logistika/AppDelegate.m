//
//  AppDelegate.m
//  Logistika
//
//  Created by BoHuang on 4/18/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "AppDelegate.h"
#import "CGlobal.h"
#import "PersonalMainViewController.h"
#import "IQKeyboardManager.h"
#import "NetworkParser.h"
#import <GoogleMaps/GoogleMaps.h>
#import "StatViewController.h"
@import Firebase;
/*#import <KSCrash/KSCrash.h> // TODO: Remove this
#import <KSCrash/KSCrashInstallation+Alert.h>
#import <KSCrash/KSCrashInstallationStandard.h>
#import <KSCrash/KSCrashInstallationQuincyHockey.h>
#import <KSCrash/KSCrashInstallationEmail.h>
#import <KSCrash/KSCrashInstallationVictory.h>*/

@import GooglePlaces;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [FIRApp configure];
    
    [CGlobal initGlobal];
    [self loadBasicData];
    [self initData];
        
    EnvVar*env = [CGlobal sharedId].env;
    env.lastLogin = -1;
    env.quote = true;
    g_isii = false;
    g_location_cnt = 0;

    [GMSPlacesClient provideAPIKey:@"AIzaSyAPN34OpSc-JfgEi_bCO08qmd1GOTTmeF0"];
    [GMSServices provideAPIKey:@"AIzaSyAPN34OpSc-JfgEi_bCO08qmd1GOTTmeF0"];
    
//    [self installCrashHandler];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
        
    return YES;
}
-(void)initData{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
}
- (void)keyboardOnScreen:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    // UIKeyboardFrameEndUserInfoKey UIKeyboardFrameBeginUserInfoKey
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    g_keyboardRect = keyboardFrameBeginRect;

    NSNotificationCenter *center;
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    
}
-(void)loadBasicData{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"get_basic" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                if ([dict[@"result"] intValue] == 200) {
                    LoginResponse* data = [[LoginResponse alloc] initWithDictionary:dict];
                    if (data.area.count > 0) {
                        g_areaData = data;
                    }
                    
                }else{
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }
            }
        }else{
            NSLog(@"Error");
        }
        
    } method:@"POST"];
}
-(void)defaultIntro{
    
    EnvVar* env = [CGlobal sharedId].env;
    env.lastLogin = -1;
    
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController*vc = [ms instantiateViewControllerWithIdentifier:@"StatViewController"] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _window.rootViewController = vc;
    });
}
-(void)defaultLogin{
    
    EnvVar* env = [CGlobal sharedId].env;
    env.lastLogin = -1;
    
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CLoginNav"] ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _window.rootViewController = vc;
    });
}
-(void)goHome:(UIViewController*)origin{
    EnvVar* env = [CGlobal sharedId].env;
    if (env.mode == c_PERSONAL || env.mode == c_GUEST ) {
        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
        
        PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PersonalMainViewController"] ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            origin.navigationController.navigationBar.hidden = true;
            origin.navigationController.viewControllers = @[vc];
        });
    }else{
        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Cor" bundle:nil];
        
        PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"CorMainViewController"] ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            origin.navigationController.navigationBar.hidden = true;
            origin.navigationController.viewControllers = @[vc];
        });
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)startLocationService{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
    
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        [CGlobal AlertMessage:@"Location services were previously denied by the you. Please enable location services for this app in settings." Title:@"Location services"];
        
        return;
    }
    
    
    // Request "when in use" location service authorization.
    // If authorization has been denied previously, we can display an alert if the user has denied location services previously.
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        
        [CGlobal AlertMessage:@"Location services were previously denied by the you. Please enable location services for this app in settings." Title:@"Location services"];
        
        return;
    }
    
    // Start updating locations.
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    g_lastLocation = newLocation;
    //    NSLog(@"%.6f %.6f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    [_locationManager stopUpdatingLocation];
}
/**
 Configure Crash Report Handler
 **/
/* - (void) installCrashHandler
{
   KSCrashInstallation* installation = [self makeEmailInstallation];
    [installation install];
    [KSCrash sharedInstance].deleteBehaviorAfterSendAll = KSCDeleteAlways; // TODO: Remove this
    
    
    // Send all outstanding reports. You can do this any time; it doesn't need
    // to happen right as the app launches. Advanced-Example shows how to defer
    // displaying the main view controller until crash reporting completes.
    [installation sendAllReportsWithCompletion:^(NSArray* reports, BOOL completed, NSError* error)
     {
         if(completed)
         {
             NSLog(@"Sent %d reports", (int)[reports count]);
         }
         else
         {
             NSLog(@"Failed to send reports: %@", error);
         }
     }];
}
- (KSCrashInstallation*) makeEmailInstallation
{
    NSString* emailAddress = @"support@hurryr.in";
    
    KSCrashInstallationEmail* email = [KSCrashInstallationEmail sharedInstance];
    email.recipients = @[emailAddress];
    email.subject = @"Crash Report";
    email.message = @"This is a crash report";
    email.filenameFmt = @"crash-report-%d.txt.gz";
    
    [email addConditionalAlertWithTitle:@"Crash Detected"
                                message:@"The app crashed last time it was launched. Send a crash report?"
                              yesAnswer:@"Sure!"
                               noAnswer:@"No thanks"];
    
    // Uncomment to send Apple style reports instead of JSON.
    [email setReportStyle:KSCrashEmailReportStyleApple useDefaultFilenameFormat:YES];
    
    return email;
}*/
@end
