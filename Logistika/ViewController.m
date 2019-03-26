//
//  ViewController.m
//  Logistika
//
//  Created by BoHuang on 4/18/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "PayUManager.h"
#import "CGlobal.h"
#import "PersonalMainViewController.h"
#import "MyNavViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EnvVar* env = [CGlobal sharedId].env;
    if( env.lastLogin == 1){
        
//        AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [delegate goHome:self.vc];
        
        UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Personal" bundle:nil];
        PersonalMainViewController*vc = [ms instantiateViewControllerWithIdentifier:@"PersonalMainViewController"] ;
        MyNavViewController* nav = [[MyNavViewController alloc] initWithRootViewController:vc];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = nav;
        });
        return;
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat width = screenRect.size.width;
    CGFloat height = width*1080/1920.0;
    self.movieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:self.movieView];
    self.movieView.center = self.view.center;
    
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"new_white" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    [avPlayerLayer setFrame:[[UIScreen mainScreen] bounds]];
    
//    [avPlayerLayer setFrame:self.movieView.bounds];
    
    [avPlayerLayer setFrame:[self.movieView bounds]];
    [self.movieView.layer addSublayer:avPlayerLayer];
    
    
    
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //Config dark gradient view
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = [[UIScreen mainScreen] bounds];
//    gradient.colors = [NSArray arrayWithObjects:(id)[UIColorFromRGB(0x030303) CGColor], (id)[[UIColor clearColor] CGColor], (id)[UIColorFromRGB(0x030303) CGColor],nil];
//    [self.gradientView.layer insertSublayer:gradient atIndex:0];
//    
//    _gradientView.hidden = true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.avplayer pause];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.avplayer play];        
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
//    AVPlayerItem *p = [notification object];
//    [p seekToTime:kCMTimeZero];
    
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate defaultIntro];
}

- (void)playerStartPlaying
{
    [self.avplayer play];
}

@end
