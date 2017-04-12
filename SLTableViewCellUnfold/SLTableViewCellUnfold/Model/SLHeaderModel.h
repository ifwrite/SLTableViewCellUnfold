//
//  SLHeaderModel.h
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLHeaderModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *content;
@property (assign, nonatomic) BOOL isOpen;
@property (strong, nonatomic) NSMutableArray *secondoryModels;

@end
