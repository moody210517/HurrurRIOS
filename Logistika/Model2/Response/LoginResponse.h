//
//  LoginResponse.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TblUser.h"
#import "Route.h"

@interface LoginResponse : NSObject

@property (strong, nonatomic) TblUser* row ;


@property (strong, nonatomic) NSMutableArray* area ;
@property (strong, nonatomic) NSMutableArray* city ;
@property (strong, nonatomic) NSMutableArray* items ;
@property (strong, nonatomic) NSMutableArray* pincode ;
@property (strong, nonatomic) NSMutableArray* truck ;
@property (strong, nonatomic) NSMutableArray* cities ;

@property (copy, nonatomic) NSString* likes_left ;
@property (copy, nonatomic) NSString* upload_photo ;
@property (copy, nonatomic) NSString* liked_pic_all ;
@property (copy, nonatomic) NSString* upload_china ;
@property (copy, nonatomic) NSString* expert_eastern_asia ;
@property (copy, nonatomic) NSString* conqueredcount ;
@property (copy, nonatomic) NSString* likes_recv ;
@property (copy, nonatomic) NSString* likedplaces ;
@property (copy, nonatomic) NSString* shareclicks ;

@property (copy, nonatomic) NSString* action ;


@property (strong, nonatomic) Route* route ;
-(instancetype)initWithDictionaryForRoute:(NSDictionary*) dict;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
