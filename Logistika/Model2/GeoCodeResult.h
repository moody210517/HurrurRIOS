//
//  GeoCodeResult.h
//  Wordpress News App
//
//  Created by BoHuang on 6/11/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeoCodeResult : NSObject

@property (nonatomic,strong) NSMutableArray* results;
@property (nonatomic,copy) NSString* status;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
@end
