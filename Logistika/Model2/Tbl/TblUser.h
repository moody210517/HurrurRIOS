//
//  TblUser.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TblUser : NSObject

@property (nonatomic,copy) NSString* id;
@property (nonatomic,copy) NSString* first_name;
@property (nonatomic,copy) NSString* last_name;
@property (nonatomic,copy) NSString* email;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* question;
@property (nonatomic,copy) NSString* answer;
@property (nonatomic,copy) NSString* term;
@property (nonatomic,copy) NSString* policy;
@property (nonatomic,copy) NSMutableArray* address;
xxx
@property (nonatomic,copy) NSString* action;

@property (nonatomic,assign) long temp;


-(instancetype)initWithDictionary:(NSDictionary*) dict;
-(void)saveResponse:(NSInteger)segIndex Password:(NSString*)password;
@end
