//
//  StockFetcher.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/5/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockFetcherDelegate.h"
#import "NavControllerAppDelegate.h"
#import "iToast.h"

@interface StockFetcher : NSObject

@property (strong, nonatomic) id<StockFetcherDelegate> delegate;

-(void)fetchStockPriceWithTicker : (NSString *)ticker;

@end
