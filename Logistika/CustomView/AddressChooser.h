//
//  AddressChooser.h
//  Logistika
//
//  Created by kangta on 3/24/19.
//  Copyright © 2019 BoHuang. All rights reserved.
//

#import "ColoredView.h"
#import "MyPopupDialog.h"
NS_ASSUME_NONNULL_BEGIN


@interface AddressChooser : ColoredView

@property (nonatomic, copy) NSString* type;
@property (nonatomic, strong) UIViewController*vc;
//@property (nonatomic,strong) id<ViewDialogDelegate> aDelegate;
@property (strong, nonatomic)   MyPopupDialog * pDialog;
-(void)firstProcess:(NSDictionary*)data;

@end

NS_ASSUME_NONNULL_END
