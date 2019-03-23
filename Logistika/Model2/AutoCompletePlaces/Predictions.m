//
//  Predictions.m
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Predictions.h"
#import "MatchedSubstrings.h"
#import "Terms.h"


NSString *const kPredictionsReference = @"reference";
NSString *const kPredictionsId = @"id";
NSString *const kPredictionsTypes = @"types";
NSString *const kPredictionsMatchedSubstrings = @"matched_substrings";
NSString *const kPredictionsPlaceId = @"place_id";
NSString *const kPredictionsDescription = @"description";
NSString *const kPredictionsTerms = @"terms";


@interface Predictions ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Predictions

@synthesize reference = _reference;
@synthesize predictionsIdentifier = _predictionsIdentifier;
@synthesize types = _types;
@synthesize matchedSubstrings = _matchedSubstrings;
@synthesize placeId = _placeId;
@synthesize predictionsDescription = _predictionsDescription;
@synthesize terms = _terms;


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
            self.reference = [self objectOrNilForKey:kPredictionsReference fromDictionary:dict];
            self.predictionsIdentifier = [self objectOrNilForKey:kPredictionsId fromDictionary:dict];
            self.types = [self objectOrNilForKey:kPredictionsTypes fromDictionary:dict];
    NSObject *receivedMatchedSubstrings = [dict objectForKey:kPredictionsMatchedSubstrings];
    NSMutableArray *parsedMatchedSubstrings = [NSMutableArray array];
    if ([receivedMatchedSubstrings isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedMatchedSubstrings) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedMatchedSubstrings addObject:[MatchedSubstrings modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedMatchedSubstrings isKindOfClass:[NSDictionary class]]) {
       [parsedMatchedSubstrings addObject:[MatchedSubstrings modelObjectWithDictionary:(NSDictionary *)receivedMatchedSubstrings]];
    }

    self.matchedSubstrings = [NSArray arrayWithArray:parsedMatchedSubstrings];
            self.placeId = [self objectOrNilForKey:kPredictionsPlaceId fromDictionary:dict];
            self.predictionsDescription = [self objectOrNilForKey:kPredictionsDescription fromDictionary:dict];
    NSObject *receivedTerms = [dict objectForKey:kPredictionsTerms];
    NSMutableArray *parsedTerms = [NSMutableArray array];
    if ([receivedTerms isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTerms) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTerms addObject:[Terms modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTerms isKindOfClass:[NSDictionary class]]) {
       [parsedTerms addObject:[Terms modelObjectWithDictionary:(NSDictionary *)receivedTerms]];
    }

    self.terms = [NSArray arrayWithArray:parsedTerms];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.reference forKey:kPredictionsReference];
    [mutableDict setValue:self.predictionsIdentifier forKey:kPredictionsId];
    NSMutableArray *tempArrayForTypes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.types) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTypes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTypes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:kPredictionsTypes];
    NSMutableArray *tempArrayForMatchedSubstrings = [NSMutableArray array];
    for (NSObject *subArrayObject in self.matchedSubstrings) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForMatchedSubstrings addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForMatchedSubstrings addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForMatchedSubstrings] forKey:kPredictionsMatchedSubstrings];
    [mutableDict setValue:self.placeId forKey:kPredictionsPlaceId];
    [mutableDict setValue:self.predictionsDescription forKey:kPredictionsDescription];
    NSMutableArray *tempArrayForTerms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.terms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTerms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTerms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTerms] forKey:kPredictionsTerms];

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

    self.reference = [aDecoder decodeObjectForKey:kPredictionsReference];
    self.predictionsIdentifier = [aDecoder decodeObjectForKey:kPredictionsId];
    self.types = [aDecoder decodeObjectForKey:kPredictionsTypes];
    self.matchedSubstrings = [aDecoder decodeObjectForKey:kPredictionsMatchedSubstrings];
    self.placeId = [aDecoder decodeObjectForKey:kPredictionsPlaceId];
    self.predictionsDescription = [aDecoder decodeObjectForKey:kPredictionsDescription];
    self.terms = [aDecoder decodeObjectForKey:kPredictionsTerms];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_reference forKey:kPredictionsReference];
    [aCoder encodeObject:_predictionsIdentifier forKey:kPredictionsId];
    [aCoder encodeObject:_types forKey:kPredictionsTypes];
    [aCoder encodeObject:_matchedSubstrings forKey:kPredictionsMatchedSubstrings];
    [aCoder encodeObject:_placeId forKey:kPredictionsPlaceId];
    [aCoder encodeObject:_predictionsDescription forKey:kPredictionsDescription];
    [aCoder encodeObject:_terms forKey:kPredictionsTerms];
}

- (id)copyWithZone:(NSZone *)zone
{
    Predictions *copy = [[Predictions alloc] init];
    
    if (copy) {

        copy.reference = [self.reference copyWithZone:zone];
        copy.predictionsIdentifier = [self.predictionsIdentifier copyWithZone:zone];
        copy.types = [self.types copyWithZone:zone];
        copy.matchedSubstrings = [self.matchedSubstrings copyWithZone:zone];
        copy.placeId = [self.placeId copyWithZone:zone];
        copy.predictionsDescription = [self.predictionsDescription copyWithZone:zone];
        copy.terms = [self.terms copyWithZone:zone];
    }
    
    return copy;
}


@end
