//
//  OrderTrackModel.h
//  Logistika
//
//  Created by BoHuang on 6/21/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface OrderTrackModel : BaseModel

@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* order_id;
@property (nonatomic,copy) NSString* pickup;
@property (nonatomic,copy) NSString* location;
@property (nonatomic,copy) NSString* employer_id;
@property (nonatomic,copy) NSString* dt;
@property (nonatomic,copy) NSString* rsv;
@property (nonatomic,copy) NSString* first_name;
@property (nonatomic,copy) NSString* last_name;
@property (nonatomic,copy) NSString* email;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* picture;
@end
