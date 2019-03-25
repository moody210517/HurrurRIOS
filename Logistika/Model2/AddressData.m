//
//  AddressData.m
//  Wordpress News App
//
//  Created by BoHuang on 6/11/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "AddressData.h"
#import "BaseModel.h"
@implementation AddressData

- (id) init
{
    self = [super init];
    if (self != nil)
    {
        _type = -1;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
    }
    return self;
}
-(void)setAddressData{
    
//    if (_country!=nil && ![_country isEqualToString:@""] && _city!=nil && ![_city isEqualToString:@""]) {
//        _address = [NSString stringWithFormat:@"%@,%@",_city,_country];
//    }
    if (_country!=nil && ![_country isEqualToString:@""] && [_city_hubos count] > 0 ) {
        NSString* city = _city_hubos[0];
        _address = [NSString stringWithFormat:@"%@,%@",city,_country];
    }
}
@end
