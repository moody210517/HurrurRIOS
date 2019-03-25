//
//  RescheduleViewController.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "RescheduleViewController.h"
#import "NetworkParser.h"
#import "CGlobal.h"
#import "OrderRescheduleModel.h"
#import "OrderResponse.h"
#import "ViewScrollContainer.h"
#import "RescheduleItemView.h"
#import "OrderRescheduleModel.h"
#import "RescheduleTableViewCell.h"

@interface RescheduleViewController ()
@property(nonatomic,strong) OrderResponse*response;
@end

@implementation RescheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.view.backgroundColor = COLOR_PRIMARY;
    self.viewRoot.backgroundColor = COLOR_SECONDARY_THIRD;
    
    NSArray* tvs = @[self.tableview];
    for (int i=0; i<tvs.count; i++) {
        UITableView* tv = tvs[i];
        UINib* nib1 = [UINib nibWithNibName:@"RescheduleTableViewCell" bundle:nil];
        [tv registerNib:nib1 forCellReuseIdentifier:@"cell"];
        tv.separatorStyle = UITableViewCellSelectionStyleNone;
        tv.hidden = false;
        tv.delegate = self;
        tv.dataSource = self;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.topBarView.caption.text = @"Reschedule A Pick Up";
}
-(void)addViews{
    // determine area
    CGRect bound = [[UIScreen mainScreen] bounds];
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat headerHeight = self.topBarView.constraint_Height.constant;
    CGFloat topSpace = statusHeight+headerHeight;
    CGRect rect = CGRectMake(0, topSpace, bound.size.width, bound.size.height - topSpace);
    
    CGFloat dx = 8;
    CGFloat dy = 8;
    CGRect newRect = CGRectInset(rect, dx, dy);
    
    for (UIView *subview in self.viewRoot.subviews)
    {
        [subview removeFromSuperview];
    }
    
    ViewScrollContainer* scrollContainer = (ViewScrollContainer*)[[NSBundle mainBundle] loadNibNamed:@"ViewScrollContainer" owner:self options:nil][0];
    for (int i=0; i<self.response.orders.count; i++) {
        OrderRescheduleModel*model = self.response.orders[i];
        RescheduleItemView* itemView = (ViewScrollContainer*)[[NSBundle mainBundle] loadNibNamed:@"RescheduleItemView" owner:self options:nil][0];
//        [itemView firstProcess:0];
        
        [scrollContainer addOneView:itemView];
        [itemView setModelData:model VC:self];
        itemView.vc = self;
        
        if (i == self.response.orders.count - 1) {
            itemView.lblSeperator.hidden = true;
        }else{
            itemView.lblSeperator.hidden = false;
        }
    }
    
    if (self.response.orders.count>0) {
//        [self.viewRoot addSubview:scrollContainer];
        scrollContainer.frame = CGRectMake(dx, dy, newRect.size.width, newRect.size.height);
        
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
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"get_orders" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        [CGlobal stopIndicator:self];
        if (error == nil) {
            // succ
            if (dict[@"result" ]!=nil) {
                if ([dict[@"result"] intValue] == 200) {
                    [self clearReschedule];
                    
                    // parse
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary:dict];
                    self.response = response;
                    [self.tableview reloadData];
                    if (self.response.orders.count > 0) {
                        return;
                    }
                }
            }
            
        }else{
            // error
            NSLog(@"Error");
        }
        [CGlobal AlertMessage:@"No Orders" Title:nil];
    } method:@"POST"];
}
-(void)clearReschedule{
    g_orderRescheduleModels = [[NSMutableArray alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.response.orders.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderRescheduleModel*model = self.response.orders[indexPath.row];
    
    if (model.viewContentHidden) {
        NSLog(@"reschedule %d",250);
        return 250.0f;
    }
    CGSize size = model.cellSize;
    
    NSLog(@"reschedule %d",size.height + 30);
    return size.height + 30;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RescheduleTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    OrderRescheduleModel*model = self.response.orders[indexPath.row];
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    data[@"indexPath"] = indexPath;
    data[@"tableView"] = tableView;
    data[@"model"] = model;
    data[@"vc"] = self;
    data[@"aDelegate"] = self;
    [cell setData:data Mode:0];
    
    cell.backgroundColor = COLOR_SECONDARY_THIRD;
    return cell;
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
