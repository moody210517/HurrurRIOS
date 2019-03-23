//
//  CorMainViewController.m
//  Logistika
//
//  Created by BoHuang on 4/27/17.
//  Copyright © 2017 BoHuang. All rights reserved.
//

#import "CorMainViewController.h"
#import "CGlobal.h"
#import "AddressDetailViewController.h"
#import "NetworkParser.h"
#import "TrackingCorViewController.h"
#import "OrderResponse.h"
#import "TblTruck.h"
@interface CorMainViewController ()
@property (nonatomic,strong) LoginResponse* truck_data;
@property (nonatomic,strong) NSString* mTruck;
@end

@implementation CorMainViewController


- (IBAction)btnAction:(id)sender {
    if ([self checkInput]) {
        NSString*name = _txtName.text;
        NSString*email = _txtEmail.text;
        NSString*phone = _txtPhone.text;
        NSString*brief = _txtBrief.text;
        
        
        
        if ([CGlobal isValidEmail:email]) {
            if (g_corporateModel == nil) {
                g_corporateModel = [[CorporateModel alloc] init];
            }
            
            g_corporateModel.name = name;
            g_corporateModel.address = email;
            g_corporateModel.phone = phone;
            g_corporateModel.details = brief;
            g_corporateModel.truck = _mTruck;
            
            UIStoryboard *ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
            AddressDetailViewController* vc = [ms instantiateViewControllerWithIdentifier:@"AddressDetailViewController"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController pushViewController:vc animated:true];
            });
        }else{
            [CGlobal AlertMessage:@"Invalid Email" Title:nil];
            [_txtEmail becomeFirstResponder];
        }
    }else{
        [CGlobal AlertMessage:@"Please enter all info" Title:nil];
    }
}
-(id)checkInput{
    NSString*name = _txtName.text;
    NSString*email = _txtEmail.text;
    NSString*phone = _txtPhone.text;
    NSString*brief = _txtBrief.text;
    if ([name length] == 0 || [email length] == 0 || [phone length] == 0 || [brief length] == 0 || [self.mTruck length] == 0) {
        if ([name length] == 0) {
            [_txtName becomeFirstResponder];
        }else if([email length] == 0){
            [_txtEmail becomeFirstResponder];
        }else if([phone length] == 0){
            [_txtPhone becomeFirstResponder];
        }else if([brief length] == 0){
            [_txtBrief becomeFirstResponder];
        }else if([self.mTruck length] == 0){
            [self.txtTruck becomeFirstResponder];
        }
        
        return nil;
    }
    return [NSNumber numberWithInt:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_PRIMARY;
    self.contentView.backgroundColor = COLOR_SECONDARY_THIRD;
    
    NSString* content = [[NSBundle mainBundle] localizedStringForKey:@"email_corporation" value:@"" table:nil];
    NSLog(@"test %@",content);
    
    self.txtBrief.placeholder = @"Briefly explain what we are delivering for you";
    NSAttributedString* attr_str = self.txtName.attributedPlaceholder;
    [attr_str enumerateAttributesInRange:NSMakeRange(0, [attr_str length])
                                 options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                              usingBlock:^(NSDictionary *attributes, NSRange range, BOOL *stop) {
                                  UIColor *fgColor = [attributes objectForKey:NSForegroundColorAttributeName];
                                  self.txtBrief.placeholderColor = fgColor;
                                  NSLog(@"attributed done");
                              }];
    
//    self.txtBrief.layer.borderWidth = 1;
//    self.txtBrief.layer.borderColor = [UIColor blackColor].CGColor;
//    self.txtBrief.layer.masksToBounds = true;
    // Do any additional setup after loading the view.
    
    UIPickerView* pkView = [[UIPickerView alloc] init];
    self.txtTruck.inputView = pkView;
    pkView.delegate = self;
    pkView.dataSource = self;
    
    [self initTruck];
    
    NSArray* fields = @[self.txtTruck,self.txtName,self.txtEmail,self.txtPhone];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake(0, 0, screenRect.size.width-16, 30);
    for (int i=0; i<fields.count; i++) {
        BorderTextField*field = fields[i];
        [field addBotomLayer:frame];
    }
//    frame = CGRectMake(0, 0, screenRect.size.width-16, 60);
    [self.txtBrief setDelegate:self];
    self.txtBrief_bottom.backgroundColor = [UIColor darkGrayColor];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    self.txtBrief_bottom.backgroundColor = COLOR_PRIMARY;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.txtBrief_bottom.backgroundColor = [UIColor darkGrayColor];
}
-(void)initTruck{
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"get_truck" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil && dict[@"result"] != nil) {
                if ([dict[@"result"] intValue] == 200) {
                    LoginResponse* data = [[LoginResponse alloc] initWithDictionary:dict];
                    if (data.truck.count > 0) {
                        self.truck_data = data;
                        g_truckModels = self.truck_data.truck;
                    }
                    
                }else{
                    [CGlobal AlertMessage:@"Fail" Title:nil];
                }
            }
        }else{
            NSLog(@"Error");
        }
        
    } method:@"POST"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [CGlobal clearData];
    
    EnvVar* env = [CGlobal sharedId].env;
    env.quote = false;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showTrack:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: @"Input Tracking Number"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Tracking Number";
        textField.textColor = [UIColor blueColor];
        textField.borderStyle = UITextBorderStyleLine;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSString* number = namefield.text;
        if ([number length]>0) {
            [self tracking:number];
        }
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)doCall:(id)sender {
    NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
    
    data[@"employer_id"] = @"0";
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [manager ontemplateGeneralRequest2:data BasePath:BASE_DATA_URL Path:@"get_Contact_Details" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        @try {
            NSArray* array = dict;
            NSString*num = [NSString stringWithFormat:@"tel:%@",array[0][@"PhoneNumber"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
        } @catch (NSException *exception) {
            NSLog(@"catch");
        }
        
    } method:@"POST"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:support_phone]];
}
-(void)tracking:(NSString*)number{
    
    NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
    params[@"id"] = number;
    
    NetworkParser* manager = [NetworkParser sharedManager];
    [CGlobal showIndicator:self];
    [manager ontemplateGeneralRequest2:params BasePath:BASE_URL_ORDER Path:@"corporate_tracking" withCompletionBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            if (dict!=nil) {
                if (dict[@"result"]!=nil && [dict[@"result"] intValue] == 400) {
                    NSString*msg = [[NSBundle mainBundle] localizedStringForKey:@"msg_track" value:@"" table:nil];
                    [CGlobal AlertMessage:msg Title:nil];
                }else{
                    OrderResponse* response = [[OrderResponse alloc] initWithDictionary_his_cor:dict];
                    UIStoryboard* ms = [UIStoryboard storyboardWithName:@"Common" bundle:nil];
                    
                    TrackingCorViewController*vc = [ms instantiateViewControllerWithIdentifier:@"TrackingCorViewController"] ;
                    vc.response = response;
                    vc.trackID = number;
                    vc.data = response.orders[0];
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        self.navigationController.navigationBar.hidden = true;
//                        self.navigationController.viewControllers = @[vc];
                        [self.navigationController pushViewController:vc animated:true];
                    });
                }
                
                
            }
        }else{
            NSLog(@"Error");
        }
        [CGlobal stopIndicator:self];
    } method:@"POST"];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.truck_data.truck.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    TblTruck *truck = self.truck_data.truck[row];
    return truck.name;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    TblTruck *truck = self.truck_data.truck[row];
    self.txtTruck.text = truck.name;
    self.mTruck = truck.code;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
