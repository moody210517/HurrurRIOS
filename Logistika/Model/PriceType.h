//
//  PriceType.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface PriceType : BaseModel
@property (nonatomic,copy) NSString* expedited_name ;
@property (nonatomic,copy) NSString* expeditied_price;
@property (nonatomic,copy) NSString* expedited_duration ;

@property (nonatomic,copy) NSString* express_name ;
@property (nonatomic,copy) NSString* express_price;
@property (nonatomic,copy) NSString* express_duration ;

@property (nonatomic,copy) NSString* economy_name ;
@property (nonatomic,copy) NSString*  economy_price;
@property (nonatomic,copy) NSString* economy_duraiton ;
@end
