    //
//  ProductDetailVC.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "ProductDetailVC.h"

@interface ProductDetailVC ()

@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"companyIndex %ld",(long)_companyIndex);
    NSLog(@"url %@",_productObj.productName);

    NSURL *url = [NSURL URLWithString:@"https://www.google.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:request];
    _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_webView];

    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onTapEdit)];
    self.navigationItem.rightBarButtonItem = editButton;
}

-(void)onTapEdit
{
    AddProductVC *addProductVC = [[AddProductVC alloc] initWithNibName:@"AddProductVC" bundle:nil];
    addProductVC.isFromEdit = YES;
    addProductVC.productObj = _productObj;
    addProductVC.companyIndex = _companyIndex;
    [self presentViewController:addProductVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_productObj release];
    [_webView release];
    [super dealloc];
}
@end
