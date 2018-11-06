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


@protocol ManagerDelegate <NSObject>

-(void)update;

@end

@interface Manager : NSObject

@property (nonatomic,retain) NSMutableArray *companyArr, *companyArrCD;
@property (nonatomic,retain) NSManagedObjectContext *context;
@property (nonatomic,retain) NSManagedObjectModel *companyModel;

@property (nonatomic,retain) id<ManagerDelegate> updateDelegate;


+ (id) shareManager;

-(void) insertCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice andProducts:(Product *)products;

-(void) updateCompanyWithCompanyFullName : (NSString *)companyFullName andCompanyShortName : (NSString *)companyShortName andCompanyUrl : (NSString *)companyUrl andStockPrice : (NSString *)stockPrice andCompanyIndex : (NSInteger)companyIndex;

-(void) insertProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andCompanyIndex:(NSInteger)companyIndex;

-(void) updateProductWithProductName : (NSString *)productName andProductUrl : (NSString *)productUrl andProductImgUrl : (NSString *)productImgUrl andProductObj:(Product *)productObj andCompanyIndex:(NSInteger)companyIndex;

-(void) deleteProduct : (Product *)productObj andCompanyIndex:(NSInteger)companyIndex;

-(void) fetchStockPrices;

-(NSString *) archivePath;
-(void) initModelContext;


@end
