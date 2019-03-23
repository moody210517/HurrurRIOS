//
//  OrderHistoryTopViewController.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderHistoryTopViewController.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "OrderHisModel.h"
#import "ViewScrollContainer.h"
#import "OrderItemView.h"
#import "OrderTableViewCell.h"
#import "RescheduleDateInput.h"
#import "UIView+Property.h"

@interface OrderHistoryTopViewController ()
@property(nonatomic,strong) OrderResponse*response;

@property(nonatomic,strong) NSMutableArray*data_0;
@property(nonatomic,strong) NSMutableArray*data_1;
@property(nonatomic,strong) NSMutableArray*data_2;

@property(nonatomic,assign) BOOL stackAdded_0;
@property(nonatomic,assign) BOOL stackAdded_1;
@property(nonatomic,assign) BOOL stackAdded_2;

@property(nonatomic,assign) NSInteger curPage;
@end

@implementation OrderHistoryTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_PRIMARY;
    self.viewSegBack.backgroundColor = COLOR_SECONDARY_THIRD;
    self.viewRoot.backgroundColor = COLOR_SECONDARY_THIRD;
    self.tableView1.backgroundColor = COLOR_SECONDARY_THIRD;
    self.tableView2.backgroundColor = COLOR_SECONDARY_THIRD;
    self.tableView3.backgroundColor = COLOR_SECONDARY_THIRD;
    // Do any additional setup after loading the view.
    self.stackAdded_0 = false;
    self.stackAdded_1 = false;
    self.stackAdded_2 = false;
    
    
    self.data_0 = [[NSMutableArray alloc] init];
    self.data_1 = [[NSMutableArray alloc] init];
    self.data_2 = [[NSMutableArray alloc] init];
    [self loadData];
    
    NSArray* tvs = @[self.tableView1,self.tableView2,self.tableView3];
    for (int i=0; i<tvs.count; i++) {
        UITableView* tv = tvs[i];
        UINib* nib1 = [UINib nibWithNibName:@"OrderTableViewCell" bundle:nil];
        [tv registerNib:nib1 forCellReuseIdentifier:@"cell"];
        tv.separatorStyle = UITableViewCellSelectionStyleNone;
        tv.hidden = false;
        tv.delegate = self;
        tv.dataSource = self;
    }
    
    
    //    self.segControl.tintColor = COLOR_PRIMARY;
    self.segControl.tintColor = COLOR_PRIMARY;
    
    self.segControl.layer.cornerRadius = 4;
    self.segControl.layer.masksToBounds = true;
    self.segControl.layer.backgroundColor = [UIColor whiteColor].CGColor;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.topBarView.caption.text = @"Order History";
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
        OrderHisModel*model = self.response.orders[i];
        int state = [model.state intValue];
        if (state == 2 || state == 3 || state == 5 || state == 1) {
            if (!([model.is_quote_request isEqualToString:@"1"] && state == 1)) {
                [self.data_1 addObject:model];
            }
        }else if(state == 4 || state == 0){
            [self.data_0 addObject:model];
        }else{
            if (state == 0 || state == 6) {
                [self.data_2 addObject:model];
            }
        }
    }
    [self sortData:self.data_0];
    [self sortData:self.data_1];
    [self sortData:self.data_2];
    
    if(self.param1 == 1){
        [self.segControl setSelectedSegmentIndex:1];
        self.curPage = 1;
    }else{
        [self.segControl setSelectedSegmentIndex:0];
        self.curPage = 0;
    }
    //    [self addViews:self.data_0 Parent:self.viewRoot1];
    //    self.stackAdded_0 = true;
    //    [self addViews:self.data_1 Parent:self.viewRoot2];
    //    [self addViews:self.data_2 Parent:self.viewRoot3];
    
    if (self.data_0.count == 0 && self.data_1.count == 0 && self.data_2.count == 0) {
        [CGlobal stopIndicator:self];
        [CGlobal AlertMessage:@"No Orders" Title:nil];
    }
}
-(void)setCurPage:(NSInteger)curPage{
    _curPage = curPage;
    [CGlobal showIndicator:self];
    dispatch_async(dispatch_get_main_queue(), ^{
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
        
        [CGlobal stopIndicator:self];
    });
    
}
-(void)sortData:(NSMutableArray*)data{
    [data sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        OrderHisModel*model1 = obj1;
        OrderHisModel*model2 = obj2;
        int int1 = [model1.orderId intValue];
        int int2 = [model2.orderId intValue];
        NSNumber* n1 =[NSNumber numberWithInt:int1];
        NSNumber* n2 =[NSNumber numberWithInt:int2];
        return [n2 compare:n1];
    }];
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
        OrderHisModel*model = data[i];
        OrderItemView* itemView = (OrderItemView*)[[NSBundle mainBundle] loadNibNamed:@"OrderItemView" owner:self options:nil][0];
        [itemView firstProcess:0 Data:model VC:self];
        [scrollContainer addOneView:itemView];
        
        
    }
    
    if (self.response.orders.count>0) {
        [view addSubview:scrollContainer];
        scrollContainer.frame = CGRectMake(dx, dy, newRect.size.width, newRect.size.height);
        
    }
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
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"get_orders_his" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            // succ
            if (dict[@"result" ]!=nil) {
                if ([dict[@"result"] intValue] == 200) {
                    [self clearReschedule];
                    
                    // parse
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary_his:dict];
                    self.response = response;
                    if (self.response.orders.count == 0) {
                        
                        [CGlobal stopIndicator:self];
                        [CGlobal AlertMessage:@"No Orders" Title:nil];
                    }else{
                        [self filterData];
                        [CGlobal stopIndicator:self];
                    }
                    
                    return;
                }
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
    g_orderHisModels = [[NSMutableArray alloc] init];
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
    OrderHisModel*model;
    if (tableView == self.tableView1) {
        model = self.data_0[indexPath.row];
    }else if(tableView == self.tableView2){
        model = self.data_1[indexPath.row];
    }else{
        model = self.data_2[indexPath.row];
    }
    CGFloat padding = 30.0f;
    if (model.viewContentHidden) {
        CGFloat padding = 10.0f;
        NSLog(@"orderhistory %d column = %d",100,indexPath.row);
        //        if([model.state intValue] == 1){
        //            return 150.0f + padding;
        //        }else{
        //            return 100.0f + padding;
        //        }
        return 100.0f + padding;
    }
    CGSize size = model.cellSize;
    CGFloat height = size.height + padding;
    
    if (indexPath.row == 3) {
        NSLog(@"ooooooooooooo %f column = %d",1162.0f, indexPath.row );
        return 1162.0f;
    }
    NSLog(@"ooooooooooooo %f column = %d",height, indexPath.row );
    return height;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    OrderHisModel*model;
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
    
    cell.orderItemView.backgroundColor = COLOR_RESERVED;
    return cell;
}
-(void)didSubmit:(NSDictionary *)data View:(UIView *)view{
    if ([view isKindOfClass:[OrderItemView class]]) {
        if( [data[@"tableView"] isKindOfClass:[UITableView class]]){
            UITableView*tv = data[@"tableView"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tv reloadData];
            });
        };
        
    }else if ([view isKindOfClass:[RescheduleDateInput class]]) {
        self.curPage = _curPage;
        if ([view.xo isKindOfClass:[MyPopupDialog class]]) {
            MyPopupDialog * dlg = (MyPopupDialog*)view.xo;
            [dlg dismissPopup];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.curPage = _curPage;
        });
        
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
