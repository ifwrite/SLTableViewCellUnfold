//
//  ViewController.m
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "ViewController.h"
#import "SLFilterView.h"
#import "SLHeaderModel.h"
#import "SLSecondoryModel.h"

@interface ViewController ()<SLFilterViewDelegate>
@end

@implementation ViewController

#pragma mark -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - btn action
- (IBAction)showFilterView {
    
    SLFilterView *filterView = [[SLFilterView alloc] initWithDelegate:self];
    [filterView show];
    
    filterView.selectedFilterHandle = ^(NSArray *filterArray) {
        NSLog(@"Block Method");
        NSLog(@"filterArray: %@", filterArray);
    };
}

#pragma mark -
#pragma mark - SLFilterViewDelegate
- (void)filterView:(SLFilterView *)filterView didSelectFilter:(NSArray *)filterArray {
    NSLog(@"Delegate Method");
    NSLog(@"filterArray: %@", filterArray);
}

@end
