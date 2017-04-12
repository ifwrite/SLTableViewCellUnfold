//
//  SLHeaderView.h
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLHeaderModel.h"

typedef void(^tapHandle)(void);

@interface SLHeaderView : UIView

@property (strong, nonatomic) SLHeaderModel *model;

@property (copy, nonatomic) tapHandle tapHandle;

@end
