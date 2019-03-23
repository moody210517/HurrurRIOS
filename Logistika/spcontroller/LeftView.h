//
//  LeftView.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDrawerLayout.h"

#import "FontLabel.h"
#import "ColoredView.h"
#import "MenuItem.h"
#import "MyPopupDialog.h"

@interface LeftView : UIView<ViewDialogDelegate>

@property (weak, nonatomic) IBOutlet MenuItem *viewChangeLocation;


@property (weak, nonatomic) IBOutlet MenuItem *viewSignIn;
@property (weak, nonatomic) IBOutlet MenuItem *menuProfile;
@property (weak, nonatomic) IBOutlet MenuItem *menuQuotes;
@property (weak, nonatomic) IBOutlet MenuItem *menuOrderHistory;
@property (weak, nonatomic) IBOutlet MenuItem *menuAbout;
@property (weak, nonatomic) IBOutlet MenuItem *menuContact;
@property (weak, nonatomic) IBOutlet MenuItem *menuFeedback;
@property (weak, nonatomic) IBOutlet MenuItem *menuPrivacy;

@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnQuotes;
@property (weak, nonatomic) IBOutlet UIButton *btnOrderHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnAbout;
@property (weak, nonatomic) IBOutlet UIButton *btnContact;
@property (weak, nonatomic) IBOutlet UIButton *btnFeedback;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacy;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeLocation;


@property (strong, nonatomic) UIViewController*vc;
@property (weak, nonatomic) IBOutlet FontLabel *lblSignIn;

-(void)initMe:(UIViewController*)vc;
@property (copy, nonatomic) NSString *currentMenu;
@property (assign, nonatomic) NSInteger mode;
-(void)reopenOrderHistory:(int)page;
@end
