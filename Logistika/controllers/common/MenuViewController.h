//
//  MenuViewController.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BasicViewController.h"
#import "ECDrawerLayout.h"
#import "TopBarView.h"

@interface MenuViewController : BasicViewController<ECDrawerLayoutDelegate>
@property (weak, nonatomic) IBOutlet TopBarView *topBarView;

@end
