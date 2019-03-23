//
//  ItemModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"
#import <UIKit/UIKit.h>

@interface ItemModel : BaseModel
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* image;
@property (nonatomic,copy) NSString* quantity;
@property (nonatomic,copy) NSString* weight;
@property (nonatomic,copy) NSString* dimension1;
@property (nonatomic,copy) NSString* dimension2;
@property (nonatomic,copy) NSString* dimension3;
@property (nonatomic,assign) int weight_value;

@property (nonatomic,strong) UIImage* image_data;

-(instancetype)initWithDictionary:(NSDictionary*) dict;
-(void)firstPackage;
-(NSString*)getDimetion;

@property (nonatomic,copy) NSString* mPackage;
@end
