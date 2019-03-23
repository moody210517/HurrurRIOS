//
//  AddressHisModel.h
//  Logistika
//
//  Created by Venu Talluri on 02/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressHisModel : BaseModel



@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSString* area;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* state;
@property (nonatomic, copy) NSString* pincode;
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* landmark;
@property (nonatomic, copy) NSString* instruction;
@property (nonatomic, assign) double lat = 0;
@property (nonatomic, assign)  double lng = 0;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
