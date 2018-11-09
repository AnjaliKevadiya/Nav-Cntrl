//
//  AddProductVC.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "AddProductVC.h"

@interface AddProductVC ()

@end

@implementation AddProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _managerObj = [Manager shareManager];
    //_productObj = [Product sharedProduct];
    
    if (_isFromEdit == YES)
    {
        _productNameTxt.text = _productObj.productName;
        _productUrlTxt.text = _productObj.productUrl;
        _productImgUrlTxt.text = _productObj.productImageUrl;
        
        NSLog(@"_productObj.productName %@",_productObj.productName);
    }
    NSLog(@"_companyIndex %ld",(long)_companyIndex);

}

-(IBAction)onTapSave:(id)sender
{
    if (_productNameTxt.text.length == 0) {
        [_nameView setBackgroundColor:[UIColor redColor]];
        
        if ([_urlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_urlView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_imgUrlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_imgUrlView setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    else if (_productUrlTxt.text.length == 0) {
        
        [_urlView setBackgroundColor:[UIColor redColor]];

        if ([_nameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_nameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_imgUrlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_imgUrlView setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    else if (_productImgUrlTxt.text.length == 0) {
        
        [_imgUrlView setBackgroundColor:[UIColor redColor]];
        
        if ([_nameView.backgroundColor isEqual:[UIColor redColor]]) {
            [_nameView setBackgroundColor:[UIColor lightGrayColor]];
        }
        if ([_urlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_urlView setBackgroundColor:[UIColor lightGrayColor]];
        }
    }
    else
    {
        if ([_imgUrlView.backgroundColor isEqual:[UIColor redColor]]) {
            [_imgUrlView setBackgroundColor:[UIColor lightGrayColor]];
        }
        
        if (_isFromEdit == YES)
        {
            [self.managerObj updateProductWithProductName:_productNameTxt.text andProductUrl:_productUrlTxt.text andProductImgUrl:_productImgUrlTxt.text andProductObj:_productObj];
            

        }
        else
        {
            [self.managerObj insertProductWithProductName:_productNameTxt.text andProductUrl:_productUrlTxt.text andProductImgUrl:_productImgUrlTxt.text andCompanyIndex:_companyIndex];
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
}

-(void)dealloc
{
    [_productObj release];
    [_managerObj release];
    [_productNameTxt release];
    [_productUrlTxt release];
    [_productImgUrlTxt release];
    [_nameView release];
    [_urlView release];
    [_imgUrlView release];
    [super dealloc];
}

@end
