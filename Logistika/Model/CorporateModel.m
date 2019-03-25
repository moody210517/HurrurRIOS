//
//  CorporateModel.m
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CorporateModel.h"

@implementation CorporateModel


-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [BaseModel parseResponse:self Dict:dict];
    }
    return self;
}
@end
