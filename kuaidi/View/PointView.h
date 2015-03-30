//
//  PointView.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-24.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PointView : UIView

typedef enum PointType { NOW, PASS, START } PointType;

@property(nonatomic) double radius;
@property(nonatomic) PointType type;

@end
