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
}

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

-(IBAction)onTapCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    [_managerObj release];
    [_stockPriceStr release];
    [_company release];
    [super dealloc];
}
@end
