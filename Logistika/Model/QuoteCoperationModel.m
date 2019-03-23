//
//  QuoteCoperationModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "QuoteCoperationModel.h"

@implementation QuoteCoperationModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        
        if (dict!=nil) {
            
//            [BaseModel parseResponse:self Dict:dict];
            
            self.orderId = [dict[@"id"] stringValue];
            self.trackId = dict[@"track"];
            
            self.name = dict[@"name"];
            self.address = dict[@"address"];
            self.phone = dict[@"phone"];
            self.ddescription = dict[@"description"];
            self.loadtype = dict[@"loadtype"];
            
            self.dateModel.date = dict[@"date"];
            self.dateModel.time = dict[@"time"];
            self.quote_id = [dict[@"quote_id"] stringValue];
            
//            self.serviceModel.name = dict[@"service_name"];
//            self.serviceModel.price = dict[@"service_price"];
//            self.serviceModel.time_in = dict[@"service_timein"];
            
            
            if (dict[@"addresses"]!=nil) {
                NSArray*obj = dict[@"addresses"];
                if ([obj isKindOfClass:[NSArray class]]) {
                    for (int i=0; i<obj.count; i++) {
                        NSMutableDictionary*idict = obj[i];
                        self.addressModel = [[AddressModel alloc] initWithDictionary:idict];
                    }
                }
            }
            
            id obj = dict[@"service"];
            if (obj!=nil && obj!= [NSNull null]) {
                NSArray*array = obj;
                if ([obj isKindOfClass:[NSArray class]]) {
                    for (int i=0; i<array.count; i++) {
                        NSMutableDictionary*idict = array[i];
                        self.expeditedService.name = idict[@"expedited_name"];
                        self.expeditedService.price = idict[@"expedited_price"];
                        self.expeditedService.time_in = idict[@"expedited_duration"];
                        
                        self.expressService.name = idict[@"express_name"];
                        self.expressService.price = idict[@"express_price"];
                        self.expressService.time_in = idict[@"express_duration"];
                        
                        self.economyService.name = idict[@"economy_name"];
                        self.economyService.price = idict[@"economy_price"];
                        self.economyService.time_in = idict[@"economy_duration"];
                        
                    }
                }
                
            }
        }
        
    }
    return self;
}
-(void)initDefault{
    self.expeditedService = [[ServiceModel alloc] initWithDictionary:nil];
    self.expressService = [[ServiceModel alloc] initWithDictionary:nil];
    self.economyService = [[ServiceModel alloc] initWithDictionary:nil];
    
    self.addressModel = [[AddressModel alloc] initWithDictionary:nil];
    self.serviceModel = [[ServiceModel alloc] initWithDictionary:nil];
    self.dateModel = [[DateModel alloc] initWithDictionary:nil];
}
@end
