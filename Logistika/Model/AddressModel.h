//
//  AddressModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic,copy) NSString* sourceName;
@property (nonatomic,copy) NSString* sourceAddress;
@property (nonatomic,copy) NSString* sourceCity;
@property (nonatomic,copy) NSString* sourceState;
@property (nonatomic,copy) NSString* sourcePinCode;
@property (nonatomic,copy) NSString* sourcePhonoe;
@property (nonatomic,copy) NSString* sourceLandMark;
@property (nonatomic,copy) NSString* sourceInstruction;
@property (nonatomic,copy) NSString* sourceArea;

@property (nonatomic,copy) NSString* desAddress;
@property (nonatomic,copy) NSString* desCity;
@property (nonatomic,copy) NSString* desState;
@property (nonatomic,copy) NSString* desPinCode;
@property (nonatomic,copy) NSString* desPhone;
@property (nonatomic,copy) NSString* desLandMark;
@property (nonatomic,copy) NSString* desInstruction;
@property (nonatomic,copy) NSString* desArea;
@property (nonatomic,copy) NSString* desName;

@property (nonatomic,assign) double sourceLat;
@property (nonatomic,assign) double  sourceLng;

@property (nonatomic,assign) double  desLat;
@property (nonatomic,assign) double  desLng;

@property (nonatomic,copy) NSString* duration ;
@property (nonatomic,copy) NSString* distance ;
@property (nonatomic,copy) NSString* distance_text;

@property (nonatomic,copy) NSString* action;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
