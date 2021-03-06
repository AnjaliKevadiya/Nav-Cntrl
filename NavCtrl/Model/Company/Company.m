//
//  Company.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

+(id)sharedCompany
{
    static Company *myCompany = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myCompany = [[Company alloc] init];
    });
    return myCompany;
}

@end
