//
//  CarrierModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CarrierModel.h"

@implementation CarrierModel

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        if (dict!=nil) {
            self.id = [dict[@"id"] stringValue];
            self.order_id = [dict[@"order_id"] stringValue];
            self.freight = dict[@"freight"];
            self.load_type = dict[@"load_type"];
            self.consignment = dict[@"consignment"];
            self.date = dict[@"date"];
            self.time = dict[@"time"];
            self.vehicle = dict[@"vehicle"];
            self.driver_id = dict[@"driver_id"];
            self.driver_name = dict[@"driver_name"];
            self.signature = dict[@"signature"];
        }
    }
    return self;
}
@end
