//
//  RescheduleTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 4/10/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RescheduleItemView.h"
#import "BaseTableViewCell.h"

@interface RescheduleTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet RescheduleItemView *rescheduleItemView;
-(void)setData:(NSMutableDictionary *)data Mode:(int)mode;

@end
