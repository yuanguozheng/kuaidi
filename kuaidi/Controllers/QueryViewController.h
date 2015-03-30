//
//  QueryViewController.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-17.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CompleteKuaidiInfoEntity.h"

@interface QueryViewController
    : UIViewController <UITextFieldDelegate, MBProgressHUDDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic) BOOL isLoaded;
@property(nonatomic, strong) CompleteKuaidiInfoEntity *allInfo;
@property(nonatomic, strong) MBProgressHUD *mbHUD;
@property(nonatomic, strong) UILabel *companyLabel;
@property(nonatomic, strong) UITableView *infoTable;
@property(nonatomic, strong) UITextField *numField;

@end
