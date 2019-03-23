//
//  GeoCodeResult.m
//  Wordpress News App
//
//  Created by BoHuang on 6/11/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "GeoCodeResult.h"
#import "BaseModel.h"
#import "GooglePlace.h"

@implementation GeoCodeResult

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"results"];
        if (obj!=nil && obj!= [NSNull null]) {
            _results = [[NSMutableArray alloc] init];
            NSArray* array = (NSArray*)obj;
            for (int i=0; i< [array count]; i++) {
                id item = [array objectAtIndex:i];
                GooglePlace* place = [[GooglePlace alloc] initWithDictionary:item];
                [_results addObject:place];
            }
        }
    }
    return self;
}
@end
