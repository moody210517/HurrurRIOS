//
//  GooglePlace.h
//  ResignDate
//
//  Created by BoHuang on 5/10/16.
//  Copyright © 2016 Twinklestar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleGeometry.h"

@interface GooglePlace : NSObject
@property (nonatomic,copy) NSString*reference;
@property (nonatomic,copy) NSString*place_id;
@property (nonatomic,copy) NSString*formatted_address;
@property (nonatomic,copy) NSString*formatted_phone_number;
@property (nonatomic,copy) NSString*lat;
@property (nonatomic,copy) NSString*lon;
@property (nonatomic,copy) NSString*icon;
@property (nonatomic,copy) NSString*name;
@property (nonatomic,strong) NSMutableArray* types;
@property (nonatomic,copy) NSString*xid;
@property (nonatomic,strong) NSMutableArray*address_components;
@property (nonatomic,strong) GoogleGeometry* geometry;

@property (nonatomic,copy) NSString* googlePicture;
@property (nonatomic,assign) double distance;


-(instancetype)initWithDictionary:(NSDictionary*) dict;

-(NSString*)getAddressForTextQuery;



@end
