//
//  Route.h
//  Logistika
//
//  Created by BoHuang on 8/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface Route : BaseModel

@property (nonatomic,copy) NSString* startAddress;
@property (nonatomic,copy) NSString* endAddress;
@property (nonatomic,assign) double startLat;
@property (nonatomic,assign) double startLon;
@property (nonatomic,assign) double endLat;
@property (nonatomic,assign) double endLon;
@property (nonatomic,copy) NSString* distanceText;
@property (nonatomic,assign) int distanceValue;
@property (nonatomic,copy) NSString* durationText;
@property (nonatomic,assign) int durationValue;
@property (nonatomic,strong) NSMutableArray* listStep;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
