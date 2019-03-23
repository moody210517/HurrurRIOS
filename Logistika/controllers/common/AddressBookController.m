//
//  AddressBookController.m
//  Logistika
//
//  Created by Venu Talluri on 01/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import "AddressBookController.h"
#import "OrderHisModel.h"
#import "AddressHisModel.h"
#import "CGlobal.h"
#import "NetworkParser.h"
#import "OrderResponse.h"
#import "ViewScrollContainer.h"
#import "MenuViewController.h"

@interface AddressBookController ()
@property(nonatomic,strong) OrderResponse*response;
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
//[self clearReschedule];
                    // parse
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary_his:dict];
                    self.response = response;
                    
                    if (self.response.orders.count == 0) {
                        
                        [CGlobal stopIndicator:self];
                        [CGlobal AlertMessage:@"No Address" Title:nil];
                    }else{
                        [self filterData];
                        [self addViews];
                
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
        AddressHisModel* hisModel = self.addresses[i];
        if( [hisModel.address isEqualToString:model.addressModel.sourceAddress] )
            return true;
    }
    
    if([g_addressModel.sourceAddress isEqualToString:model.addressModel.sourceAddress])
        return true;
    if([g_addressModel.desAddress isEqualToString:model.addressModel.sourceAddress])
        return true;
        
    return false;
}
-(Boolean)containsDes:(OrderHisModel*)model{
    for(int i = 0; i < self.addresses.count ; i++){
        AddressHisModel* hisModel = self.addresses[i];
        if( [hisModel.address isEqualToString:model.addressModel.desAddress ] )
            return true;
    }
    
    if([g_addressModel.sourceAddress isEqualToString:model.addressModel.desAddress])
        return true;
    if([g_addressModel.desAddress isEqualToString:model.addressModel.desAddress])
        return true;
    
    return false;
}

-(void)filterData{
    
    int type_none = 0;
    int type_complete = 4;
    int type_pending = 2;
    int type_returned = 6;
    
    for (int i=0; i<_response.orders.count; i++) {
        OrderHisModel* model = self.response.orders[i];
        if(![self containsSource:model]){
            AddressHisModel* hisModel = [[AddressHisModel alloc] init];
            hisModel.address = model.addressModel.sourceAddress;
            hisModel.area = model.addressModel.sourceArea;
            hisModel.city = model.addressModel.sourceCity;
            hisModel.landmark = model.addressModel.sourceLandMark;
            hisModel.pincode = model.addressModel.sourcePinCode;
            hisModel.phone = model.addressModel.sourcePhonoe;
            hisModel.lat = model.addressModel.sourceLat;
            hisModel.lng = model.addressModel.sourceLng;
            hisModel.state = model.addressModel.sourceState;
            hisModel.name = model.addressModel.sourceName;
            hisModel.instruction = model.addressModel.sourceInstruction;
            [self.addresses addObject:hisModel];
        }
        
        if(![self containsDes:model]){
            AddressHisModel* hisModel = [[AddressHisModel alloc] init];
            hisModel.address = model.addressModel.desAddress;
            hisModel.area = model.addressModel.desArea;
            hisModel.city = model.addressModel.desCity;
            hisModel.landmark = model.addressModel.desLandMark;
            hisModel.pincode = model.addressModel.desPinCode;
            hisModel.phone = model.addressModel.desPhone;
            hisModel.lat = model.addressModel.desLat;
            hisModel.lng = model.addressModel.desLng;
            hisModel.state = model.addressModel.desState;
            hisModel.name = model.addressModel.desName;
            hisModel.instruction = model.addressModel.desInstruction;
            [self.addresses addObject:hisModel];
            
        }
    
    }
    
   //// [self sortData:self.addresses];
   


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
    int _index = -1;
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
  //  self.views = [[NSMutableArray alloc] init];
    
    ViewScrollContainer* scrollContainer = (ViewScrollContainer*)[[NSBundle mainBundle] loadNibNamed:@"ViewScrollContainer" owner:self options:nil][0];
    for (int i=0; i<self.addresses.count; i++) {
        
//        AddressHisModel*model = self.addresses[i];
//        QuoteItemView* itemView = (QuoteItemView*)[[NSBundle mainBundle] loadNibNamed:@"QuoteItemView" owner:self options:nil][0];
//        [itemView firstProcess:i Data:model VC:self];
//
//        [scrollContainer addOneView:itemView];
//
//        [self.views addObject:itemView];
//
//        if (i == self.response.orders.count - 1) {
//            itemView.viewSeperator.hidden = true;
//        }
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
