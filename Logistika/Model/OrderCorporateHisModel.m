//
//  OrderCorporateHisModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderCorporateHisModel.h"

@implementation OrderCorporateHisModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict!=nil) {
            // origin : remote
            NSDictionary*abcDict = @{@"orderId":@"id" ,
                                     @"trackId":@"track",
                                     @"state":@"state",
                                     @"payment":@"payment",
                                     @"deliver":@"description",
                                     @"accepted_by":@"accepted_by",
                                     @"loadType":@"loadtype",
                                     @"receiver_signature":@"receiver_signature"};
            
            [BaseModel parseResponseABC:self Dict:dict ABC:abcDict];
            
            self.dateModel.date = dict[@"date"] ;
            self.dateModel.time = dict[@"time"] ;
            
            self.serviceModel.name = dict[@"service_name"] ;
            self.serviceModel.price = dict[@"service_price"] ;
            self.serviceModel.time_in = dict[@"service_timein"] ;
            
            if (dict[@"addresses"]!=nil) {
                NSArray*obj = dict[@"addresses"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    for (int i=0; i<obj.count; i++) {
                        NSMutableDictionary*idict = obj[i];
                        self.addressModel = [[AddressModel alloc] initWithDictionary:idict];
                    }
                }
            }
            
            id obj = dict[@"carrier"];
            if (obj!=nil && obj!= [NSNull null]) {
                NSArray*array = obj;
                if ([obj isKindOfClass:[NSArray class]]) {
                    for (int i=0; i<array.count; i++) {
                        NSMutableDictionary*idict = array[i];
                        self.carrierModel = [[CarrierModel alloc] initWithDictionary:idict];
                        
                    }
                }
            }
            if (self.loadType == nil) {
                self.loadType = self.carrierModel.freight;
            }
        }
    }
    return self;
}
-(void)initDefault{
    self.addressModel = [[AddressModel alloc] initWithDictionary:nil];
    self.serviceModel = [[ServiceModel alloc] initWithDictionary:nil];
    self.dateModel = [[DateModel alloc] initWithDictionary:nil];
    self.carrierModel = [[CarrierModel alloc] initWithDictionary:nil];
    
    self.viewContentHidden = true;
    self.cellSizeCalculated = false;
    
    self.cellSize = CGSizeMake(0, 100);
    self.cellSize_small = CGSizeMake(0, 100);
}
@end
