//
//  AddCompanyVC.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "AddCompanyVC.h"

@interface AddCompanyVC ()
@end

@implementation AddCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayouts];
}

#pragma mark - Cancel Button Tap
-(IBAction)onTapSave:(id)sender
{    
    if (_companyFullnameTxt.text.length == 0) {
        [_fullnameView setBackgroundColor:[UIColor redColor]];
        
        if ([_shortnameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_shortnameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_imgUrlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_imgUrlView setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    else if (_companyShortnameTxt.text.length == 0) {
        
        if ([_fullnameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_fullnameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_shortnameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_shortnameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        [_shortnameView setBackgroundColor:[UIColor redColor]];
    }
    else if (_companyImgUrlTxt.text.length == 0) {
        
        if ([_fullnameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_fullnameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_shortnameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_shortnameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        [_imgUrlView setBackgroundColor:[UIColor redColor]];
    }
    else
    {
        if ([_imgUrlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_imgUrlView setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        if (_isFromEdit == YES)
        {
            [self.managerObj updateCompanyWithCompanyFullName:_companyFullnameTxt.text andCompanyShortName:_companyShortnameTxt.text andCompanyUrl:_companyImgUrlTxt.text andStockPrice:_company.stockPrice withCompanyObj:_company];
        }
        else
        {
            [self.managerObj insertCompanyWithCompanyFullName:_companyFullnameTxt.text andCompanyShortName:_companyShortnameTxt.text andCompanyUrl:_companyImgUrlTxt.text andStockPrice:_stockPriceStr];
        }
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark - Cancel Button Tap
-(IBAction)onTapCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:tag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    [_mainView endEditing:YES];
    return YES;
}

-(void)keyboardDidShow
{
    [_mainView setFrame:CGRectMake(_mainView.frame.origin.x,87,_mainView.frame.size.width,_mainView.frame.size.height)];
}

-(void)keyboardDidHide
{
    [_mainView setFrame:CGRectMake(_mainView.frame.origin.x, 165, _mainView.frame.size.width,_mainView.frame.size.height)];
}

-(void)onTapScreen
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - SetUpLayouts
-(void)setUpLayouts
{
    _managerObj = [Manager shareManager];
    
    if (_isFromEdit == YES)
    {
        _companyFullnameTxt.text = _company.comapnyFullName;
        _companyShortnameTxt.text = _company.companyShortName;
        _companyImgUrlTxt.text = _company.comapnyImageUrl;
        _lblTitle.text = @"Edit Company";
    }
    else
    {
        _lblTitle.text = @"New Company";
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapScreen)];
    gesture.numberOfTouchesRequired = 1;
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    self.view.userInteractionEnabled = YES;
    
    [gesture release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_companyFullnameTxt release];
    [_companyShortnameTxt release];
    [_companyImgUrlTxt release];
    [_fullnameView release];
    [_shortnameView release];
    [_imgUrlView release];
    [_lblTitle release];
    [_stockPriceStr release];
    [_mainView release];
    [super dealloc];
}
@end
