//
//  CorporateModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface CorporateModel : BaseModel
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* details;
@property (nonatomic,copy) NSString* truck;
@end
