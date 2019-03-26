//
//  AreaTableViewCell.h
//  Logistika
//
//  Created by BoHuang on 6/7/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel* lblContent;

-(void)setDataForArea:(NSDictionary*)data;
@end
