//
//  Terms.m
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Terms.h"


NSString *const kTermsValue = @"value";
NSString *const kTermsOffset = @"offset";


@interface Terms ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Terms

@synthesize value = _value;
@synthesize offset = _offset;


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
            self.value = [self objectOrNilForKey:kTermsValue fromDictionary:dict];
            self.offset = [[self objectOrNilForKey:kTermsOffset fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.value forKey:kTermsValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offset] forKey:kTermsOffset];

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

    self.value = [aDecoder decodeObjectForKey:kTermsValue];
    self.offset = [aDecoder decodeDoubleForKey:kTermsOffset];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_value forKey:kTermsValue];
    [aCoder encodeDouble:_offset forKey:kTermsOffset];
}

- (id)copyWithZone:(NSZone *)zone
{
    Terms *copy = [[Terms alloc] init];
    
    if (copy) {

        copy.value = [self.value copyWithZone:zone];
        copy.offset = self.offset;
    }
    
    return copy;
}


@end
