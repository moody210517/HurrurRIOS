//
//  CityModel.m
//  Logistika
//
//  Created by BoHuang on 9/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CityModel.h"
#import <UIKit/UIKit.h>

@implementation CityModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        if (dict!=nil) {
            NSDictionary*abcDict = @{@"id":@"id" ,
                                     @"name":@"name",
                                     @"lat":@"lat",
                                     @"lng":@"lng",
                                     @"geofence":@"geofence",
                                     @"image":@"image"};
            
            [BaseModel parseResponseABC:self Dict:dict ABC:abcDict];
        }
    }
    return self;
}
-(NSMutableArray*)getGeofences{
    NSMutableArray* latLngs = [[NSMutableArray alloc] init];
    NSArray* array = [self.geofence componentsSeparatedByString:@":"];
    for (int i=0; i< array.count; i++) {
        NSArray* item = [array[i] componentsSeparatedByString:@","];
        if (item.count == 2) {
            double x = [item[0] doubleValue];
            double y = [item[1] doubleValue];
            CGPoint pt = CGPointMake(x,y);
            [latLngs addObject:[NSValue valueWithCGPoint:pt]];
        }
    }
    return latLngs;
}
@end
