//
//  ViewScrollContainer.h
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewScrollContainer : UIScrollView
@property (weak, nonatomic) IBOutlet UIStackView *stackView;
@property (strong, nonatomic) NSMutableArray *views;

-(void)firstProcess;
-(void)addOneView:(UIView*)view;

@end
