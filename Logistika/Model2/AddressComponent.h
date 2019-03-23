//
//  AddressComponent.h
//  ResignDate
//
//  Created by BoHuang on 5/8/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressComponent : NSObject

@property (nonatomic,copy) NSString* long_name;
@property (nonatomic,copy) NSString* short_name;
@property (nonatomic,strong) NSMutableArray* types;

@end
