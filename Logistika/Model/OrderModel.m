//
//  OrderModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [self initDefault];
        if (dict==nil) {
            [BaseModel parseResponse:self Dict:dict];
        }else{
            [BaseModel parseResponse:self Dict:dict];
        }
        
    }
    return self;
}
-(void)initDefault{
    self.itemModels = [[NSMutableArray alloc] init];
}
@end
