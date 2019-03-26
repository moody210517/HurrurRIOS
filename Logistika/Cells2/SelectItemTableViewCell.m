//
//  SelectItemTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 4/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "SelectItemTableViewCell.h"
#import "CGlobal.h"
#import "TblArea.h"
#import "CAAutoCompleteObject.h"

@implementation SelectItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //    [self.cbWeight setDelegate:self];
    //    [self.cbQuantity setDelegate:self];
    
    //    self.cbWeight.entries = c_weight;
    //    self.cbQuantity.entries = c_quantity;
    
    //    self.cbWeight.font = [UIFont systemFontOfSize:15];
    //    self.cbQuantity.font = [UIFont systemFontOfSize:15];
    
    _txtWeight.font = [UIFont systemFontOfSize:15];
    _txtQuantity.font = [UIFont systemFontOfSize:15];
    
    self.pkWeight = [[UIPickerView alloc] init];
    UIToolbar* tb_weight = [[UIToolbar alloc] init];
    tb_weight.barStyle = UIBarStyleDefault;
    tb_weight.translucent = true;
    tb_weight.tintColor = [UIColor darkGrayColor];
    [tb_weight sizeToFit];
    UIBarButtonItem *temp1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done1 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [tb_weight setItems:@[temp1,done1]];
    tb_weight.userInteractionEnabled = true;
    done1.tag = 200;
    
    _txtWeight.inputView = self.pkWeight;
    _txtWeight.inputAccessoryView = tb_weight;
    
    self.pkQuantity = [[UIPickerView alloc] init];
    UIToolbar* tb_quantity = [[UIToolbar alloc] init];
    tb_quantity.barStyle = UIBarStyleDefault;
    tb_quantity.translucent = true;
    tb_quantity.tintColor = [UIColor darkGrayColor];
    [tb_quantity sizeToFit];
    UIBarButtonItem *temp2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done2 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [tb_quantity setItems:@[temp2,done2]];
    tb_quantity.userInteractionEnabled = true;
    done2.tag = 201;
    
    _txtQuantity.inputView = self.pkQuantity;
    _txtQuantity.inputAccessoryView = tb_quantity;
    
    [self.txtWeight addTarget:self action:@selector(doneEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.txtQuantity addTarget:self action:@selector(doneEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.pkWeight.delegate = self;
    self.pkWeight.dataSource = self;
    
    self.pkQuantity.delegate = self;
    self.pkQuantity.dataSource = self;
    
    [_txtItem.txtField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_txtL addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_txtB addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [_txtH addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.aTextDelegate = [[MyTextDelegate alloc] init];
    self.txtL.delegate = self.aTextDelegate;
    self.txtB.delegate = self.aTextDelegate;
    self.txtH.delegate = self.aTextDelegate;
    
 
    
//    NSRange rangeOfFirstLineBreak = [self.txtL.text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]];
//    // check if first line break range was found
//    if (rangeOfFirstLineBreak.location == NSNotFound) {
//        // if it was, extract the first line only and update the cell text
//        self.txtL.text = [self.txtL.text substringToIndex:rangeOfFirstLineBreak.location];
//    }
//
    
    
    NSArray* fields = @[self.txtL,self.txtB,self.txtH];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, (screenRect.size.width-144)/3-14, 30);
    for (int i=0; i<fields.count; i++) {
        if ([fields[i] isKindOfClass:[BorderTextField class]]) {
            BorderTextField*field = fields[i];
            [field addBotomLayer:frame];
        }else if([fields[i] isKindOfClass:[CAAutoFillTextField class]]){
//            CAAutoFillTextField* ca = fields[i];
//            [ca.txtField addBotomLayer:frame];
//            ca.txtField.delegate = ca;
        }
    }
    
    frame = CGRectMake(0, 0, (screenRect.size.width-144), 30);
    CAAutoFillTextField* ca = self.txtItem;
//    [ca.txtField addBotomLayer:frame];
//    ca.txtField.delegate = ca;
    
    if (true) {//g_areaData.area.count > 0
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<g_areaData.items.count; i++) {
            TblArea* item = g_areaData.items[i];
            CAAutoCompleteObject *object = [[CAAutoCompleteObject alloc] initWithObjectName:item.title AndID:i];
            [tempArray addObject:object];
        }
        [self.txtItem setDataSourceArray:tempArray];
        [self.txtItem setDelegate:self];
        
        self.txtItem.viewParent = [self.txtItem superview];
        self.txtItem.txtField.placeholder = @"Enter the item here";
        self.txtItem.txtField.textAlignment = UITextAlignmentCenter;
//        self.txtArea.scrollParent = self.scrollParent;
    }
    
//    self.backgroundColor = [UIColor clearColor];
    self.cview.backgroundColor = COLOR_RESERVED;
    
//    UITextField* sample =  [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//    self.txtItem.txtField.borderStyle = UITextBorderStyleRoundedRect;
////    self.txtItem.txtField.autocorrectionType = UITextAutocorrectionTypeNo;
////    self.txtItem.txtField.textAlignment = NSTextAlignmentLeft;
////    self.txtItem.txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    self.txtItem.txtField.autoresizingMask = sample.autoresizingMask;
////    self.txtItem.txtField.returnKeyType = UIReturnKeyDone;
////    self.txtItem.txtField.font = [UIFont systemFontOfSize:14.0];
////    self.txtItem.txtField.textColor = [UIColor blackColor];
//    self.txtItem.txtField.clipsToBounds = sample.autoresizingMask;
    
    self.txtItem.backgroundColor = [UIColor orangeColor];
    self.txtItem.txtField.borderStyle = UITextBorderStyleNone;
    //self.txtItem.txtField.backgroundColor = [UIColor clearColor];
    

}
-(void)textChanged:(UITextField*)textField{
    
    
       self.txtH.text = (self.txtH.text.length > 3 ? [self.txtH.text substringToIndex:3]:self.txtH.text);
       self.txtL.text = (self.txtL.text.length > 3 ? [self.txtL.text substringToIndex:3]:self.txtL.text);
       self.txtB.text = (self.txtB.text.length > 3 ? [self.txtB.text substringToIndex:3]:self.txtB.text);
    
    if (textField == self.txtItem.txtField) {
        self.data.title = textField.text;
    }else if(textField == self.txtL){
        self.data.dimension1 = self.txtL.text;
    }else if(textField == self.txtB){
        self.data.dimension2 = self.txtB.text;
    }else if(textField == self.txtH){
        self.data.dimension3 = self.txtH.text;
    }
    
    
    
    
}

-(void)done:(UIView*)sender{
    NSLog(@"done");
    int tag = (int)sender.tag;
    if (tag == 200) {
        // weight
        [self.pkWeight removeFromSuperview];
        [self.txtWeight resignFirstResponder];
        NSInteger row = [self.pkWeight selectedRowInComponent:0];
        _txtWeight.text = c_weight[row];
        
        self.data.weight = c_weight[row];
        self.data.weight_value = [c_weight_value[row] intValue];
        if (self.aDelegate!=nil) {
            [self.aDelegate didSubmit:@{@"action":@"select"} View:self];
        }
    }else{
        //quantity
        [self.pkQuantity removeFromSuperview];
        [self.txtQuantity resignFirstResponder];
        NSInteger row = [self.pkQuantity selectedRowInComponent:0];
        _txtQuantity.text = c_quantity[row];
        
        self.data.quantity = c_quantity[row];
    }
    
//    self.txtItem.layer.cornerRadius = 4;
//    self.txtItem.layer.masksToBounds = true;
    
    
    
    
}
-(void)doneEdit:(UITextField*)textField{
    if (textField == self.txtWeight) {
        
    }else{
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)initMe:(ItemModel*)model{
    self.backgroundColor = [UIColor whiteColor];
    _txtItem.txtField.text = model.title;
    _txtL.text = model.dimension1;
    _txtB.text = model.dimension2;
    _txtH.text = model.dimension3;
    

    
    self.data = model;
    
    [self.btnRemove addTarget:self action:@selector(clickView:) forControlEvents:UIControlEventTouchUpInside];
    self.btnRemove.tag = 100;
    
    NSInteger found = [c_quantity indexOfObject:model.quantity];
    if (found!=NSNotFound) {
        self.txtQuantity.text = c_quantity[found];
    }else{
        self.txtQuantity.text = c_quantity[0];
        model.quantity = c_quantity[0];
    }
    
    found = [c_weight indexOfObject:model.weight];
    if (found!=NSNotFound) {
        self.txtWeight.text = c_weight[found];
        model.weight_value = [c_weight_value[found] intValue];
    }else{
        self.txtWeight.text = c_weight[0];
        model.weight = c_weight[0];
        model.weight_value = [c_weight_value[0] intValue];
    }    
    if ([model.mPackage isEqualToString:@"1"]) {
        [self.swPackaging setOn:true];
    }else{
        [self.swPackaging setOn:false];
    }
}

- (BOOL)textField:(UITextField *)textField
                 :(NSRange)range replacementString:(NSString *)string {
    if(textField == self.txtL || textField == self.txtB || textField == self.txtH){
        if (textField.text.length < 3 || string.length == 0){
            return YES;
        }
        else{
            return NO;
        }
    }else{
        return NO;
    }
}


- (IBAction)swPackageChanged:(id)sender {
    if ([self.swPackaging isOn]) {
        self.data.mPackage = @"1";
    }else{
        self.data.mPackage = @"0";
    }
}

-(void)clickView:(UIView*)sender{
    int tag = (int)sender.tag;
    switch (tag) {
        case 100:
        {
            if (self.aDelegate!=nil) {
                [self.aDelegate didSubmit:@{@"action":@"remove"} View:self];
            }
            break;
        }
        default:
            break;
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.pkQuantity) {
        return c_quantity.count;
    }else{
        return c_weight.count;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.pkQuantity) {
        self.data.quantity = c_quantity[row];
    }else{
        self.data.weight = c_weight[row];
        self.data.weight_value = [c_weight_value[row] intValue];
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.pkQuantity) {
        return c_quantity[row];
    }else{
        return c_weight[row];
    }
}

- (void) CAAutoTextFillBeginEditing:(CAAutoFillTextField *) textField {
    
}

- (void) CAAutoTextFillEndEditing:(CAAutoFillTextField *) textField {
    
}

- (BOOL) CAAutoTextFillWantsToEdit:(CAAutoFillTextField *) textField {
    return YES;
}
-(void)CAAutoTextFillDidSelectRow:(CAAutoCompleteObject *)row{
    self.data.title = row.objName;
}
@end
