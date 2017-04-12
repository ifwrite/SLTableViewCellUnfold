//
//  SLFilterView.h
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLFilterView;

@protocol SLFilterViewDelegate <NSObject>

- (void)filterView:(SLFilterView *)filterView didSelectFilter:(NSArray *)filterArray;

@end

typedef void(^selectedFilterHandle)(NSArray *filterArray);

@interface SLFilterView : UIView

- (instancetype)initWithDelegate:(id<SLFilterViewDelegate>)delegate;

- (void)show;

- (void)dismiss;

@property (weak, nonatomic) id<SLFilterViewDelegate> delegate;

@property (copy, nonatomic) selectedFilterHandle selectedFilterHandle ;

@end
