//
//  PayUManager.h
//  Logistika
//
//  Created by user on 24/02/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <PlugNPlay/PlugNPlay.h>

@interface PayUManager : NSObject

+(void) proceedForPayment: (UIViewController *)onVC withAmount:(NSString *)amount email:(NSString *)email mobile:(NSString *)mobile firstName:(NSString *)firstName AndProductInfo:(NSString *)productInfo isForNetbanking:(BOOL)enableNetbanking withCompletionBlock:(PnPPaymentCompletionBlock)completionBlock;

@end
