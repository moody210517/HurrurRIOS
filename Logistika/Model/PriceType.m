//
//  PriceType.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PriceType.h"

@implementation PriceType
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        [BaseModel parseResponse:self Dict:dict];
    }
    return self;
}
-(void)initDefault{
    self.expedited_name = @"Expedited";
//    self.expeditied_price;
    self.expedited_duration = @"4 hours";
    
    self.express_name = @"Express";
//    self.express_price;
    self.express_duration = @"8 hours";
    
    self.economy_name = @"Economy";
//    self. economy_price;
    self.economy_duraiton = @"16 hours";
}
@end
