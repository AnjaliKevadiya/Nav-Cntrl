//
//  ProductListVC.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/31/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductVC.h"
#import "Product.h"
#import "CompanyTableViewCell.h"
#import "ProductDetailVC.h"

@interface ProductListVC : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property(retain, nonatomic) IBOutlet UILabel *companyNameLbl, *companyTitleLbl;
@property(retain, nonatomic) IBOutlet UIImageView *companyImgView;
@property(retain, nonatomic) IBOutlet UITableView *tblView;
@property(retain, nonatomic) IBOutlet UIView *noDataView;
@property(nonatomic) NSInteger companyIndex;

@property (retain, nonatomic) Manager *managerObj;
@property(retain, nonatomic) Product *productObj;

@property(retain, nonatomic) NSString *companyTitleStr, *comapnyFullnameStr, *companyImgStr;
@property (retain, nonatomic) NSMutableArray *productArr;
-(IBAction)onTapAddProduct:(id)sender;
-(IBAction)onTapBack:(id)sender;

@end
