//
//  PayUManager.m
//  Logistika
//
//  Created by user on 24/02/18.
//  Copyright © 2018 BoHuang. All rights reserved.
//

#import "PayUManager.h"
#import <UIKit/UIKit.h>
#import "CGlobal.h"

@implementation PayUManager

/// Live

NSString *merchantID = @"6101336";
NSString *merchantKey = @"iBzb2IZp";
NSString *salt = @"7iMVtfFpIM";

+(void) proceedForPayment: (UIViewController *)onVC withAmount:(NSString *)amount email:(NSString *)email mobile:(NSString *)mobile firstName:(NSString *)firstName AndProductInfo:(NSString *)productInfo isForNetbanking:(BOOL)enableNetbanking withCompletionBlock:(PnPPaymentCompletionBlock)completionBlock {
    
    /// PayU Parameter Instance
    PUMTxnParam *txnParam = [[PUMTxnParam alloc] init];
    
    
    txnParam.email = email;
    
    txnParam.firstname = firstName;
    txnParam.phone = mobile;
    
//    amount = @"2.00";
    txnParam.amount = amount;
    txnParam.productInfo = productInfo;
    
    txnParam.environment = PUMEnvironmentProduction;
//    txnParam.environment = PUMEnvironmentTest;
    
    txnParam.key = merchantKey;
    txnParam.merchantid = merchantID;
    txnParam.txnID = [self randomStringWithLength:30];
    txnParam.surl = @"https://www.payumoney.com/mobileapp/payumoney/success.php";
    txnParam.furl = @"https://www.payumoney.com/mobileapp/payumoney/failure.php";
    
    
    // User define parameter
    txnParam.udf1 = @"";
    txnParam.udf2 = @"";
    txnParam.udf3 = @"";
    txnParam.udf4 = @"";
    txnParam.udf5 = @"";
    txnParam.udf6 = @"";
    txnParam.udf7 = @"";
    txnParam.udf8 = @"";
    txnParam.udf9 = @"";
    txnParam.udf10 = @"";
    
    txnParam.hashValue = [self getHashForPaymentParams:txnParam];
    
    [PlugNPlay setMerchantDisplayName:@"Payment"];
    
    [PlugNPlay setButtonColor:COLOR_PRIMARY];
    [PlugNPlay setButtonTextColor:[UIColor whiteColor]];
    [PlugNPlay setTopBarColor:COLOR_PRIMARY];
    [PlugNPlay setTopTitleTextColor:[UIColor whiteColor]];
    [PlugNPlay setIndicatorTintColor:COLOR_PRIMARY];
    
    
    /// Adjust UI as per selection
    [PlugNPlay setDisableCards:enableNetbanking];
    [PlugNPlay setDisableNetbanking:!enableNetbanking];

    
    
    [PlugNPlay presentPaymentViewControllerWithTxnParams:txnParam onViewController:onVC withCompletionBlock:^(NSDictionary *paymentResponse, NSError *error, id extraParam) {
        
        completionBlock(paymentResponse,error,extraParam);
    }];
}

// MARK: Create Random String

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

+(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

// MARK: Create Hash

+(NSString*)getHashForPaymentParams:(PUMTxnParam*)txnParam {
    
    NSString *hashSequence = [NSString stringWithFormat:@"%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@|%@",txnParam.key,txnParam.txnID,txnParam.amount,txnParam.productInfo,txnParam.firstname,txnParam.email,txnParam.udf1,txnParam.udf2,txnParam.udf3,txnParam.udf4,txnParam.udf5,txnParam.udf6,txnParam.udf7,txnParam.udf8,txnParam.udf9,txnParam.udf10, salt];
    
    NSString *hash = [[[[[self createSHA512:hashSequence] description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return hash;
}

+(NSString*) createSHA512:(NSString *)source {
//    NSString*source = param;
//    if ([param containsString:symbol_dollar]) {
//        source = [param stringByReplacingOccurrencesOfString:symbol_dollar withString:@""];
//    }
    
    const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
    
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
    
    CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
    
    NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
    NSLog(@"Hash output --------- %@",output);
    NSString *hash =  [[[[output description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    return hash;
}

@end
