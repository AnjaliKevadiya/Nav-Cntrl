//
//  StockFetcherDelegate.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/5/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StockFetcherDelegate <NSObject>

-(void)stockFetchSuccessWithPriceString : (NSDictionary *) dicStock;

-(void)stockFetchDidFailWithError : (NSError *) error;
-(void)stockFetchDidStart;

@end
