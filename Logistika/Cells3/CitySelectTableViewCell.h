//
//  CitySelectTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 9/23/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface CitySelectTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbltext1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
-(void)setData:(NSMutableDictionary*)data;
@property (weak, nonatomic) IBOutlet UIView *viewMask;
@end
