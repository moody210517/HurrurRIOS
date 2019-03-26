
//
//  AutoCompleteTextField.m
//  AutoCompleteTextField
//
//  Created by Chandan on 5/6/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CAAutoFillTextField.h"
#import "CAAutoCompleteObject.h"
#import "CGlobal.h"

@interface CAAutoFillTextField()

@property (nonatomic, strong) NSMutableArray <CAAutoCompleteObject *> *autoCompleteArray;
@property (nonatomic, strong) UITableView *autoCompleteTableView;
@property (nonatomic, assign) CGFloat tableHeight;


@end

@implementation CAAutoFillTextField

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        CGRect frame = self.frame;
        self.tableHeight = 30.0;
        
        _txtField = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        _txtField.borderStyle = UITextBorderStyleRoundedRect; // rounded, recessed rectangle
        _txtField.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtField.textAlignment = NSTextAlignmentLeft;
        _txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _txtField.returnKeyType = UIReturnKeyDone;
//        _txtField.font = [UIFont systemFontOfSize:14.0];
//        _txtField.textColor = [UIColor blackColor];
//        _txtField.clipsToBounds = NO;
        [_txtField setDelegate:self];
        [self addSubview:_txtField];
        
        //Autocomplete Table
        //        self.autoCompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(3, _txtField.frame.origin.y+_txtField.frame.size.height, frame.size.width - 5, self.tableHeight) style:UITableViewStylePlain];
        CGRect autoFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y+_txtField.frame.size.height, frame.size.width, self.tableHeight);
        self.autoCompleteTableView = [[UITableView alloc] initWithFrame:autoFrame style:UITableViewStylePlain];
        self.autoCompleteTableView.delegate = self;
        self.autoCompleteTableView.dataSource = self;
        self.autoCompleteTableView.scrollEnabled = YES;
        self.autoCompleteTableView.hidden = NO;
        self.autoCompleteTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.autoCompleteTableView.rowHeight = self.tableHeight;
        //        [self addSubview:self.autoCompleteTableView];
        //self.autoCompleteTableView.backgroundColor = [UIColor yellowColor];
        
        
        
        _dataSourceArray = [[NSMutableArray alloc] init];
        _autoCompleteArray = [[NSMutableArray alloc] init];
        
        UITapGestureRecognizer*gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self.autoCompleteTableView addGestureRecognizer:gesture];
        
        self.autoCompleteTableView.backgroundColor = [UIColor clearColor];
        _txtField.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)setViewParent:(UIView *)viewParent{
    _viewParent = viewParent;
    if ([self.autoCompleteTableView superview]!=nil) {
        [self.autoCompleteTableView removeFromSuperview];
    }
    [viewParent addSubview:self.autoCompleteTableView];
 //   self.autoCompleteTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    viewParent.backgroundColor = COLOR_RESERVED;
    
}
- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.tableHeight = 30.0;
        
        _txtField = [[BorderTextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        _txtField.borderStyle = UITextBorderStyleRoundedRect; // rounded, recessed rectangle
        _txtField.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtField.textAlignment = NSTextAlignmentLeft;
        _txtField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _txtField.returnKeyType = UIReturnKeyDone;
//        _txtField.font = [UIFont systemFontOfSize:14.0];
//        _txtField.textColor = [UIColor blackColor];
//        _txtField.clipsToBounds = NO;
        _txtField.delegate = self;
        [self addSubview:_txtField];
        
        //Autocomplete Table
        //        self.autoCompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(3, _txtField.frame.origin.y+_txtField.frame.size.height, frame.size.width - 5, self.tableHeight) style:UITableViewStylePlain];
        CGRect autoFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y+_txtField.frame.size.height, frame.size.width, self.tableHeight);
        self.autoCompleteTableView = [[UITableView alloc] initWithFrame:autoFrame style:UITableViewStylePlain];
        self.autoCompleteTableView.delegate = self;
        self.autoCompleteTableView.dataSource = self;
        self.autoCompleteTableView.scrollEnabled = YES;
        self.autoCompleteTableView.hidden = NO;
        self.autoCompleteTableView.rowHeight = self.tableHeight;
        //        [self addSubview:self.autoCompleteTableView];
        
        UITapGestureRecognizer*gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self.autoCompleteTableView addGestureRecognizer:gesture];
        
        _dataSourceArray = [[NSMutableArray alloc] init];
        _autoCompleteArray = [[NSMutableArray alloc] init];
    }
    
    _txtField.backgroundColor = [UIColor whiteColor];
    self.autoCompleteTableView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
-(void)handleTapGesture:(UITapGestureRecognizer*)gesture{
    NSLog(@"sss");
    CGPoint pt = [gesture locationInView:self.autoCompleteTableView];
    NSIndexPath* indexPath = [self.autoCompleteTableView indexPathForRowAtPoint:pt];
    
    CAAutoCompleteObject *object = [_autoCompleteArray objectAtIndex:indexPath.row];
    _txtField.text = object.objName;
    [self finishedSearching];
    
    if ([self.delegate respondsToSelector:@selector(CAAutoTextFillDidSelectRow:)]) {
        [self.delegate CAAutoTextFillDidSelectRow:object];
    }
    
    [self.txtField resignFirstResponder];
}

// Take string from Search Textfield and compare it with autocomplete array
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    [_autoCompleteArray removeAllObjects];
    
    for(CAAutoCompleteObject *object in _dataSourceArray) {
        NSRange substringRangeLowerCase = [[object.objName lowercaseString] rangeOfString:[substring lowercaseString]];
        
        if (substringRangeLowerCase.length != 0) {
            [_autoCompleteArray addObject:object];
        }
    }
    self.autoCompleteTableView.hidden = NO;
    [self setViewParent:self.viewParent];
    [self.autoCompleteTableView reloadData];
    
    if (self.scrollParent!=nil) {
        CGRect screenRect = [UIScreen mainScreen].bounds;
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect src = self.frame;
        CGRect dst = [self convertRect:self.frame toView:window];
        
        NSLog(@"src %f %f %f %f",src.origin.x,src.origin.y,src.size.width,src.size.height);
        NSLog(@"dst %f %f %f %f",dst.origin.x,dst.origin.y,dst.size.width,dst.size.height);
        
        CGRect tableRect = [self.autoCompleteTableView convertRect:self.autoCompleteTableView.bounds toView:window];
        
        CGFloat total = tableRect.origin.y + tableRect.size.height + g_keyboardRect.size.height;
        if (total > screenRect.size.height) {
            // need more
            //            self.scrollParent.scrollEnabled = true;
            
            CGPoint pt = self.scrollParent.contentOffset;
            pt.y = pt.y + total - screenRect.size.height;
            [self.scrollParent setContentOffset:pt animated:TRUE];
            
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                self.scrollParent.scrollEnabled = false;
            //
            //            });
        }else{
            //            self.scrollParent.scrollEnabled = false;
        }
        self.scrollParent.backgroundColor = [UIColor clearColor];
    }
    
    
    
}

#pragma mark UITableViewDelegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    
    //Resize auto complete table based on how many elements will be displayed in the table
    
    CGRect tableRect;
    CGRect baseViewRect;
    NSInteger returnCount = 0;
    
    if (_autoCompleteArray.count >=3) {
        tableRect = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, self.tableHeight*6);
        baseViewRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (self.tableHeight*6)+30);
        returnCount = _autoCompleteArray.count;
    }
    
    else if (_autoCompleteArray.count == 2 || _autoCompleteArray.count == 1) {
        tableRect = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, self.tableHeight*2);
        baseViewRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (self.tableHeight*2)+30);
        returnCount = _autoCompleteArray.count;
    }
    
    else {
        tableRect = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 0.0);
        baseViewRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.tableHeight);
        returnCount = _autoCompleteArray.count;
    }
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^ {
        self.autoCompleteTableView.frame = tableRect;
        self.frame = baseViewRect;
    } completion:^(BOOL finished) { }];
    
    self.autoCompleteTableView.hidden = NO;
    if (returnCount == 0) {
        self.autoCompleteTableView.hidden = YES;
    }
    return returnCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15.0]];
        
        CGFloat version = [[[ UIDevice currentDevice ] systemVersion ] floatValue];
        if( version > 6 ){
            [cell setBackgroundColor:[UIColor clearColor]];
        }
    }
    CAAutoCompleteObject *object = [_autoCompleteArray objectAtIndex:indexPath.row];
    cell.textLabel.text = object.objName;
    cell.backgroundColor = [UIColor whiteColor]; // [CGlobal colorWithHexString:@"F3F5E1" Alpha:1.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CAAutoCompleteObject *object = [_autoCompleteArray objectAtIndex:indexPath.row];
    _txtField.text = object.objName;
    [self finishedSearching];
    
    if ([self.delegate respondsToSelector:@selector(CAAutoTextFillDidSelectRow:)]) {
        [self.delegate CAAutoTextFillDidSelectRow:object];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableHeight;
}
- (void) finishedSearching {
    [self resignFirstResponder];
    
    [_autoCompleteArray removeAllObjects];
    [self.autoCompleteTableView reloadData];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(CAAutoTextFillBeginEditing:)]) {
        [_delegate CAAutoTextFillBeginEditing:self];
        
        double delayInSeconds = 3.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            //code to be executed on the main queue after delay
            self.scrollParent.scrollEnabled = false;
            self.autoCompleteTableView.scrollEnabled = true;
        });
    }
    self.autoCompleteTableView.scrollEnabled = true;
    self.txtField.bottomLine.borderColor = COLOR_PRIMARY.CGColor;
    self.txtField.bottomLine.borderWidth = g_txtBorderWidth;
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    if ([_delegate respondsToSelector:@selector(CAAutoTextFillEndEditing:)]) {
        [_delegate CAAutoTextFillEndEditing:self];
        
        self.autoCompleteTableView.hidden = true;
        double delayInSeconds = 1.0;
        self.scrollParent.scrollEnabled = true;
        self.autoCompleteTableView.scrollEnabled = false;
        
        [self.autoCompleteTableView removeFromSuperview];
    }
    self.txtField.bottomLine.borderColor = [UIColor lightGrayColor].CGColor;
    self.txtField.bottomLine.borderWidth = g_txtBorderWidth;
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL didYES = NO;
    if ([_delegate respondsToSelector:@selector(CAAutoTextFillWantsToEdit:)]) {
        didYES =  [_delegate CAAutoTextFillWantsToEdit:self];
    }
    
    return didYES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *substring = [NSString stringWithString:_txtField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    
    return YES;
}

-(void)setDataSourceArray:(NSMutableArray<CAAutoCompleteObject *> *)dataSourceArray{
    [dataSourceArray sortUsingComparator:^NSComparisonResult(CAAutoCompleteObject* obj1, CAAutoCompleteObject* obj2) {
        NSString* first = obj1.objName;
        NSString* second = obj2.objName;
        
        return [first compare:second];
    }];
    
    _dataSourceArray = dataSourceArray;
}
- (void)dealloc {
    [_dataSourceArray removeAllObjects];
    [_autoCompleteArray removeAllObjects];
    
    _autoCompleteArray = nil;;
    _dataSourceArray = nil;
    
    [self.autoCompleteTableView removeFromSuperview];
    self.autoCompleteTableView = nil;
    [_txtField removeFromSuperview];
    _txtField = nil;
}

@end
