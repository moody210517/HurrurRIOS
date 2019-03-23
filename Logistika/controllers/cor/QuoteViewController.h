//
//  QuoteViewController.h
//  Logistika
//
//  Created by BoHuang on 4/28/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"
#import "ActionDelegate.h"

@interface QuoteViewController : MenuViewController<ActionDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewRoot;

@property (strong, nonatomic) NSMutableArray *views;
@end
