//
//  MyBaseView.h
//  Burped
//
//  Created by BoHuang on 6/12/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"
@interface MyBaseView : UIView

@property (nonatomic,strong) UIViewController*vc;
@property (nonatomic,strong) id<ViewDialogDelegate> aDelegate;
@property (nonatomic,strong) NSDictionary*inputData;
//@property (nonatomic,strong) id model;

@property (assign,nonatomic) CGFloat cellHeight;
-(void)setData:(NSDictionary*)data;
@end
