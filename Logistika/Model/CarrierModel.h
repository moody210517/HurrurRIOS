//
//  CarrierModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface CarrierModel : BaseModel
@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* order_id;
@property (nonatomic,copy) NSString* freight;
@property (nonatomic,copy) NSString* load_type;
@property (nonatomic,copy) NSString* consignment;
@property (nonatomic,copy) NSString* date;
@property (nonatomic,copy) NSString* time;
@property (nonatomic,copy) NSString* vehicle;
@property (nonatomic,copy) NSString* driver_id;
@property (nonatomic,copy) NSString* driver_name;
@property (nonatomic,copy) NSString* signature;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
