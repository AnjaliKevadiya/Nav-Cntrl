//
//  StockFetcher.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/5/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavControllerAppDelegate.h"
#import "iToast.h"

@protocol StockFetcherDelegate <NSObject>

-(void)stockFetchSuccessWithPriceString : (NSDictionary *) dicStock;

-(void)stockFetchDidFailWithError : (NSError *) error;
-(void)stockFetchDidStart;

@end

@interface StockFetcher : NSObject

@property (strong, nonatomic) id<StockFetcherDelegate> delegate;

-(void)fetchStockPriceWithTicker : (NSString *)ticker;

@end
