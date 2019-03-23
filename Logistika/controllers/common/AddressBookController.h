//
//  AddressBookController.h
//  Logistika
//
//  Created by Venu Talluri on 01/01/1941 Saka.
//  Copyright © 1941 BoHuang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressBookController : UIViewController


@property(nonatomic,strong) NSMutableArray* addresses;
@property (weak, nonatomic) IBOutlet UIView *viewRoot;

@end

NS_ASSUME_NONNULL_END
