//
//  HomeVC.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyVC.h"
#import "Company.h"
#import "Manager.h"
#import "AddCompanyVC.h"
#import "Product.h"
#import "CompanyTableViewCell.h"
#import "ProductListVC.h"

@interface HomeVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *noDataView;

@property (retain, nonatomic) Manager *manager;
@property (retain, nonatomic) Company *company;
@property (retain, nonatomic) ProductListVC *productListVC;

@property (retain, nonatomic) NSMutableArray *companyArr;

-(IBAction)onTapAdd:(id)sender;

@end
