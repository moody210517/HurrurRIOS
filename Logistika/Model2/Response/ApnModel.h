//
//  ApnModel.h
//  SchoolApp
//
//  Created by Twinklestar on 4/25/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApnModel : NSObject


@property(copy,nonatomic) NSString* type;
@property(copy,nonatomic) NSString* time;
@property(copy,nonatomic) NSString* sid;
@property(copy,nonatomic) NSString* actype;
@property(copy,nonatomic) NSString* cid;
@property(copy,nonatomic) NSString* from1;
@property(copy,nonatomic) NSString* year;
@property(copy,nonatomic) NSString* month;
@property(copy,nonatomic) NSString* day;
@property(copy,nonatomic) NSString* sids;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
