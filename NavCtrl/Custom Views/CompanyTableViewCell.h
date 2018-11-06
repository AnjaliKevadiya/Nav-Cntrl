//
//  CompanyTableViewCell.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/31/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyTableViewCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIImageView *imgView;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblStockPrice;

@end
