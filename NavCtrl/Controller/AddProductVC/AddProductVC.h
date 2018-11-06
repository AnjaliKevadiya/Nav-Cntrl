//
//  AddProductVC.h
//  NavCtrl
//
//  Created by Anjali Kevadiya on 11/1/18.
//  Copyright © 2018 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"

@interface AddProductVC : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *productNameTxt;
@property (retain, nonatomic) IBOutlet UITextField *productUrlTxt;
@property (retain, nonatomic) IBOutlet UITextField *productImgUrlTxt;

@property (nonatomic) NSInteger companyIndex;

@property (retain, nonatomic) IBOutlet UIView *nameView, *urlView, * imgUrlView;
@property (retain, nonatomic) Manager *managerObj;
@property (retain,nonatomic) Product *productObj;

@property(nonatomic) BOOL isFromEdit;

-(IBAction)onTapSave:(id)sender;
-(IBAction)onTapCancel:(id)sender;

@end
