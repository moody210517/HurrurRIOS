//
//  MatchedSubstrings.h
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MatchedSubstrings : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double offset;
@property (nonatomic, assign) double length;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
