//
//  ProductDetailVC.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductVC.h"

@import WebKit;

@interface ProductDetailVC : UIViewController <WKNavigationDelegate>

@property(nonatomic) NSInteger companyIndex;
@property(retain, nonatomic) Product *productObj;
@property(retain, nonatomic) WKWebView *webView;

@end
