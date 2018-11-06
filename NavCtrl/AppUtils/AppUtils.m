//
//  AppUtils.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/31/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "AppUtils.h"

@implementation AppUtils

+(NSMutableArray *)getCompanyList
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"companyList"];
}

+(void)setCompanyList : (NSMutableArray *)companyArr
{
    [[NSUserDefaults standardUserDefaults] setObject:companyArr forKey:@"companyList"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
