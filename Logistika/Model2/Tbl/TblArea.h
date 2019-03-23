//
//  TblArea.h
//  Logistika
//
//  Created by BoHuang on 6/6/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface TblArea : BaseModel

@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* title;

@property (nonatomic,copy) NSString* action;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
