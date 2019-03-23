//
//  EftGoogleAddressComponent.h
//  EFT
//
//  Created by Twinklestar on 12/11/15.
//  Copyright © 2015 Twinklestar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EftGoogleAddressComponent : NSObject

@property (nonatomic,copy) NSString* long_name;
@property (nonatomic,copy) NSString* short_name;
@property (nonatomic,strong) NSArray* types;

-(instancetype)initWithDictionary:(NSDictionary*)dict;


@end
