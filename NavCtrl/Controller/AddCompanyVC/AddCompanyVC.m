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
        
        [self.managerObj insertCompanyWithCompanyFullName:_companyFullnameTxt.text andCompanyShortName:_companyShortnameTxt.text andCompanyUrl:_companyImgUrlTxt.text andStockPrice:_stockPriceStr andProducts:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(IBAction)onTapCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//-(void)onTapSave:(UIBarButtonItem*)item{
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}

//-(void)saveCompanyTap
//{
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
