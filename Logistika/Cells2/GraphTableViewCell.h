//
//  GraphTableViewCell.h
//  intuitive
//
//  Created by BoHuang on 4/17/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCorrect;
@property (weak, nonatomic) IBOutlet UILabel *lblInvalid;
@property (weak, nonatomic) IBOutlet UILabel *lblIncorrect;

@end
