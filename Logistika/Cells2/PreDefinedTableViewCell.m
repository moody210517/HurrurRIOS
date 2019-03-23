//
//  PreDefinedTableViewCell.m
//  Logistika
//
//  Created by BoHuang on 4/26/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "PreDefinedTableViewCell.h"
#import "CGlobal.h"
@implementation PreDefinedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _txtWeight.font = [UIFont systemFontOfSize:15];
    _txtQuantity.font = [UIFont systemFontOfSize:15];
    _txtItem.font = [UIFont systemFontOfSize:15];
    
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
    
    self.pkItem = [[UIPickerView alloc] init];
    UIToolbar* tb_item = [[UIToolbar alloc] init];
    tb_item.barStyle = UIBarStyleDefault;
    tb_item.translucent = true;
    tb_item.tintColor = [UIColor darkGrayColor];
    [tb_item sizeToFit];
    UIBarButtonItem *temp3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done3 = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    [tb_item setItems:@[temp3,done3]];
    tb_item.userInteractionEnabled = true;
    done3.tag = 202;
    
//    _txtItem.inputView = self.pkItem;
//    _txtItem.inputAccessoryView = tb_item;
    
    [self.txtWeight addTarget:self action:@selector(doneEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self.txtQuantity addTarget:self action:@selector(doneEdit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.pkWeight.delegate = self;
    self.pkWeight.dataSource = self;
    
    self.pkQuantity.delegate = self;
    self.pkQuantity.dataSource = self;
    
    self.pkItem.delegate = self;
    self.pkItem.dataSource = self;
    

    [_txtItem addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)textChanged:(UITextField*)textField{
    if (self.data!=nil) {
        if (textField == self.txtItem) {
            self.data.title = textField.text;
        }
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
    }else if(tag == 201){
        //quantity
        [self.pkQuantity removeFromSuperview];
        [self.txtQuantity resignFirstResponder];
        NSInteger row = [self.pkQuantity selectedRowInComponent:0];
        _txtQuantity.text = c_quantity[row];
        
        self.data.quantity = c_quantity[row];
    }else{
        [self.pkItem removeFromSuperview];
        [self.txtItem resignFirstResponder];
        NSInteger row = [self.pkItem selectedRowInComponent:0];
        _txtItem.text = c_packageLists[row];
        
        self.data.title = c_packageLists[row];
    }
    
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
    _txtItem.text = model.title;
    _txtQuantity.text = model.quantity;
    _txtWeight.text = model.weight;
    
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
    
//    found = [c_packageLists indexOfObject:model.title];
//    if (found!=NSNotFound) {
//        self.txtItem.text = c_packageLists[found];
//    }else{
//        self.txtItem.text = c_packageLists[0];
//        model.title = c_packageLists[0];
//    }
    if ([model.mPackage isEqualToString:@"1"]) {
        [self.swPackage setOn:true];
    }else{
        [self.swPackage setOn:false];
    }
}
- (IBAction)swPackageChanged:(id)sender {
    if ([self.swPackage isOn]) {
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
    }else if(pickerView == self.pkWeight){
        return c_weight.count;
    }else{
        return c_packageLists.count;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.pkQuantity) {
        self.data.quantity = c_quantity[row];
    }else if(pickerView == self.pkWeight){
        self.data.weight = c_weight[row];
        self.data.weight_value = [c_weight_value[row] intValue];
    }else{
        self.data.title = c_packageLists[row];
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.pkQuantity) {
        return c_quantity[row];
    }else if(pickerView == self.pkWeight){
        return c_weight[row];
    }else{
        return c_packageLists[row];
    }
}
@end
