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
    if (self == [super init]) {
       
        _companyArr = [[NSMutableArray alloc] init];
        _companyArrCD = [[NSMutableArray alloc] init];
        
        _stockFetcher = [[StockFetcher alloc] init];
        _stockFetcher.delegate = self;
        [self initModelContext];
    }
    return self;
}

-(void) insertCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice andProducts:(Product *)products
{
    Company *comapany = [[Company alloc] init];
    [comapany setComapnyFullName:companyFullName];
    [comapany setCompanyShortName:companyShortName];
    [comapany setComapnyImageUrl:companyUrl];
    [comapany setStockPrice:stockPrice];
    [comapany setProductArr:[[NSMutableArray alloc] init]];
    [_companyArr addObject: comapany];
    NSLog(@"_companyArr %@",_companyArr);
    
    
    Company *companyCoreData = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:_context];
    [companyCoreData setComapnyFullName:companyFullName];
    [companyCoreData setCompanyShortName:companyShortName];
    [companyCoreData setComapnyImageUrl:companyUrl];
    [companyCoreData setStockPrice:stockPrice];
    [companyCoreData setProductArr:[[NSMutableArray alloc] init]];
    [self saveChanges];
    [_companyArrCD addObject: companyCoreData];
    NSLog(@"_companyArrCD %@",_companyArrCD);

}

-(void) updateCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice andCompanyIndex : (NSInteger)companyIndex
{
    Company *comapany = [self.companyArr objectAtIndex:companyIndex];
    [comapany setComapnyFullName:companyFullName];
    [comapany setCompanyShortName:companyShortName];
    [comapany setComapnyImageUrl:companyUrl];
    [comapany setStockPrice:stockPrice];
    //[comapany setProductArr:[[NSMutableArray alloc] init]];
    
    [_companyArr replaceObjectAtIndex:companyIndex withObject:comapany];
    NSLog(@"_companyArr %@",_companyArr);
}

-(void) insertProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andCompanyIndex:(NSInteger)companyIndex
{
    Product *product = [[Product alloc] init];
    [product setProductName:productName];
    [product setProductUrl:productUrl];
    [product setProductImageUrl:productImgUrl];
    [product setCompanyIndex:companyIndex];
    
    Company *company = [self.companyArr objectAtIndex:companyIndex];
    [company.productArr addObject:product];
}

-(void) updateProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andProductObj:(Product *)productObj andCompanyIndex:(NSInteger)companyIndex
{
    Company *company = [self.companyArr objectAtIndex:companyIndex];

    NSInteger productIndex = [company.productArr indexOfObject: productObj];

    Product *product = [[Product alloc] init];
    [product setProductName:productName];
    [product setProductUrl:productUrl];
    [product setProductImageUrl:productImgUrl];
    
    [company.productArr replaceObjectAtIndex: productIndex withObject :product];
}

-(void) deleteProduct : (Product *)productObj andCompanyIndex:(NSInteger)companyIndex {
    
    Company *company = [self.companyArr objectAtIndex:companyIndex];
    [company.productArr removeObject:productObj];
}

-(void) fetchStockPrices {
    
    NSLog(@"_companyArr %@",_companyArr);
    
    NSMutableArray *_companyIdentifierArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < _companyArr.count; i++)
    {
        Company *company = [_companyArr objectAtIndex:i];
        [_companyIdentifierArr addObject:company.companyShortName];
    }
    NSString *stringCon;
    if (_companyIdentifierArr.count > 0) {
        
        if (_companyIdentifierArr.count > 1) {
            stringCon = [_companyIdentifierArr componentsJoinedByString:@","];
        }
        else
        {
            stringCon = [_companyIdentifierArr componentsJoinedByString:@""];
        }
        NSLog(@"stringCon %@",stringCon);
        [self.stockFetcher fetchStockPriceWithTicker:stringCon];
    }
}

-(NSString *) archivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"storeCompany.data"];
}

-(void) initModelContext
{
    _companyModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_companyModel];
    NSString *path = [self archivePath];
    NSURL *storeUrl = [NSURL fileURLWithPath:path];
    NSError *error = nil;

    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        //[NSException raise:@"Open failed" format:@"Reason %@",error.localizedDescription];
        NSLog(@"err %@",error.localizedDescription);
        
    }
    _context = [[NSManagedObjectContext alloc] init];
    [_context setPersistentStoreCoordinator:psc];
    [_context setUndoManager:nil];
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
    
    
    for (int i = 0; i < _companyArr.count; i++) {
        
        Company *company = [_companyArr objectAtIndex:i];
        if ([[dicStock allKeys] containsObject:company.companyShortName])
        {
            NSLog(@"array index %@",[dicStock objectForKey:company.companyShortName]);
            
            NSString *stockString = [NSString stringWithFormat:@"$%@",[dicStock objectForKey:company.companyShortName]];
            
            company.stockPrice = stockString;
        }
    }
    
    if(self.updateDelegate){
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

-(void)showAllCompanies
{
    if (!_companyArr) {

        NSFetchRequest *req = [[NSFetchRequest alloc] init];
        NSEntityDescription *entityDesc = [[_companyModel entitiesByName] objectForKey:@"Company"];
        [req setEntity:entityDesc];
        
        NSError *err = nil;
        NSArray *result = [_context executeFetchRequest:req error:&err];
        
        if (!result) {
            [NSException raise:@"Fetch Failed" format:@"Reason : %@",err.localizedDescription];
        }
        _companyArrCD = [[NSMutableArray alloc] initWithArray:result];
        NSLog(@"companyArrCD %@",_companyArrCD);
    }
}
@end
