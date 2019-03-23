//
//  ComboDropTableViewCell.h
//  Wordpress News App
//
//  Created by BoHuang on 6/15/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComboDropTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIView* root;
@property (nonatomic,weak) IBOutlet UILabel* label;

-(void)setData:(NSString*)string Selected:(BOOL)sel;
@end
