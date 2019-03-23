//
//  OrderHisCorViewController.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderHisCorViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "OrderCorporateHisModel.h"
#import "ViewScrollContainer.h"
#import "OrderItemCorView.h"
#import "OrderCorTableViewCell.h"

@interface OrderHisCorViewController ()
@property(nonatomic,strong) OrderResponse*response;

@property(nonatomic,strong) NSMutableArray*data_0;
@property(nonatomic,strong) NSMutableArray*data_1;
@property(nonatomic,strong) NSMutableArray*data_2;

@property(nonatomic,assign) BOOL stackAdded_0;
@property(nonatomic,assign) BOOL stackAdded_1;
@property(nonatomic,assign) BOOL stackAdded_2;
@property(nonatomic,assign) NSInteger curPage;

@end

@implementation OrderHisCorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stackAdded_0 = false;
    self.stackAdded_1 = false;
    self.stackAdded_2 = false;
    self.view.backgroundColor = COLOR_PRIMARY;
    self.viewSegBack.backgroundColor = COLOR_SECONDARY_THIRD;
    self.viewRoot.backgroundColor = COLOR_SECONDARY_THIRD;
    
    self.data_0 = [[NSMutableArray alloc] init];
    self.data_1 = [[NSMutableArray alloc] init];
    self.data_2 = [[NSMutableArray alloc] init];
    self.curPage = 0;
    [self loadData];
    NSArray* tvs = @[self.tableView1,self.tableView2,self.tableView3];
    for (int i=0; i<tvs.count; i++) {
        UITableView* tv = tvs[i];
        UINib* nib1 = [UINib nibWithNibName:@"OrderCorTableViewCell" bundle:nil];
        [tv registerNib:nib1 forCellReuseIdentifier:@"cell"];
        tv.separatorStyle = UITableViewCellSelectionStyleNone;
        tv.hidden = false;
        tv.delegate = self;
        tv.dataSource = self;
    }
    
    self.segControl.tintColor = COLOR_PRIMARY;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.topBarView.caption.text = @"Order History";
}
-(void)setCurPage:(NSInteger)curPage{
    _curPage = curPage;
    NSArray* views = @[self.viewRoot1,self.viewRoot2,self.viewRoot3];
    NSArray* tvs = @[self.tableView1,self.tableView2,self.tableView3];
    for (int i=0; i<views.count; i++) {
        UIView* view = views[i];
        UITableView*tv = tvs[i];
        view.hidden = true;
    }
    UIView* view = views[curPage];
    UITableView*tv = tvs[curPage];
    
    view.hidden = false;
    [tv reloadData];
}
-(void)filterData{
    int type_none = 0;
    int type_complete = 4;
    int type_pending = 2;
    int type_returned = 6;
    self.data_0 = [[NSMutableArray alloc] init];
    self.data_1 = [[NSMutableArray alloc] init];
    self.data_2 = [[NSMutableArray alloc] init];
    for (int i=0; i<_response.orders.count; i++) {
        OrderCorporateHisModel*model = self.response.orders[i];
        int state = [model.state intValue];
        if (state == 2 || state == 3 || state == 5  ) { // || state == 1
            [self.data_1 addObject:model];
        }
        else if (state == 4 || state == 0) {
            [self.data_0 addObject:model];
        }else{
            if (state == 6){
                [self.data_2 addObject:model];
            }
        }
    }
    [self sortData:self.data_0];
    [self sortData:self.data_1];
    [self sortData:self.data_2];
    
//    [self addViews:self.data_0 Parent:self.viewRoot1];
//    self.stackAdded_0 = true;
//    [self addViews:self.data_1 Parent:self.viewRoot2];
//    [self addViews:self.data_2 Parent:self.viewRoot3];
    
//    self.viewRoot1.hidden = false;
//    self.viewRoot2.hidden = true;
//    self.viewRoot3.hidden = true;
    self.curPage = 0;
    
    if (self.data_0.count == 0 && self.data_1.count == 0 && self.data_2.count == 0) {
        [CGlobal stopIndicator:self];
        [CGlobal AlertMessage:@"No Orders" Title:nil];
    }
}
-(void)addViews:(NSMutableArray*)data Parent:(UIView*)view{
    if (data.count == 0) {
        return;
    }
    // determine area
    CGRect bound = [[UIScreen mainScreen] bounds];
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat headerHeight = self.topBarView.constraint_Height.constant;
    CGFloat topSpace = statusHeight+headerHeight+50;
    CGRect rect = CGRectMake(0, topSpace, bound.size.width, bound.size.height - topSpace);
    
    CGFloat dx = 0;
    CGFloat dy = 0;
    CGRect newRect = CGRectInset(rect, dx, dy);
    
    for (UIView *subview in view.subviews)
    {
        [subview removeFromSuperview];
    }
    
    ViewScrollContainer* scrollContainer = (ViewScrollContainer*)[[NSBundle mainBundle] loadNibNamed:@"ViewScrollContainer" owner:self options:nil][0];
    for (int i=0; i<data.count; i++) {
        OrderCorporateHisModel*model = data[i];
        OrderItemCorView* itemView = (OrderItemCorView*)[[NSBundle mainBundle] loadNibNamed:@"OrderItemCorView" owner:self options:nil][0];
        [itemView firstProcess:0 Data:model VC:self];
        [scrollContainer addOneView:itemView];
    }
    
    if (self.response.orders.count>0) {
        [view addSubview:scrollContainer];
        scrollContainer.frame = CGRectMake(dx, dy, newRect.size.width, newRect.size.height);
        
    }
}
-(void)sortData:(NSMutableArray*)data{
    [data sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        OrderCorporateHisModel*model1 = obj1;
        OrderCorporateHisModel*model2 = obj2;
        int int1 = [model1.orderId intValue];
        int int2 = [model2.orderId intValue];
        NSNumber* n1 =[NSNumber numberWithInt:int1];
        NSNumber* n2 =[NSNumber numberWithInt:int2];
        return [n2 compare:n1];
    }];
}
- (IBAction)segChanged:(id)sender {
    NSInteger index= self.segControl.selectedSegmentIndex;
    self.curPage = index;
    return;
    switch (index) {
        case 0:
        {
            self.viewRoot1.hidden = false;
            self.viewRoot2.hidden = true;
            self.viewRoot3.hidden = true;
            break;
        }
        case 1:
        {
            if (self.stackAdded_1 == false) {
                [CGlobal showIndicator:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addViews:self.data_1 Parent:self.viewRoot2];
                    self.stackAdded_1 = true;
                    [CGlobal stopIndicator:self];
                });
            }
            self.viewRoot1.hidden = true;
            self.viewRoot2.hidden = false;
            self.viewRoot3.hidden = true;
            
            break;
        }
        case 2:
        {
            if (self.stackAdded_2 == false) {
                [CGlobal showIndicator:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addViews:self.data_2 Parent:self.viewRoot3];
                    self.stackAdded_2 = true;
                    [CGlobal stopIndicator:self];
                });
                
                
            }
            self.viewRoot1.hidden = true;
            self.viewRoot2.hidden = true;
            self.viewRoot3.hidden = false;
            
            break;
        }
        default:
        {
            break;
        }
    }
}
-(void)loadData{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    EnvVar* env = [CGlobal sharedId].env;
    if (env.mode == c_PERSONAL) {
        params[@"user_id"] = env.user_id;
    }else if(env.mode == c_CORPERATION){
        params[@"user_id"] = env.corporate_user_id;
    }
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"get_corporate_orders_his" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            // succ
            if (dict[@"orders" ]!=nil) {
                [self clearReschedule];
                
                // parse
                OrderResponse* response = [[OrderResponse alloc] initWithDictionary_his_cor:dict];
                self.response = response;
                if (self.response.orders.count == 0) {
                    [CGlobal AlertMessage:@"No Orders" Title:nil];
                    
                }else{
                    [self filterData];
                }
                
                
                [CGlobal stopIndicator:self];
                return;
            }
            
        }else{
            // error
            NSLog(@"Error");
        }
        [CGlobal AlertMessage:@"No Orders" Title:nil];
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clearReschedule{
    g_orderCorporateHisModels = [[NSMutableArray alloc] init];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView1) {
        return self.data_0.count;
    }else if(tableView == self.tableView2){
        return self.data_1.count;
    }else{
        return self.data_2.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCorporateHisModel*model;
    if (tableView == self.tableView1) {
        model = self.data_0[indexPath.row];
    }else if(tableView == self.tableView2){
        model = self.data_1[indexPath.row];
    }else{
        model = self.data_2[indexPath.row];
    }
    if (model.viewContentHidden) {
        return 100.0f;
    }
    CGSize size = model.cellSize;
    return size.height + 30;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCorTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    OrderCorporateHisModel*model;
    if (tableView == self.tableView1) {
        model = self.data_0[indexPath.row];
    }else if(tableView == self.tableView2){
        model = self.data_1[indexPath.row];
    }else{
        model = self.data_2[indexPath.row];
    }
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    data[@"indexPath"] = indexPath;
    data[@"tableView"] = tableView;
    data[@"model"] = model;
    data[@"vc"] = self;
    data[@"aDelegate"] = self;
    [cell setData:data];
    cell.backgroundColor = COLOR_SECONDARY_THIRD;
    return cell;
}
-(void)didSubmit:(NSDictionary *)data View:(UIView *)view{
    if ([view isKindOfClass:[OrderItemCorView class]]) {
        if( [data[@"tableView"] isKindOfClass:[UITableView class]]){
            UITableView*tv = data[@"tableView"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tv reloadData];
            });
        };
        
    }
}

@end
