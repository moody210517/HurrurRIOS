//
//  GooglePlaceResult.h
//  travpholer
//
//  Created by Twinklestar on 9/1/16.
//  Copyright © 2016 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GooglePlace.h"

@interface GooglePlaceResult : NSObject

@property (nonatomic,strong) NSMutableArray* results;
@property (nonatomic,strong) GooglePlace* result;
@property (nonatomic,copy) NSString* status;

-(instancetype)initWithDictionary:(NSDictionary*) dict;

@end
