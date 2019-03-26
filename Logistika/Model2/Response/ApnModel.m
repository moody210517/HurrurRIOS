//
//  ApnModel.m
//  SchoolApp
//
//  Created by Twinklestar on 4/25/16.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ApnModel.h"
#import "BaseModel.h"

@implementation ApnModel
-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
//        NSArray* properts = [[NSArray alloc] initWithObjects:@"type",@"time",@"sid",@"cid",@"actype",@"from1",@"year",@"month",@"day",nil];
//        
//        for (int i=0; i<[properts count]; i++) {
//            NSString*key = [properts objectAtIndex:i];
//            
//            if ([dict objectForKey:key] != nil) {
//                [self setValue:[dict objectForKey:key] forKey:key];
//            }
//        }

//        [BaseUserModel genericCopyItems:dict To:self ClassType:[ApnModel class]];
        
    }
    return self;
}
@end
