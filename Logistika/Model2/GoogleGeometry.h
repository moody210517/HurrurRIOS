//
//  GoogleGeometry.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"
#import "GoogleBound.h"

@interface GoogleGeometry : BaseModel
@property (strong, nonatomic) GoogleBound* bounds;
@property (strong, nonatomic) GooglePos* location;
@property (copy, nonatomic) NSString* location_type;
@property (strong, nonatomic) GoogleBound* viewport;


-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
