//
//  HomeVC.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC () <ManagerDelegate>

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(onTapAdd:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:127.0f/255.0f green:180.0f/255.0f blue:57.0f/255.0f alpha:1.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _manager = [Manager shareManager];
    _manager.updateDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    _companyArr = _manager.companyArr;
 

    if (_companyArr.count == 0)
    {
        [_tableView setHidden:YES];
        [_noDataView setHidden:NO];
    }
    else
    {
        [_tableView setHidden:NO];
        [_noDataView setHidden:YES];
    }
    [_tableView reloadData];
    
    [self.manager fetchStockPrices];
}

#pragma mark - Add Company
-(IBAction)onTapAdd:(id)sender
{
    AddCompanyVC *addCompanyVC = [[AddCompanyVC alloc] initWithNibName:@"AddCompanyVC" bundle:nil];
    [self presentViewController:addCompanyVC animated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return _companyArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompanyTableViewCell";
    CompanyTableViewCell *cell = (CompanyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompanyTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    _company = [_companyArr objectAtIndex:indexPath.row];
    
    NSString *companyName = [NSString stringWithFormat:@"%@(%@)",_company.comapnyFullName,_company.companyShortName];
    cell.lblName.text = companyName;
    cell.lblStockPrice.text = _company.stockPrice;
    cell.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_company.comapnyImageUrl]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _productListVC = [[ProductListVC alloc] init];
    
    _company = [_companyArr objectAtIndex:indexPath.row];
    
    _productListVC.title = _company.comapnyFullName;
    _productListVC.comapnyFullnameStr = [NSString stringWithFormat:@"%@(%@)",_company.comapnyFullName,_company.companyShortName];
    _productListVC.companyImgStr = _company.comapnyImageUrl;
    _productListVC.companyIndex = indexPath.row;
    [self.navigationController pushViewController:_productListVC animated:YES];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_companyArr removeObjectAtIndex:indexPath.row];
        
        [_tableView reloadData];
        if (_companyArr.count == 0)
        {
            [_tableView setHidden:YES];
            [_noDataView setHidden:NO];
        }
        else
        {
            [_tableView setHidden:NO];
            [_noDataView setHidden:YES];
        }
    }
}

- (void)dealloc {
    [_tableView release];
    [_noDataView release];
    [super dealloc];
}

-(void)update {
    [self.tableView reloadData];
}
@end
