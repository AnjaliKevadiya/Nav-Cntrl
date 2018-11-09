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
    [_undoRedoView setHidden:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:60 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.manager fetchStockPrices];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _companyArr = [_manager showAllCompanies]; //_manager.companyArr;
      NSLog(@"_companyArr %p",_companyArr);

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

-(IBAction)onTapRedo:(id)sender
{
    [_manager redoChanges];
}

-(IBAction)onTapUndo:(id)sender
{
    [_manager undoChanges];
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
//    if (_isUndoRedoShow == YES)
//    {
//        [_undoRedoView setHidden:YES];
//        _isUndoRedoShow = NO;
//    }
//    else
//    {
//        [_undoRedoView setHidden:NO];
//        _isUndoRedoShow = YES;
//    }

    return YES;
    
    
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        NSLog(@"_companyArr %p",_companyArr);
        _company = [_companyArr objectAtIndex:indexPath.row];
        
        AddCompanyVC *addComapnyVC = [[AddCompanyVC alloc] initWithNibName:@"AddCompanyVC" bundle:nil];
        addComapnyVC.company = _company;
        addComapnyVC.isFromEdit = YES;
        [self presentViewController:addComapnyVC animated:YES completion:^{
            
        }];
    }];
    editAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        NSLog(@"_companyArr %p",_companyArr);
        _company = [_companyArr objectAtIndex:indexPath.row];
        [_manager deleteCompany:_company andCompanyIndex:indexPath.row];
        
        [_undoRedoView setHidden:NO];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//         NSLog(@"_companyArr %p",_companyArr);
//        _company = [_companyArr objectAtIndex:indexPath.row];
//        [_manager deleteCompany:_company andCompanyIndex:indexPath.row];
//    }
//}


- (void)dealloc {
    
    [_tableView release];
    [_noDataView release];
    [_undoRedoView release];
    [_manager release];
    [_company release];
    [_productListVC release];
    [_companyArr release];
    [super dealloc];
}

-(void)update {
    self.companyArr = self.manager.companyArr;
    [self.tableView reloadData];
}
@end
