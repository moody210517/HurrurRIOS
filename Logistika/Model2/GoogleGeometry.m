//
//  GoogleGeometry.m
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GoogleGeometry.h"

@implementation GoogleGeometry

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"bounds"];
        if (obj!=nil && obj!= [NSNull null]) {
            GoogleBound *model = [[GoogleBound alloc] initWithDictionary:obj];
            self.bounds = model;
        }
        
        obj = [dict objectForKey:@"southwest"];
        if (obj!=nil && obj!= [NSNull null]) {
            GooglePos *model = [[GooglePos alloc] initWithDictionary:obj];
            self.location = model;
        }
        
        obj = [dict objectForKey:@"viewport"];
        if (obj!=nil && obj!= [NSNull null]) {
            GoogleBound *model = [[GoogleBound alloc] initWithDictionary:obj];
            self.viewport = model;
        }
        
        obj = [dict objectForKey:@"location"];
        if (obj!=nil && obj!= [NSNull null]) {
            GooglePos *model = [[GooglePos alloc] initWithDictionary:obj];
            self.location = model;
        }
        
    }
    return self;
}

@end
