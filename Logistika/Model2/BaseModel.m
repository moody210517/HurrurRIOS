//
//  BaseModel.m
//  Hospice
//
//  Created by Twinklestar on 1/26/16.
//  Copyright © 2016 Hospice. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

-(instancetype)initWithDictionary:(NSDictionary*) dict{
    self = [super init];
    if(self){
        
        [BaseModel parseResponse:self Dict:dict];
        
    }
    return self;
}

+(NSMutableDictionary*)getQuestionDict:(id)targetClass{
    if ([targetClass isKindOfClass:[NSMutableDictionary class]]) {
        return targetClass;
    }
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    }
    
    return questionDict;
}


+(void)parseResponse:(id)targetClass Dict:(NSDictionary*)dict{
    if (dict== nil) {
        return;
    }
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        id value = [dict objectForKey:name];
        
        if (value!=nil && [value isKindOfClass:[NSString class]] && value != [NSNull null] ) {
            [targetClass setValue:value forKey:name];
        }else if(value!=nil && [value isKindOfClass:[NSNumber class]] && value != [NSNull null] ) {
            
            [targetClass setValue:[value stringValue] forKey:name];
        }else if(value != nil && [value isKindOfClass:[NSDecimalNumber class]] && value != [NSNull null]){
            [targetClass setValue:[value stringValue] forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
}
+(void)parseResponseABC:(id)targetClass Dict:(NSDictionary*)dict ABC:(NSDictionary*)abcDict{
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        if (abcDict[name] != nil) {
            NSString* nameABC = abcDict[name];
            id value = dict[nameABC];
            
            if (value!=nil && [value isKindOfClass:[NSString class]] && value != [NSNull null] ) {
                [targetClass setValue:value forKey:name];
            }else if (value!=nil && [value isKindOfClass:[NSNumber class]] && value != [NSNull null] ) {
                NSNumber* val = value;
                [targetClass setValue:[val stringValue]  forKey:name];
            }
        }
    }
    free(propertyArray);
}

+(NSData*)buildJsonData:(id)targetClass{
    NSData* jsonData = nil;
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *questionDict;
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [objects addObject:value];
            [keys addObject:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    if ([objects count] > 0) {
        questionDict = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
        
        NSError * error = nil;
        jsonData = [NSJSONSerialization dataWithJSONObject:questionDict options:NSJSONWritingPrettyPrinted error:&error];
        
        
        
    }
    
    return jsonData;
}
+(id)getDuplicate:(id)targetClass{
    
    id ret = [[targetClass class] alloc];
    
    unsigned int numberOfProperties = 0;
    objc_property_t *propertyArray = class_copyPropertyList([targetClass class], &numberOfProperties);
    
    for (NSUInteger i = 0; i < numberOfProperties; i++)
    {
        objc_property_t property = propertyArray[i];
        NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
        //NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
        NSString* value = [targetClass valueForKey:name];
        if (value!=nil && [value isKindOfClass:[NSString class]]) {
            [ret setValue:value forKey:name];
        }
        //NSLog(@"Property %@ attributes: %@", name, name);
    }
    free(propertyArray);
    
    return ret;
}
@end





