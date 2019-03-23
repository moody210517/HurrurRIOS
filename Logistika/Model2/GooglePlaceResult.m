//
//  GooglePlaceResult.m
//  travpholer
//
//  Created by Twinklestar on 9/1/16.
//  Copyright © 2016 BoHuang. All rights reserved.
//

#import "GooglePlaceResult.h"
#import "BaseModel.h"

@implementation GooglePlaceResult

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"result"];
        if (obj!=nil && obj!= [NSNull null]) {
            
            GooglePlace* place = [[GooglePlace alloc] initWithDictionary:obj];
            _result = place;
        }
        
        obj = [dict objectForKey:@"results"];
        if ([obj isKindOfClass:[NSArray class]]) {
            
            self.results = [[NSMutableArray alloc] init];
            NSArray* array = obj;
            for (int i=0; i<array.count; i++) {
                GooglePlace* place = [[GooglePlace alloc] initWithDictionary:array[i]];
                [self.results addObject:place];
            }
        }
    }
    return self;
}
@end
