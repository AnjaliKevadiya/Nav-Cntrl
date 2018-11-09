//
//  Product.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

+(id) sharedProduct
{
    static Product *myProduct = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myProduct = [[Product alloc] init];
    });
    return myProduct;
}

-(void)dealloc
{
    [_productName release];
    [_productUrl release];
    [_productImageUrl release];
    [super dealloc];
}

@end
