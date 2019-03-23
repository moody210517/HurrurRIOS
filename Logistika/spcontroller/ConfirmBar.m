//
//  ConfirmBar.m
//  intuitive
//
//  Created by BoHuang on 4/13/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ConfirmBar.h"
#import "CGlobal.h"
#import "UIView+Property.h"
#import "PersonalMainViewController.h"
#import "AppDelegate.h"

@implementation ConfirmBar

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"ConfirmBar initWithFrame");
        //        [self customLayout];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"ConfirmBar initWithCoder");
        //        [self customLayout];
    }
    self.backgroundColor = COLOR_PRIMARY;
    return self;
}
-(void)customLayout:(UIViewController*)vc{
    if (_constraint_Height!=nil) {
        _constraint_Height.constant = 50;
    }
    if (_btnMenu!=nil) {
        [_btnMenu addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
        _btnMenu.tag = 200;
    }
    if (_btnHome!=nil) {
        [_btnHome addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
        _btnHome.tag = 201;
    }
    self.drawerLayout = vc.view.drawerLayout;
    self.vc = vc;
    
    
    UIFont* font= [UIFont systemFontOfSize:18.0f weight:UIFontWeightHeavy];
    self.caption.font = font;
    [self updateCaption];
    
}
-(void)updateCaption{
    EnvVar*env = [CGlobal sharedId].env;
    if (env.lastLogin>0) {
        if (env.mode == c_PERSONAL) {
            // personal
            self.caption.text = [NSString stringWithFormat:@"Hi %@",env.nickname];
        }else if(env.mode == c_CORPERATION){
            self.caption.text = [NSString stringWithFormat:@"Hi %@",env.nickname];
            //
        }else if(env.mode == c_GUEST){
            //
            self.caption.text = @"Hi Guest";
        }else{
            self.caption.text = @"Hi ...";
        }
    }else{
        self.caption.text = @"Welcome";
    }
}
-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    EnvVar* env = [CGlobal sharedId].env;
    switch (tag) {
        case 200:
        {
            self.drawerLayout.openFromRight = NO;
            [self.drawerLayout openDrawer];
            break;
        }
        case 201:{
            if (_vc!=nil) {
                // home
                if (env.lastLogin>=0 && _vc.navigationController!= nil) {
                    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                    [delegate goHome:self.vc];
                    
                }else{
                    [CGlobal AlertMessage:@"Please Sign in" Title:nil];
                }
            }
            break;
        }
        default:
            break;
    }
}
@end
