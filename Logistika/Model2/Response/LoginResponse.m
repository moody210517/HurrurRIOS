//
//  LoginResponse.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "LoginResponse.h"
#import "BaseModel.h"
#import "TblArea.h"
#import "TblTruck.h"
#import "CityModel.h"
#import "Step.h"
#import "CGlobal.h"

@implementation LoginResponse

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"row"];
        if (obj!=nil && obj!= [NSNull null]) {
            self.row = [[TblUser alloc] initWithDictionary:obj];
        }
        
        obj = [dict objectForKey:@"area"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.area = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                TblArea* area = [[TblArea alloc] initWithDictionary:list[i]];
                [self.area addObject:area];
            }
            
            if (self.area.count>0) {
                [self.area sortUsingComparator:^NSComparisonResult(TblArea* obj1, TblArea* obj2) {
                    NSString* first = obj1.title;
                    NSString* second = obj2.title;
                    return [first compare:second];
                }];
            }
        }
        
        obj = [dict objectForKey:@"city"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.city = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                TblArea* area = [[TblArea alloc] initWithDictionary:list[i]];
                [self.city addObject:area];
            }
            
            if (self.city.count>0) {
                [self.city sortUsingComparator:^NSComparisonResult(TblArea* obj1, TblArea* obj2) {
                    NSString* first = obj1.title;
                    NSString* second = obj2.title;
                    return [first compare:second];
                }];
            }
        }
        
        obj = [dict objectForKey:@"items"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.items = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                TblArea* area = [[TblArea alloc] initWithDictionary:list[i]];
                [self.items addObject:area];
            }
        }
        
        obj = [dict objectForKey:@"pincode"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.pincode = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                TblArea* area = [[TblArea alloc] initWithDictionary:list[i]];
                [self.pincode addObject:area];
            }
            if (self.pincode.count>0) {
                [self.pincode sortUsingComparator:^NSComparisonResult(TblArea* obj1, TblArea* obj2) {
                    NSString* first = obj1.title;
                    NSString* second = obj2.title;
                    return [first compare:second];
                }];
            }
        }
        obj = [dict objectForKey:@"truck"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.truck = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                TblTruck* area = [[TblTruck alloc] initWithDictionary:list[i]];
                [self.truck addObject:area];
            }
        }
        
        obj = [dict objectForKey:@"cities"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* list = (NSArray*)obj;
            self.cities = [[NSMutableArray alloc] init];
            for (int i=0; i<list.count; i++) {
                CityModel* area = [[CityModel alloc] initWithDictionary:list[i]];
                [self.cities addObject:area];
            }
        }
    }
    return self;
}



-(instancetype)initWithDictionaryForRoute:(NSDictionary*) dict{
    self = [super init];
    if(self){
        [BaseModel parseResponse:self Dict:dict];
        Step*stepBean = [[Step alloc] init];
        self.route = [[Route alloc] initWithDictionary:nil];
        id obj = [dict objectForKey:@"routes"];
        if (obj!=nil && obj!= [NSNull null] && [obj isKindOfClass:[NSArray class]]) {
            NSArray* jArray = (NSArray*)obj;
            for (int i=0; i<jArray.count; i++) {
                id innerJObject = jArray[i];
                if (innerJObject[@"legs"]!=nil) {
                    NSArray* innerJarry = innerJObject[@"legs"];
                    for (int j=0; j<innerJarry.count; j++) {
                        id jObjectLegs = innerJarry[j];
                        self.route.distanceText = jObjectLegs[@"distance"][@"text"];
                        self.route.distanceValue = [jObjectLegs[@"distance"][@"value"] intValue];
                        self.route.durationText = jObjectLegs[@"duration"][@"text"];
                        self.route.durationValue = [jObjectLegs[@"duration"][@"text"] intValue];
                        self.route.startAddress = jObjectLegs[@"start_address"];
                        self.route.endAddress = jObjectLegs[@"end_address"];
                        self.route.startLat = [jObjectLegs[@"start_location"][@"lat"] doubleValue];
                        self.route.startLon = [jObjectLegs[@"start_location"][@"lng"] doubleValue];
                        if (jObjectLegs[@"steps"]!=nil) {
                            NSArray* jstepArray = jObjectLegs[@"steps"];
                            for (int k=0; k<jstepArray.count; k++) {
                                stepBean = [[Step alloc] init];
                                if (jstepArray[k]!=nil) {
                                    id jStepObject = jstepArray[k];
                                    stepBean.html_instructions = jStepObject[@"html_instructions"];
                                    stepBean.strPoint = jStepObject[@"polyline"][@"points"];
                                    stepBean.startLat = [jStepObject[@"start_location"][@"lat"] doubleValue];
                                    stepBean.startLon = [jStepObject[@"start_location"][@"lng"] doubleValue];
                                    stepBean.endLat = [jStepObject[@"end_location"][@"lat"] doubleValue];
                                    stepBean.endLon = [jStepObject[@"end_location"][@"lng"] doubleValue];
                                  
                                    stepBean.listPoints = [CGlobal polylineWithEncodedString:stepBean.strPoint];
                                    
                                }
                                [self.route.listStep addObject:stepBean];
                            }
                        }
                    }
                }
            }
        }
    }
    return self;
}

@end
