//
//  CancelPickViewController.h
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MenuViewController.h"

@interface CancelPickViewController : MenuViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *viewRoot;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
