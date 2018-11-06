//
//  Product.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"

@interface Product : NSObject

@property (nonatomic,retain) NSString *productName;
@property (nonatomic,retain) NSString *productUrl;
@property (nonatomic,retain) NSString *productImageUrl;
@property (nonatomic) NSInteger companyIndex;

+(id) sharedProduct;

@end
