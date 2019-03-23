//
//  OrderRescheduleModel.h
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

@interface OrderRescheduleModel : BaseModel
@property (nonatomic,copy) NSString* orderId;
@property (nonatomic,copy) NSString* trackId;
@property (nonatomic,copy) NSString* payment;

@property (nonatomic,copy) NSString* newdate;
@property (nonatomic,copy) NSString* newtime;
@property (nonatomic,strong) AddressModel* addressModel;
@property (nonatomic,strong) ServiceModel* serviceModel;
@property (nonatomic,strong) DateModel* dateModel;
@property (nonatomic,strong) OrderModel* orderModel;

@property (nonatomic,assign) BOOL viewContentHidden;
@property (nonatomic,assign) BOOL cellSizeCalculated;
@property (nonatomic,assign) CGSize cellSize;
@property (nonatomic,assign) CGSize cellSize_small;

//@property (nonatomic,assign) BOOL isShowing;
//@property (nonatomic,assign) CGFloat cellHeight;
//@property (nonatomic,assign) CGFloat entireHeight;
//@property (nonatomic,assign) CGFloat contentHeight;
//@property (nonatomic,assign) CGFloat tableHeight;
//-(CGFloat)getHeight;
@end
