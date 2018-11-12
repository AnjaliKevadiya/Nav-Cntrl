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
    [self setUpLayouts];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Company *company = [_managerObj.companyArr objectAtIndex:_companyIndex];

    if (_productArr) {
        [_productArr removeAllObjects];
        [_productArr release];
    }
    NSSet *set = [_managerObj showAllProductsWithCompanyIndex:_companyIndex];
    _productArr = [[set allObjects] mutableCopy];
    
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

#pragma mark - Add Product Tap
-(IBAction)onTapAddProduct:(id)sender
{
    AddProductVC *addProductVC = [[AddProductVC alloc] initWithNibName:@"AddProductVC" bundle:nil];
    addProductVC.companyIndex = _companyIndex;
    [self presentViewController:addProductVC animated:YES completion:^{
    }];
    [addProductVC release];
}

#pragma mark - Back Tap
-(IBAction)onTapBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Delegate
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
    //cell.imgView.image = [UIImage imageNamed:_productObj.productImageUrl];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [[NSURL alloc] initWithString:_productObj.productImageUrl];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        [url release];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ( data == nil )
            {
                cell.imgView.image = [UIImage imageNamed:@"emptystate-homeView"];
                return ;
            }
            else
            {
                cell.imgView.image = [UIImage imageWithData: data];
            }
        });
        [data release];
    });

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _productObj = [_productArr objectAtIndex:indexPath.row];
    
    ProductDetailVC *productDetailVC = [[[ProductDetailVC alloc] init] autorelease];
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

#pragma mark - SetUpLayouts
-(void)setUpLayouts
{
    self.managerObj = [Manager shareManager];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapAddProduct:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127.0f/255.0f green:180.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _companyTitleLbl.text = self.title;
    _companyNameLbl.text = _comapnyFullnameStr;
    //_companyImgView.image = [UIImage imageNamed:_companyImgStr];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURL *url = [[NSURL alloc] initWithString:_companyImgStr];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        [url release];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ( data == nil )
            {
                _companyImgView.image = [UIImage imageNamed:@"emptystate-homeView"];
                return ;
            }
            else
            {
                _companyImgView.image = [UIImage imageWithData:data];
            }
        });
        [data release];
    });
    //NSLog(@"companyIndex %ld",(long)_companyIndex);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    [_companyNameLbl release];
    [_companyTitleLbl release];
    [_companyImgView release];
    [_tblView release];
    [_noDataView release];
    [_productArr release];
    [_companyImgStr release];
    [_companyTitleStr release];
    [_comapnyFullnameStr release];
   // [_managerObj release];
    [_productObj release];
    
    [super dealloc];
}
@end
