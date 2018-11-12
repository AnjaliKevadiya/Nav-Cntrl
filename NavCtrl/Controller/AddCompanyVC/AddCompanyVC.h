//
//  AddCompanyVC.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 10/30/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

@interface AddCompanyVC : UIViewController <UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *companyFullnameTxt;
@property (retain, nonatomic) IBOutlet UITextField *companyShortnameTxt;
@property (retain, nonatomic) IBOutlet UITextField *companyImgUrlTxt;
@property (retain, nonatomic) IBOutlet UIView *fullnameView, *shortnameView, *imgUrlView, *mainView;
@property (retain, nonatomic) IBOutlet UILabel *lblTitle;

@property (retain, nonatomic) Manager *managerObj;

@property(nonatomic, retain) NSString *stockPriceStr;
@property(nonatomic, retain) ManageCompany *company;
@property (nonatomic) BOOL isFromEdit;

-(IBAction)onTapSave:(id)sender;
-(IBAction)onTapCancel:(id)sender;

@end
