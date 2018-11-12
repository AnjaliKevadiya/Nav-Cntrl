//
//  StockFetcher.m
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/5/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import "StockFetcher.h"

@implementation StockFetcher

-(void)fetchStockPriceWithTicker : (NSString *)ticker
{
    if ([NavControllerAppDelegate isNetworkRechability] == NO)
    {
        [[[iToast makeText:@"No Internet Connection! Please try again!!"] setDuration:iToastDurationShort] show];
    }
    else
    {
        NSString *apiKey = [NSString stringWithFormat:@"%@",@"OmJkMzc2YjliZTEyYjI0MTZlMjk4NjAxODZmYjE3ZWVh"];
        
        NSString *urlString = [NSString stringWithFormat:@"https://api.intrinio.com/data_point?identifier=%@&item=close_price&api_key=%@", ticker,apiKey];
        
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                                   
                                   NSArray *arr;
                                   if (dic[@"data"])
                                   {
                                       arr = [dic objectForKey:@"data"];
                                   }
                                   else
                                   {
                                       arr = @[dic];
                                   }
                                   NSLog(@"arr %@",arr);
                                   
                                   NSMutableDictionary *dicStock = [[NSMutableDictionary alloc] init] ;
                                   
                                   for (int i = 0; i < arr.count; i++) {
                                       
                                       [dicStock setValue:[[arr objectAtIndex:i] objectForKey:@"value"] forKey:[[arr objectAtIndex:i] objectForKey:@"identifier"]];
                                       NSLog(@"dicStock %@",dicStock);
                                   }
                                   [self.delegate stockFetchSuccessWithPriceString:dicStock];
                                   
                                   [dicStock release];
                                   
                               }];
    }
}

/*-(void)fetchStockPriceWithTicker : (NSString *)ticker
{
    if ([NavControllerAppDelegate isNetworkRechability] == NO)
    {
        [[[iToast makeText:@"No Internet Connection! Please try again!!"] setDuration:iToastDurationShort] show];
    }
    else
    {
        //responds to selector is necessary for optional methods in our delegate protocol "StockFetcherDelegate", if our delegate does not implement them and we try to call them.. the app will crash
        
        if ([self.delegate respondsToSelector:@selector(stockFetchDidStart)]) {
            [self.delegate stockFetchDidStart];
        }
        
        //ticker = [NSString stringWithFormat:@"%@,%@",@"GOOGL",@"AAPL"];
        NSString *apiKey = [NSString stringWithFormat:@"%@",@"OmJkMzc2YjliZTEyYjI0MTZlMjk4NjAxODZmYjE3ZWVh"];
        
        NSString *urlString = [NSString stringWithFormat:@"https://api.intrinio.com/data_point?identifier=%@&item=close_price&api_key=%@", ticker,apiKey];
        
        //    NSString *urlString = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=a", ticker];
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                if ([self.delegate respondsToSelector:@selector(stockFetchDidFailWithError:)]) {
                    
                    //we are not on the main queue at this point so it is important to dispatch blocks
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //communicate with the delegate that we have failed and give it the error object for further handling
                        [self.delegate stockFetchDidFailWithError:error];
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    
                    NSArray *arr;
                    if (dic[@"data"])
                    {
                        arr = [dic objectForKey:@"data"];
                    }
                    else
                    {
                        arr = @[dic];
                    }
                    //NSLog(@"arr %@",arr);
                    
                    NSMutableDictionary *dicStock = [[NSMutableDictionary alloc] init];
                    
                    for (int i = 0; i < arr.count; i++) {
                        
                        [dicStock setValue:[[arr objectAtIndex:i] objectForKey:@"value"] forKey:[[arr objectAtIndex:i] objectForKey:@"identifier"]];
                        //NSLog(@"dicStock %@",dicStock);
                    }
                    [self.delegate stockFetchSuccessWithPriceString:dicStock];
                });
            }
        }];
        [task resume];
    }
}*/

-(void)dealloc
{
    [_delegate release];
    [super dealloc];
}
@end
