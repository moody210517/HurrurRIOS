//
//  GooglePos.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface GooglePos : BaseModel

@property (nonatomic,copy) NSString* lat;
@property (nonatomic,copy) NSString* lng;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
