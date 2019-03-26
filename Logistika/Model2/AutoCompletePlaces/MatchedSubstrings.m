//
//  MatchedSubstrings.m
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "MatchedSubstrings.h"


NSString *const kMatchedSubstringsOffset = @"offset";
NSString *const kMatchedSubstringsLength = @"length";


@interface MatchedSubstrings ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MatchedSubstrings

@synthesize offset = _offset;
@synthesize length = _length;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.offset = [[self objectOrNilForKey:kMatchedSubstringsOffset fromDictionary:dict] doubleValue];
            self.length = [[self objectOrNilForKey:kMatchedSubstringsLength fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offset] forKey:kMatchedSubstringsOffset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.length] forKey:kMatchedSubstringsLength];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.offset = [aDecoder decodeDoubleForKey:kMatchedSubstringsOffset];
    self.length = [aDecoder decodeDoubleForKey:kMatchedSubstringsLength];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_offset forKey:kMatchedSubstringsOffset];
    [aCoder encodeDouble:_length forKey:kMatchedSubstringsLength];
}

- (id)copyWithZone:(NSZone *)zone
{
    MatchedSubstrings *copy = [[MatchedSubstrings alloc] init];
    
    if (copy) {

        copy.offset = self.offset;
        copy.length = self.length;
    }
    
    return copy;
}


@end
