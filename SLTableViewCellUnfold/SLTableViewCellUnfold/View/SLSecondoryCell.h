//
//  SLSecondoryCell.h
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLSecondoryModel.h"

@interface SLSecondoryCell : UITableViewCell

@property (strong, nonatomic) SLSecondoryModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
