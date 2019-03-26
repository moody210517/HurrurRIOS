//
//  InfoView2.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "MyBaseView.h"
#import "OrderModel.h"

@interface InfoView2 : MyBaseView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_CAMERA;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_ITEM;
@property (weak, nonatomic) IBOutlet UIView *viewHeader_PACKAGE;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_TH;

@property (weak, nonatomic) IBOutlet UIView *viewItems;

@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel* lblDeliver;
@property (weak, nonatomic) IBOutlet UILabel* lblLoadType;

@property (nonatomic,strong) OrderModel *orderModel;
@property (nonatomic,strong) NSMutableArray* itemModels;
@property (weak, nonatomic) IBOutlet UIStackView *stackRoot;

-(CGFloat)getHeight;

@property (nonatomic,strong) NSMutableDictionary* height_dict;
@property (nonatomic,assign) CGFloat totalHeight;
@end
