//
//  Manager.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"
#import "AppUtils.h"
#import <CoreData/CoreData.h>
//#import "ManagedCompany.h"
//#import "ManagedProduct.h"

#import "ManageCompany+CoreDataClass.h"
#import "ManageProduct+CoreDataClass.h"

@protocol ManagerDelegate <NSObject>

-(void)update;

@end

@interface Manager : NSObject

@property (nonatomic,retain) NSMutableArray *companyArr;
@property (nonatomic,retain) NSManagedObjectContext *context;
@property (nonatomic,retain) NSManagedObjectModel *model;

@property (nonatomic,retain) id<ManagerDelegate> updateDelegate;


+ (id) shareManager;

-(void) insertCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice;

-(void) updateCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice withCompanyObj:(ManageCompany *)companyObj;

-(void) deleteCompany : (ManageCompany *)companyObj andCompanyIndex:(NSInteger)companyIndex;

    
-(void) insertProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andCompanyIndex:(NSInteger)companyIndex;

-(void) updateProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andProductObj:(ManageProduct *)productObj;

-(void) deleteProduct : (ManageProduct *)productObj andCompanyIndex:(NSInteger)companyIndex;


-(void) fetchStockPrices;

-(NSString *) archivePath;
-(void) initModelContext;

-(NSMutableArray *)showAllCompanies;
-(NSSet *)showAllProductsWithCompanyIndex : (NSInteger)companyIndex;


-(void)undoChanges;
-(void)redoChanges;

@end
