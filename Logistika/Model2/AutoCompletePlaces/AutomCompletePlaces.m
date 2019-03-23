//
//  AutomCompletePlaces.m
//
//  Created by Krunal  on 14/04/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AutomCompletePlaces.h"
#import "Predictions.h"


NSString *const kAutomCompletePlacesStatus = @"status";
NSString *const kAutomCompletePlacesPredictions = @"predictions";


@interface AutomCompletePlaces ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AutomCompletePlaces

@synthesize status = _status;
@synthesize predictions = _predictions;


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
            self.status = [self objectOrNilForKey:kAutomCompletePlacesStatus fromDictionary:dict];
    NSObject *receivedPredictions = [dict objectForKey:kAutomCompletePlacesPredictions];
    NSMutableArray *parsedPredictions = [NSMutableArray array];
    if ([receivedPredictions isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPredictions) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPredictions addObject:[Predictions modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPredictions isKindOfClass:[NSDictionary class]]) {
       [parsedPredictions addObject:[Predictions modelObjectWithDictionary:(NSDictionary *)receivedPredictions]];
    }

    self.predictions = [NSArray arrayWithArray:parsedPredictions];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kAutomCompletePlacesStatus];
    NSMutableArray *tempArrayForPredictions = [NSMutableArray array];
    for (NSObject *subArrayObject in self.predictions) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPredictions addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPredictions addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPredictions] forKey:kAutomCompletePlacesPredictions];

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

    self.status = [aDecoder decodeObjectForKey:kAutomCompletePlacesStatus];
    self.predictions = [aDecoder decodeObjectForKey:kAutomCompletePlacesPredictions];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kAutomCompletePlacesStatus];
    [aCoder encodeObject:_predictions forKey:kAutomCompletePlacesPredictions];
}

- (id)copyWithZone:(NSZone *)zone
{
    AutomCompletePlaces *copy = [[AutomCompletePlaces alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.predictions = [self.predictions copyWithZone:zone];
    }
    
    return copy;
}


@end
