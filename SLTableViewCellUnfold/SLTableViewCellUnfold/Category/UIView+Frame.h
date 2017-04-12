//
//  UIView+Frame.h
//  FBLWoodmall
//
//  Created by emir on 2017/2/17.
//  Copyright © 2016年 Emir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGSize size;

@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@end

