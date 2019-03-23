//
//  GoogleBound.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"
#import "GooglePos.h"

@interface GoogleBound : BaseModel

@property (strong, nonatomic) GooglePos* northeast;
@property (strong, nonatomic) GooglePos* southwest;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
