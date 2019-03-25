//
//  TblAddress.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface TblAddress : BaseModel
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* address2;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* state;
@property (nonatomic,copy) NSString* pincode;
@property (nonatomic,copy) NSString* landmark;
@property (nonatomic,copy) NSString* id;

@property (nonatomic,copy) NSString* action;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
