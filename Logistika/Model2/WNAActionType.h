//
//  WNAActionType.h
//  Wordpress News App
//
//  Created by BoHuang on 5/25/16.
//  Copyright © 2016 Nikolay Yanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WNAActionType : NSObject

@property (nonatomic,strong) NSIndexPath*indexPath;
@property (nonatomic,strong) NSMutableDictionary *dicData1;

@property (nonatomic,assign) int index;
@property (nonatomic,assign) int celltype;
@property (nonatomic,assign) int actiontype;
@property (nonatomic,weak) UIView* sourceView;
@property (nonatomic,weak) UIImageView* imageview;
@end
