//
//  Predictions.h
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Predictions : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSString *predictionsIdentifier;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSArray *matchedSubstrings;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *predictionsDescription;
@property (nonatomic, strong) NSArray *terms;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
