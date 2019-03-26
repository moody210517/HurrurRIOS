//
//  OrderResponse.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderResponse.h"
#import "OrderRescheduleModel.h"
#import "OrderHisModel.h"
#import "QuoteModel.h"
#import "QuoteCoperationModel.h"
#import "OrderCorporateHisModel.h"
#import "OrderTrackModel.h"

@implementation OrderResponse
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray*array = obj;
            if ([obj isKindOfClass:[NSArray class]]) {
                self.orders = [[NSMutableArray alloc] init];
                for (int i=0; i< [array count]; i++) {
                    OrderRescheduleModel *ach = [[OrderRescheduleModel alloc] initWithDictionary:array[i]];
                    [self.orders addObject:ach];
                }
            }
        }
        
    }
    return self;
}
-(instancetype)initWithDictionary_his:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray*array = obj;
            if ([obj isKindOfClass:[NSArray class]]) {
                self.orders = [[NSMutableArray alloc] init];
                for (int i=0; i< [array count]; i++) {
                    OrderHisModel *ach = [[OrderHisModel alloc] initWithDictionary:array[i]];
                    [self.orders addObject:ach];
                }
            }
        }
        
    }
    return self;
}
-(instancetype)initWithDictionary_his_cor:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray*array = obj;
            if ([obj isKindOfClass:[NSArray class]]) {
                self.orders = [[NSMutableArray alloc] init];
                for (int i=0; i< [array count]; i++) {
                    OrderCorporateHisModel *ach = [[OrderCorporateHisModel alloc] initWithDictionary:array[i]];
                    [self.orders addObject:ach];
                }
            }
        }
        
    }
    return self;
}
-(instancetype)initWithDictionary_quote:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray*array = obj;
            if ([obj isKindOfClass:[NSArray class]]) {
                self.orders = [[NSMutableArray alloc] init];
                for (int i=0; i< [array count]; i++) {
                    QuoteModel *ach = [[QuoteModel alloc] initWithDictionary:array[i]];
                    [self.orders addObject:ach];
                }
            }
        }
        
    }
    return self;
}
-(instancetype)initWithDictionary_quote_cor:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray*array = obj;
            if ([obj isKindOfClass:[NSArray class]]) {
                self.orders = [[NSMutableArray alloc] init];
                for (int i=0; i< [array count]; i++) {
                    QuoteCoperationModel *ach = [[QuoteCoperationModel alloc] initWithDictionary:array[i]];
                    [self.orders addObject:ach];
                }
            }
        }
        
    }
    return self;
}
-(instancetype)initWithDictionary_track:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"orders"];
        if (obj!=nil && obj!= [NSNull null]) {
            OrderTrackModel *ach = [[OrderTrackModel alloc] initWithDictionary:obj];
            self.orderTrackModel = ach;
        }
        
    }
    return self;
}
@end
