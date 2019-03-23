//
//  CityModel.h
//  Logistika
//
//  Created by BoHuang on 9/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* lat;
@property (nonatomic,copy) NSString* lng;
@property (nonatomic,copy) NSString* geofence;
@property (nonatomic,copy) NSString* image;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
-(NSMutableArray*)getGeofences;

@end
