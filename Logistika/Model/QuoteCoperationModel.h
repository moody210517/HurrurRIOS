//
//  QuoteCoperationModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"
#import "ServiceModel.h"
#import "AddressModel.h"
#import "DateModel.h"

@interface QuoteCoperationModel : BaseModel
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* ddescription; //hgcneed
@property (nonatomic,copy) NSString* loadtype;

@property (nonatomic,copy) NSString* orderId;
@property (nonatomic,copy) NSString* trackId;
@property (nonatomic,copy) NSString* state;
@property (nonatomic,assign) BOOL selection;
@property (nonatomic,assign) BOOL service_choose;
@property (nonatomic,copy) NSString* quote_id;


@property (nonatomic,strong) ServiceModel* expeditedService ;
@property (nonatomic,strong) ServiceModel* expressService ;
@property (nonatomic,strong) ServiceModel* economyService ;

@property (nonatomic,strong) AddressModel* addressModel ;
@property (nonatomic,strong) ServiceModel* serviceModel ;
@property (nonatomic,strong) DateModel* dateModel ;

@end
