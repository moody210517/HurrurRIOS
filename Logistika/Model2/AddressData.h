//
//  AddressData.h
//  Wordpress News App
//
//  Created by BoHuang on 6/11/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GMSMarker.h>

@interface AddressData : NSObject

@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* country;
@property (nonatomic,assign ) CLLocationCoordinate2D pos;

@property (nonatomic,copy) NSString* city_hubo1;
@property (nonatomic,copy) NSString* city_hubo2;

@property (nonatomic,strong) NSMutableArray* city_hubos;

@property (nonatomic,assign) int type;

@property (nonatomic,copy) NSString* placeId;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
-(void)setAddressData;
@end
