//
//  Company.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Company : NSManagedObject

@property (nonatomic,retain) NSString *comapnyFullName;
@property (nonatomic,retain) NSString *companyShortName;
@property (nonatomic,retain) NSString *comapnyImageUrl;
@property (nonatomic,retain) NSString *stockPrice;

@property(nonatomic,retain) NSMutableArray *productArr;

+(id)sharedCompany;

@end
