//
//  IpResponse.h
//  ResignDate
//
//  Created by BoHuang on 5/10/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IpResponse : NSObject
@property (copy, nonatomic) NSString* as ;
@property (copy, nonatomic) NSString* city;
@property (copy, nonatomic) NSString* country;
@property (copy, nonatomic) NSString* isp;
@property (copy, nonatomic) NSString* lat;
@property (copy, nonatomic) NSString* lon;
@property (copy, nonatomic) NSString* org;
@property (copy, nonatomic) NSString* query;
@property (copy, nonatomic) NSString* region;
@property (copy, nonatomic) NSString* regionName;
@property (copy, nonatomic) NSString* status;
@property (copy, nonatomic) NSString* timezone;
@property (copy, nonatomic) NSString* zip;
@property (copy, nonatomic) NSString* countryCode;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
