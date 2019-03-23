//
//  ServiceModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceModel : BaseModel
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* price;
@property (nonatomic,copy) NSString* time_in ;
@end
