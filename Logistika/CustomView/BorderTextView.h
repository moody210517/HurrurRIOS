//
//  BorderTextView.h
//  Logistika
//
//  Created by BoHuang on 6/22/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "GCPlaceholderTextView.h"

@interface BorderTextView : GCPlaceholderTextView<UITextViewDelegate>
@property (nonatomic) IBInspectable NSInteger backMode;
@property (nonatomic,strong) CALayer*bottomLine;

-(void)addBotomLayer:(CGRect)param;
@end
