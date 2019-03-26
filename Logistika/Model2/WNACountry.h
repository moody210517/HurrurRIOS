//
//  WNACountry.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WNACountry : NSObject

@property (nonatomic,copy) NSString* countryID;
@property (nonatomic,copy) NSString* countryName;
@property (nonatomic,copy) NSString* localName;
@property (nonatomic,copy) NSString* webCode;
@property (nonatomic,copy) NSString* region;
@property (nonatomic,copy) NSString* continent;
@property (nonatomic,copy) NSString* latitude;
@property (nonatomic,copy) NSString* longitude;
@property (nonatomic,copy) NSString* surfaceArea;
@property (nonatomic,copy) NSString* population;
@property (nonatomic,copy) NSString* photocount;
@property (nonatomic,copy) NSString* tp_picpath;
@property (nonatomic,copy) NSString* tp_thumb;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
-(instancetype)initWithArray:(NSArray*) data;

@property (nonatomic,strong) UIImage* map_bitmap;
@end
