//
//  OrderHisModel.h
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
#import <UIKit/UIKit.h>

@interface OrderHisModel : BaseModel
@property (nonatomic,copy) NSString* orderId;
@property (nonatomic,copy) NSString* trackId;
@property (nonatomic,copy) NSString* state;
@property (nonatomic,copy) NSString* is_quote_request;
@property (nonatomic,copy) NSString* payment;
@property (nonatomic,copy) NSString* accepted_by;
@property (nonatomic,copy) NSString* price;
@property (nonatomic,copy) NSString* transaction_id;

@property (nonatomic,strong) AddressModel* addressModel;
@property (nonatomic,strong) ServiceModel* serviceModel;
@property (nonatomic,strong) DateModel* dateModel;
@property (nonatomic,strong) OrderModel* orderModel;

@property (nonatomic,assign) BOOL viewContentHidden;
@property (nonatomic,assign) BOOL cellSizeCalculated;
@property (nonatomic,assign) CGSize cellSize;
@property (nonatomic,assign) CGSize cellSize_small;
@end
