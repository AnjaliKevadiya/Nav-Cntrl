//
//  ProductListVC.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/31/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "ProductListVC.h"

@interface ProductListVC ()

@end

@implementation ProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _managerObj = [Manager shareManager];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapAddProduct:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127.0f/255.0f green:180.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    _companyTitleLbl.text = self.title;
    _companyNameLbl.text = _comapnyFullnameStr;
    _companyImgView.image = [UIImage imageNamed:_companyImgStr];
    
    NSLog(@"companyIndex %ld",(long)_companyIndex);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Company *company = [_managerObj.companyArr objectAtIndex:_companyIndex];
    _productArr = company.productArr;
    
    NSLog(@"_productArr %@",_productArr);
    
    if (_productArr.count > 0)
    {
        [_tblView setHidden:NO];
        [_noDataView setHidden:YES];
    }
    else
    {
        [_tblView setHidden:YES];
        [_noDataView setHidden:NO];
    }
    [_tblView reloadData];
}

-(IBAction)onTapAddProduct:(id)sender
{
    AddProductVC *addProductVC = [[AddProductVC alloc] initWithNibName:@"AddProductVC" bundle:nil];
    addProductVC.companyIndex = _companyIndex;
    [self presentViewController:addProductVC animated:YES completion:^{
        
    } ];
}

-(IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _productArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CompanyTableViewCell";
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    _productObj = [_productArr objectAtIndex:indexPath.row];
    cell.lblName.text = _productObj.productName;
    cell.lblStockPrice.text = @"";
    cell.imgView.image = [UIImage imageNamed:_productObj.productImageUrl];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _productObj = [_productArr objectAtIndex:indexPath.row];
    
    ProductDetailVC *productDetailVC = [[ProductDetailVC alloc] init];
    productDetailVC.companyIndex = _companyIndex;
    productDetailVC.productObj = _productObj;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        _productObj = [_productArr objectAtIndex:indexPath.row];
        [_productArr removeObjectAtIndex:indexPath.row];
        [self.managerObj deleteProduct:_productObj andCompanyIndex:_companyIndex];
        [_tblView reloadData];
        
        if (_productArr.count > 0)
        {
            [_tblView setHidden:NO];
            [_noDataView setHidden:YES];
        }
        else
        {
            [_tblView setHidden:YES];
            [_noDataView setHidden:NO];
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
