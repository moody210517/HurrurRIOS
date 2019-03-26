//
//  TblUser.m
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import "TblUser.h"
#import "BaseModel.h"
#import "CGlobal.h"
#import "TblAddress.h"

@implementation TblUser

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
        id obj = [dict objectForKey:@"address"];
        if (obj!=nil && obj!= [NSNull null]) {
            NSArray* array = obj;
            _address = [[NSMutableArray alloc] init];
            for (int i=0; i< [array count]; i++) {
                TblAddress *item = [[TblAddress alloc] initWithDictionary:[array objectAtIndex:i]];
                [_address addObject:item];
            }
        }
        
        
    }
    return self;
}
-(void)saveResponse:(NSInteger)segIndex Password:(NSString*)password{
    // save login result
    EnvVar* env = [CGlobal sharedId].env;
    TblUser*user = self;
    TblAddress* address = user.address[0];
    if (address!=nil) {
        env.address1 = address.address;
        env.address2 = address.address2;
        env.city = address.city;
        env.state = address.state;
        env.pincode = address.pincode;
        env.landmark = address.landmark;
        env.address_id = address.id;
    }
    if (segIndex == 0) {
        env.user_id = user.id;
        env.email = user.email;
        env.username = user.email;
        env.password = password;
        g_mode = c_PERSONAL;
        env.mode = c_PERSONAL;
    }else{
        env.corporate_user_id = user.id;
        env.cor_email = user.email;
        env.cor_password = password;
        g_mode = c_CORPERATION;
        env.mode = c_CORPERATION;
    }
    env.first_name = user.first_name;
    env.nickname = user.first_name;
    env.last_name = user.last_name;
    env.phone = user.phone;
    env.question = user.question;
    env.answer = user.answer;
    env.policy = user.policy;
    env.term = user.term;
    env.lastLogin = 1;
    env.business_type = user.business_type;
}

@end
