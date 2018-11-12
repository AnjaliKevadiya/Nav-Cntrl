//
//  Manager.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
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

-(NSString *) archivePath;
-(void) initModelContext;

#pragma mark ADD, UPDATE, DELETE, SHOW Companies
-(void) insertCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice;

-(void) updateCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice withCompanyObj:(ManageCompany *)companyObj;

-(void) deleteCompany : (ManageCompany *)companyObj andCompanyIndex:(NSInteger)companyIndex;

-(NSMutableArray *)showAllCompanies;


#pragma mark ADD, UPDATE, DELETE, SHOW Products
-(void) insertProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andCompanyIndex:(NSInteger)companyIndex;

-(void) updateProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andProductObj:(ManageProduct *)productObj;

-(void) deleteProduct : (ManageProduct *)productObj andCompanyIndex:(NSInteger)companyIndex;

-(NSSet *)showAllProductsWithCompanyIndex : (NSInteger)companyIndex;


#pragma mark Fetch Stock Price
-(void) fetchStockPrices;


#pragma mark Undo & Redo
-(void)undoChanges;
-(void)redoChanges;

@end
