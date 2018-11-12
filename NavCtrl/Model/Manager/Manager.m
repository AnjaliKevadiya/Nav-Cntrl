//
//  Manager.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Manager.h"
#import "StockFetcher.h"

@interface Manager  () <StockFetcherDelegate>

@property(nonatomic,strong) StockFetcher *stockFetcher;

@end

@implementation Manager

+ (id) shareManager
{
    static Manager *myManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myManager = [[Manager alloc] init];
    });
    return myManager;
}

-(id)init
{
//    [super init];
    if (self = [super init]) {
    
       // _companyArr = [[NSMutableArray alloc] init];
        
        _stockFetcher = [[StockFetcher alloc] init];
        _stockFetcher.delegate = self;
        [self initModelContext];
        
        return self;
    }
    else return nil;
    
}

-(NSString *) archivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"storeCompany.data"];
}

-(void) initModelContext
{
    _model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_model];
    NSString *path = [self archivePath];
    NSURL *storeUrl = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        //        [NSException raise:@"Open failed" format:@"Reason %@",error.localizedDescription];
        NSLog(@"err %@",error.localizedDescription);
        
    }
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:psc];
    [psc release];
    
    NSUndoManager *undoManager = [[NSUndoManager alloc] init];
    [_context setUndoManager: undoManager];
    [undoManager release];
}

-(void) insertCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice
{
//    Company *comapany = [[Company alloc] init];
//    [comapany setComapnyFullName:companyFullName];
//    [comapany setCompanyShortName:companyShortName];
//    [comapany setComapnyImageUrl:companyUrl];
//    [comapany setStockPrice:stockPrice];
//    [comapany setProductArr:[[NSMutableArray alloc] init]];
//    [_companyArr addObject: comapany];
//    NSLog(@"_companyArr %@",_companyArr);
    
    ManageCompany *companyManaged = [NSEntityDescription insertNewObjectForEntityForName:@"ManageCompany" inManagedObjectContext:_context];
    [companyManaged setComapnyFullName:companyFullName];
    [companyManaged setCompanyShortName:companyShortName];
    [companyManaged setComapnyImageUrl:companyUrl];
    [companyManaged setStockPrice:stockPrice];
    [_companyArr addObject: companyManaged];
    NSLog(@"_companyArr %@",_companyArr);
    [self saveChanges];
}

-(void) updateCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice withCompanyObj:(ManageCompany *)companyObj
{
    [companyObj setComapnyFullName:companyFullName];
    [companyObj setCompanyShortName:companyShortName];
    [companyObj setComapnyImageUrl:companyUrl];
    [self saveChanges];
}

-(void) deleteCompany : (ManageCompany *)companyObj andCompanyIndex:(NSInteger)companyIndex {
    
    [_context deleteObject:companyObj];
    [_companyArr removeObjectAtIndex:companyIndex];
    [self saveChanges];

    if(self.updateDelegate){
        [self.updateDelegate update];
    }
}

-(NSMutableArray *)showAllCompanies
{
    NSFetchRequest *req = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDesc = [[_model entitiesByName] objectForKey:@"ManageCompany"];
    [req setEntity:entityDesc];
    
    
    NSError *err = nil;
    NSArray *result = [_context executeFetchRequest:req error:&err];
    
    [req release];
    
    if (!result) {
        //[NSException raise:@"Fetch Failed" format:@"Reason : %@",err.localizedDescription];
        NSLog(@"show exception %@",err.localizedDescription);
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"comapnyFullName" ascending:YES];
    
    if(_companyArr) {
        [_companyArr removeAllObjects];
        [_companyArr release];
    }
    
    _companyArr = [[NSMutableArray alloc] initWithArray:[result sortedArrayUsingDescriptors:@[sort]]];
    NSLog(@"_companyArr %p",_companyArr);
    
    return _companyArr;
}

-(void) insertProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andCompanyIndex:(NSInteger)companyIndex
{
//    Product *product = [[Product alloc] init];
//    [product setProductName:productName];
//    [product setProductUrl:productUrl];
//    [product setProductImageUrl:productImgUrl];
//    [product setCompanyIndex:companyIndex];
//
//    Company *company = [self.companyArr objectAtIndex:companyIndex];
//    [company.productArr addObject:product];
    
    ManageProduct *productManaged = [NSEntityDescription insertNewObjectForEntityForName:@"ManageProduct" inManagedObjectContext:_context];
    [productManaged setProductName:productName];
    [productManaged setProductUrl:productUrl];
    [productManaged setProductImageUrl:productImgUrl];
    [productManaged setCompanyIndex:companyIndex];
    
    ManageCompany *company = [self.companyArr objectAtIndex:companyIndex];
    [company addProductObject:productManaged];
    [self saveChanges];
}

-(void) updateProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andProductObj:(ManageProduct *)productObj
{
    [productObj setProductName:productName];
    [productObj setProductUrl:productUrl];
    [productObj setProductImageUrl:productImgUrl];
    [self saveChanges];
    
    /*Company *company = [self.companyArr objectAtIndex:companyIndex];

    NSInteger productIndex = [company.productArr indexOfObject: productObj];

    Product *product = [[Product alloc] init];
    [product setProductName:productName];
    [product setProductUrl:productUrl];
    [product setProductImageUrl:productImgUrl];

    [company.productArr replaceObjectAtIndex: productIndex withObject :product];*/
    
    /*NSMutableArray *results = [[NSMutableArray alloc] init];
    NSPredicate *predicate= [NSPredicate predicateWithFormat:@"productName CONTAINS[cd] %@",productName];
    NSLog(@"predicate %@",predicate);
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ManageProduct"];
    [fetchRequest setPredicate:predicate];
    results = [[_context executeFetchRequest:fetchRequest error:nil] mutableCopy];

    if (results.count > 0) {
        ManageProduct *productManaged = [results objectAtIndex:0];
        [productManaged setProductName:productName];
        [productManaged setProductUrl:productUrl];
        [productManaged setProductImageUrl:productImgUrl];
        [self saveChanges];
    }*/
}

-(void) deleteProduct : (ManageProduct *)productObj andCompanyIndex:(NSInteger)companyIndex {
    
    NSLog(@"product name: %@", productObj.productName);
    
    ManageCompany *company = [self.companyArr objectAtIndex:companyIndex];
    [company removeProductObject:productObj];
    [self saveChanges];
}

-(NSSet *)showAllProductsWithCompanyIndex : (NSInteger)companyIndex
{
    ManageCompany *company = [self.companyArr objectAtIndex:companyIndex];
    NSLog(@"productArr %@",company.product);
    return company.product;
}

-(void) fetchStockPrices {
    
    NSLog(@"_companyArr %@",_companyArr);
    
    NSMutableArray *companyIdentifierArr = [[[NSMutableArray alloc]init] autorelease];
    for (int i = 0; i < _companyArr.count; i++)
    {
        ManageCompany *company = [_companyArr objectAtIndex:i];
        [companyIdentifierArr addObject:company.companyShortName];
    }
    NSString *stringCon;
    if (companyIdentifierArr.count > 0) {
        
        if (companyIdentifierArr.count > 1) {
            stringCon = [companyIdentifierArr componentsJoinedByString:@","];
        }
        else
        {
            stringCon = [companyIdentifierArr componentsJoinedByString:@""];
        }
        NSLog(@"stringCon %@",stringCon);
        
        [_stockFetcher fetchStockPriceWithTicker:stringCon];
    }
}

- (void)stockFetchDidFailWithError:(NSError *)error {
    NSLog(@"Couldn't fetch stock price, this is a description of the error:%@", error.localizedDescription);
    //do some sort of error handling here
}

- (void)stockFetchDidStart {
    NSLog(@"Initiating stock fetch...");
    //could start an activity indicator here
}

- (void)stockFetchSuccessWithPriceString:(NSDictionary *)dicStock {
    NSLog(@"dicStock %@",dicStock);
    
    //replace _companyArr with _companyArrCD
    for (int i = 0; i < _companyArr.count; i++) {
        
        ManageCompany *company = [_companyArr objectAtIndex:i];
        if ([[dicStock allKeys] containsObject:company.companyShortName])
        {
            NSLog(@"array index %@",[dicStock objectForKey:company.companyShortName]);
            
            NSString *stockString = [NSString stringWithFormat:@"$%@",[dicStock objectForKey:company.companyShortName]];
            
            company.stockPrice = stockString;
        }
    }
    
    //[self saveChanges];
    
    if(self.updateDelegate){
        [self showAllCompanies];
        [self.updateDelegate update];
    }
}

-(void) saveChanges
{
    NSError *error = nil;
    BOOL successful = [_context save:&error];
    
    if (!successful) {
        NSLog(@"error saving %@",error.localizedDescription);
    }
    NSLog(@"Data is saved");
}

-(void)undoChanges
{
    [_context undo];
    [self saveChanges];

    if(self.updateDelegate){
        [self showAllCompanies];
        [self.updateDelegate update];
    }
}

-(void)redoChanges
{
    [_context redo];
    [self saveChanges];
    
    if(self.updateDelegate){
        [self showAllCompanies];
        [self.updateDelegate update];
    }
}

-(void)dealloc
{
    [_companyArr release];
    [_model release];
    [_context release];
    [_stockFetcher release];
    [_updateDelegate release];
    [super dealloc];
}
@end
