//
//  AddressBookController.m
//  Logistika
//
//  Created by Venu Talluri on 01/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import "AddressBookController.h"
#import "OrderHisModel.h"

@interface AddressBookController ()

@end

@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
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
                        [CGlobal AlertMessage:@"No Address" Title:nil];
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

-(Boolean)containsSource:(OrderHisModel*)model{
    for(int i = 0; i < self.addresses.count ; i++){
        OrderHisModel* orderHisModel = self.addresses[i];
        if([orderHisModel key)
    }
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
        OrderHisModel* model = self.response.orders[i];
        if([self ])
        
        
        [self.addresses addObject:model.addressModel];
        
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

-(void)addViews{
    // determine area
    _index = -1;
    CGRect bound = [[UIScreen mainScreen] bounds];
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat headerHeight = self.topBarView.constraint_Height.constant;
    CGFloat topSpace = statusHeight+headerHeight+50;
    CGRect rect = CGRectMake(0, topSpace, bound.size.width, bound.size.height - topSpace);
    
    CGFloat dx = 8;
    CGFloat dy = 8;
    CGRect newRect = CGRectInset(rect, dx, dy);
    
    for (UIView *subview in self.viewRoot.subviews)
    {
        [subview removeFromSuperview];
    }
    self.views = [[NSMutableArray alloc] init];
    
    ViewScrollContainer* scrollContainer = (ViewScrollContainer*)[[NSBundle mainBundle] loadNibNamed:@"ViewScrollContainer" owner:self options:nil][0];
    for (int i=0; i<self.response.orders.count; i++) {
        QuoteModel*model = self.response.orders[i];
        QuoteItemView* itemView = (QuoteItemView*)[[NSBundle mainBundle] loadNibNamed:@"QuoteItemView" owner:self options:nil][0];
        [itemView firstProcess:i Data:model VC:self];
        
        [scrollContainer addOneView:itemView];
        
        [self.views addObject:itemView];
        
        if (i == self.response.orders.count - 1) {
            itemView.viewSeperator.hidden = true;
        }
    }
    
    if (self.response.orders.count>0) {
        [self.viewRoot addSubview:scrollContainer];
        scrollContainer.frame = CGRectMake(dx, dy, newRect.size.width, newRect.size.height);
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
