//
//  CitySelectView.h
//  Logistika
//
//  Created by BoHuang on 9/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBaseView.h"
@interface CitySelectView : MyBaseView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

-(void)setData:(NSDictionary *)data;

@property (strong, nonatomic) NSMutableArray* list_city;
@end
