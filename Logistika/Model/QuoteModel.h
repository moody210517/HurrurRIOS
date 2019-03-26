//
//  QuoteModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"
#import "AddressModel.h"
#import "ServiceModel.h"
#import "DateModel.h"
#import "OrderModel.h"


@interface QuoteModel : BaseModel
@property (nonatomic,copy) NSString* orderId;
@property (nonatomic,copy) NSString* trackId;
@property (nonatomic,copy) NSString* weight;
@property (nonatomic,copy) NSString* quote_id;
@property (nonatomic,copy) NSString* payment;
@property (nonatomic,assign) BOOL selection;
@property (nonatomic,assign) BOOL service_choose;


@property (nonatomic,assign) int option;
@property (nonatomic,strong) AddressModel* addressModel ;
@property (nonatomic,strong) ServiceModel* serviceModel ;
@property (nonatomic,strong) DateModel* dateModel ;
@property (nonatomic,strong) OrderModel* orderModel ;
@end
