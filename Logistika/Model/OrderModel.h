//
//  OrderModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel
@property (nonatomic,assign) int product_type;
@property(nonatomic,strong) NSMutableArray* itemModels;
@end
