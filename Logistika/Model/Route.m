//
//  Route.m
//  Logistika
//
//  Created by BoHuang on 8/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "Route.h"

@implementation Route

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict!=nil) {
            NSDictionary*abcDict = @{@"startAddress":@"start_address" ,
                                     @"endAddress":@"end_address",
                                     @"startLat":@"service_timein"};
            
            [BaseModel parseResponseABC:self Dict:dict ABC:abcDict];
        }
        //        [BaseModel parseResponse:self Dict:dict];
    }
    return self;
}
-(void)initDefault{
    self.listStep = [[NSMutableArray alloc] init];
}
@end
