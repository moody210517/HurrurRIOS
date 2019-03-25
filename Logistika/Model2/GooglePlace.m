//
//  GooglePlace.m
//  ResignDate
//
//  Created by BoHuang on 5/10/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import "GooglePlace.h"
#import "EftGoogleAddressComponent.h"
#import "BaseModel.h"

@implementation GooglePlace
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"address_components"];
        if (obj!=nil && obj!= [NSNull null]) {
            _address_components = [[NSMutableArray alloc] init];
            NSArray* array = (NSArray*)obj;
            for (int i=0; i< [array count]; i++) {
                id item = [array objectAtIndex:i];
                EftGoogleAddressComponent* place = [[EftGoogleAddressComponent alloc] initWithDictionary:item];
                [_address_components addObject:place];
            }
        }
        
        obj = dict[@"geometry"];
        if (obj != nil) {
            GoogleGeometry* model = [[GoogleGeometry alloc] initWithDictionary:obj];
            self.geometry = model;
        }
        
    }
    return self;
}

-(NSString*)getAddressForTextQuery{
    NSString*ret = nil;
    NSString*found1 = @"country";
    NSString*found2 = @"administrative_area_level_1";
    NSString*found3 = @"administrative_area_level_2";
    
    NSString* foundResult1 = @"";
    NSString* foundResult2 = @"";
    NSString* foundResult3 = @"";
    
    for (int i=0; i< [_address_components count]; i++) {
        EftGoogleAddressComponent*item = [_address_components objectAtIndex:i];
        for (NSString*type in item.types) {
            if ([type isEqualToString:found1]) {
                foundResult1 = item.long_name;
                break;
            }
            
            if ([type isEqualToString:found2]) {
                foundResult2 = item.long_name;
                break;
            }
            
            if ([type isEqualToString:found3]) {
                foundResult3 = item.long_name;
                break;
            }
        }
    }
    
    ret = [foundResult3 stringByAppendingString:foundResult2];
    ret = [ret stringByAppendingString:foundResult1];
    
    ret = [ret stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    if ([ret length]>0) {
        return ret;
    }
    return nil;
    
}
@end
