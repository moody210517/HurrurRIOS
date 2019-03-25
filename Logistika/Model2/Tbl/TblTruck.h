//
//  TblTruck.h
//  Logistika
//
//  Created by BoHuang on 6/7/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface TblTruck : BaseModel
@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* ddescription;
@property (nonatomic,copy) NSString* code;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
