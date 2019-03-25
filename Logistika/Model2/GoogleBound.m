//
//  GoogleBound.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GoogleBound.h"

@implementation GoogleBound

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"northeast"];
        if (obj!=nil && obj!= [NSNull null]) {
            GooglePos *model = [[GooglePos alloc] initWithDictionary:obj];
            self.northeast = model;
        }
        
        obj = [dict objectForKey:@"southwest"];
        if (obj!=nil && obj!= [NSNull null]) {
            GooglePos *model = [[GooglePos alloc] initWithDictionary:obj];
            self.southwest = model;
        }
    }
    return self;
}

@end
