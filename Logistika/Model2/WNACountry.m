//
//  WNACountry.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "WNACountry.h"
#import "BaseModel.h"

@implementation WNACountry

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
    }
    return self;
}
-(instancetype)initWithArray:(NSArray*) dict{
    self = [super init];
    if(self) {
        self.countryID = [dict objectAtIndex:0];
        self.countryName = [dict objectAtIndex:1];
        self.localName = [dict objectAtIndex:2];
        self.webCode = [dict objectAtIndex:3];
        self.region = [dict objectAtIndex:4];
        self.continent = [dict objectAtIndex:5];
        self.latitude = [dict objectAtIndex:6];
        self.longitude = [dict objectAtIndex:7];
        self.surfaceArea = [dict objectAtIndex:8];
        self.population = [dict objectAtIndex:9];
        
        
    }
    return self;
}
@end
