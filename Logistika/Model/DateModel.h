//
//  DateModel.h
//  Logistika
//
//  Created by BoHuang on 4/19/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "BaseModel.h"

@interface DateModel : BaseModel
@property (nonatomic,copy) NSString* date;
@property (nonatomic,copy) NSString* time;
@property (nonatomic,assign) int index;
@end
