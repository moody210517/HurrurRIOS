//
//  Step.h
//  Logistika
//
//  Created by BoHuang on 8/2/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface Step : BaseModel

@property (nonatomic,assign) double startLat;
@property (nonatomic,assign) double startLon;
@property (nonatomic,assign) double endLat;
@property (nonatomic,assign) double endLon;
@property (nonatomic,copy) NSString* html_instructions;
@property (nonatomic,copy) NSString* strPoint;
@property (nonatomic,strong) NSMutableArray* listPoints;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
