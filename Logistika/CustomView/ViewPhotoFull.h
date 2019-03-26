//
//  ViewPhotoFull.h
//  Logistika
//
//  Created by BoHuang on 6/7/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPopupDialog.h"

@interface ViewPhotoFull : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgContent;


@property (nonatomic,strong) id<ViewDialogDelegate> aDelegate;
-(void)firstProcess:(NSDictionary*)data;
@end
