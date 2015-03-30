//
//  PointView.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-24.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "PointView.h"

#define PI 3.14159265853

@implementation PointView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    double radius = _radius;
    PointType type = _type;
    CGContextRef context = UIGraphicsGetCurrentContext();
    double red; //= 102.0 / 255.0;
    double green;
    double blue; //= 204.0 / 255.0;
    double lineRgb = 190.0 / 255.0;
    if (type == START) {
        red = 102.0 / 255.0;
        green = 204.0 / 255.0;
        blue = 0;
    } else if (type == NOW) {
        red = 239.0 / 255.0;
        green = 88.0 / 255.0;
        blue = 88.0 / 255.0;
    } else {
        red = 190.0 / 255.0;
        green = 190.0 / 255.0;
        blue = 190.0 / 255.0;
    }
    CGContextSetRGBFillColor(context, red, green, blue, 1.0);
    CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, radius, 0, 2 * PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    CGContextSetRGBStrokeColor(context, lineRgb, lineRgb, lineRgb, 1.0);
    CGPoint aPoints[2];                                                           //坐标点
    aPoints[0] = CGPointMake(rect.size.width / 2, 0);                             //坐标1
    aPoints[1] = CGPointMake(rect.size.width / 2, rect.size.height / 2 - radius); //坐标2
    CGPoint bPoints[2];
    bPoints[0] = CGPointMake(rect.size.width / 2, rect.size.height / 2 + radius); //坐标3
    bPoints[1] = CGPointMake(rect.size.width / 2, rect.size.height);              //坐标4
    if (type != NOW) {
        CGContextAddLines(context, aPoints, 2); //添加线
    }
    if (type != START) {
        CGContextAddLines(context, bPoints, 2); //添加线
    }
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
}

@end
