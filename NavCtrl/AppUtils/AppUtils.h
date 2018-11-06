//
//  AppUtils.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/31/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtils : NSObject

+(NSMutableArray *)getCompanyList;
+(void)setCompanyList : (NSMutableArray *)companyArr;

@end
