//
//  LeftView.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "LeftView.h"
#import "AboutUsViewController.h"
#import "ContactUsViewController.h"
#import "PolicyViewController.h"
#import "CGlobal.h"
#import "UIView+Property.h"
#import "AppDelegate.h"
#import "SignupViewController.h"
#import "ProfileViewController.h"
#import "QuoteViewController.h"
#import "QuoteCorViewController.h"
#import "OrderHistoryViewController2.h"
#import "OrderHisCorViewController.h"
#import "RescheduleViewController.h"
#import "CancelPickViewController.h"
#import "FeedBackViewController.h"
#import "CitySelectView.h"
#import "Logistika-Swift.h"

@implementation LeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setCurrentMenu:(NSString *)currentMenu{
    _currentMenu = currentMenu;
    // c_menu_title = @[@"profile",@"quotes",@"order",@"reschedule",@"cancel",@"about",@"contact",@"feedback",@"policy",@"sign"];
    NSArray* menus = @[_menuProfile,_menuQuotes,_menuOrderHistory,_viewChangeLocation,_menuAbout,_menuContact,_menuFeedback,_menuPrivacy,_viewSignIn];
    
    for (MenuItem*item in menus) {
        item.backMode = 0;
    }
    if (currentMenu!=nil) {
        NSUInteger found = [c_menu_title indexOfObject:currentMenu];
        if (found!= NSNotFound) {
            MenuItem* item = menus[found];
            item.backMode = 1;
        }
    }
}
-(void)reopenOrderHistory:(int)page{
    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
    OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
    vc.param1 = page;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _vc.navigationController.navigationBar.hidden = true;
        _vc.navigationController.viewControllers = @[vc];
    });
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    EnvVar* env = [CGlobal sharedId].env;
    switch (tag) {
        case 200:
        {
            //btnProfile
            if (env.lastLogin>0) {
                // profile
                if(_vc.navigationController!= nil){
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
                    ProfileViewController*vc = [ms instantiateViewControllerWithIdentifier:@"ProfileViewController"] ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_vc.navigationController pushViewController:vc animated:true];
                    });
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 201:
        {
            //btnQuotes
            if (env.lastLogin>0) {
                if(_vc.navigationController!= nil){
                    if (env.mode == c_CORPERATION) {
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Cor" bundle:nil];
                        QuoteCorViewController*vc = [ms instantiateViewControllerWithIdentifier:@"QuoteCorViewController"] ;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _vc.navigationController.navigationBar.hidden = true;
                            _vc.navigationController.viewControllers = @[vc];
                        });
                    }else{
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Cor" bundle:nil];
                        QuoteViewController*vc = [ms instantiateViewControllerWithIdentifier:@"QuoteViewController"] ;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _vc.navigationController.navigationBar.hidden = true;
                            _vc.navigationController.viewControllers = @[vc];
                        });
                    }
                    
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 202:
        {
            //btnOrderHistory
            if (env.lastLogin>0) {
                if(_vc.navigationController!= nil){
                    if (env.mode == c_CORPERATION) {
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                        OrderHisCorViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHisCorViewController"] ;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _vc.navigationController.navigationBar.hidden = true;
                            _vc.navigationController.viewControllers = @[vc];
                        });
                    }else{
                        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                        OrderHistoryViewController*vc = [ms instantiateViewControllerWithIdentifier:@"OrderHistoryViewController"] ;
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _vc.navigationController.navigationBar.hidden = true;
                            _vc.navigationController.viewControllers = @[vc];
                        });
                    }
                    
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 203:
        {
            //change location
            NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"UserInfoWindow" owner:self options:nil];
            CitySelectView* cityView = array[2];
            MyPopupDialog * dialog = [[MyPopupDialog alloc] init];
            //    cityView.frame = CGRectMake(0, 0, 300, 500);
            CGRect scRect = [UIScreen mainScreen].bounds;
            cityView.frame = scRect;
            
            [cityView setData:@{@"list":g_cityModels,@"aDelegate":self}];
            [dialog setup:cityView backgroundDismiss:false backgroundColor:[UIColor darkGrayColor]];
            dialog.backgroundColor = [CGlobal colorWithHexString:@"#aaaaaa" Alpha:0.5];
            [dialog showPopup:self.vc.view];
            
            break;
        }
        case 204:
        {
            //btnCancel
            
            break;
        }
        case 205:
        {
            //btnAbout
            if (env.lastLogin>=0) {
                if(_vc.navigationController!= nil){
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    AboutUsViewController*vc = [ms instantiateViewControllerWithIdentifier:@"AboutUsViewController"] ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _vc.navigationController.navigationBar.hidden = true;
                        _vc.navigationController.viewControllers = @[vc];
                    });
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            
            
            break;
        }
        case 206:
        {
            //btnContact
            if (env.lastLogin>=0) {
                if(_vc.navigationController!= nil){
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    ContactUsViewController*vc = [ms instantiateViewControllerWithIdentifier:@"ContactUsViewController"] ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _vc.navigationController.navigationBar.hidden = true;
                        _vc.navigationController.viewControllers = @[vc];
                    });
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 207:
        {
            //btnFeedback
            if (env.lastLogin>=0) {
                if(_vc.navigationController!= nil){
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    FeedBackViewController*vc = [ms instantiateViewControllerWithIdentifier:@"FeedBackViewController"] ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _vc.navigationController.navigationBar.hidden = true;
                        _vc.navigationController.viewControllers = @[vc];
                    });
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 208:
        {
            //btnPrivacy
            if (env.lastLogin>=0) {
                if(_vc.navigationController!= nil){
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    PolicyViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PolicyViewController"] ;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _vc.navigationController.navigationBar.hidden = true;
                        _vc.navigationController.viewControllers = @[vc];
                    });
                }
            }else{
                [CGlobal AlertMessage:@"Please Sign in" Title:nil];
            }
            break;
        }
        case 209:
        {
            //btnSignIn
            AppDelegate* delegate = [UIApplication sharedApplication].delegate;
            [delegate defaultLogin];
            break;
        }
        case 210:{
            // sign out
            [env logOut];
            [CGlobal clearData];
            AppDelegate* delegate = [UIApplication sharedApplication].delegate;
            [delegate defaultLogin];
            break;
        }
        default:
            break;
    }
    // close drawer
    if (_vc.view.drawerLayout!=nil) {
        ECDrawerLayout *drawerLayout = _vc.view.drawerLayout;
        drawerLayout.openFromRight = NO;
        [drawerLayout closeDrawer];
    }
}
-(void)initMenu{
    [self.btnProfile addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnQuotes addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnOrderHistory addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnChangeLocation addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnAbout addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnContact addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnFeedback addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPrivacy addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnSignIn addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnProfile.tag = 200;
    self.btnQuotes.tag = 201;
    self.btnOrderHistory.tag = 202;
    self.btnChangeLocation.tag = 203;
    
    self.btnAbout.tag = 205;
    self.btnContact.tag = 206;
    self.btnFeedback.tag = 207;
    self.btnPrivacy.tag = 208;
    self.btnSignIn.tag = 209;
    
    EnvVar* env = [CGlobal sharedId].env;
    if (env.lastLogin > 0) {
        self.lblSignIn.text = @"Sign Out";
        self.btnSignIn.tag = 210;
    }else{
        self.btnSignIn.tag = 209;
        self.lblSignIn.text = @"Sign In";
    }
    
    
    if (env.lastLogin<0) {
        _viewSignIn.hidden = true;
    }else{
        _viewSignIn.hidden = false;
    }
}
-(void)initMe:(UIViewController*)vc{
    _vc = vc;
    [self initMenu];
    self.backgroundColor = [CGlobal colorWithHexString:@"000000" Alpha:0.8];
}
-(void)setMode:(NSInteger)mode{
    _mode = mode;
    }
-(void)didSubmit:(NSDictionary *)data View:(UIView *)view{
    CityModel* model = data[@"model"];
    g_city_selection = model;
    if ([view.xo isKindOfClass:[MyPopupDialog class]]) {
        g_cityBounds = [model getGeofences];
        MyPopupDialog * dlg = (MyPopupDialog*)view.xo;
        [dlg dismissPopup];
    }
}
@end
