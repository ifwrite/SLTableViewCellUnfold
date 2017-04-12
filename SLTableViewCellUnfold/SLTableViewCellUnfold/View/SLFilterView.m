//
//  SLFilterView.m
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "SLFilterView.h"
#import "SLHeaderView.h"
#import "SLSecondoryCell.h"
#import "SLHeaderModel.h"
#import "SLSecondoryModel.h"
#import <YYModel.h>
#import "UIView+Frame.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kKeyWindow [UIApplication sharedApplication].delegate.window

@interface SLFilterView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *verticalLineView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *resetBtn;
@property (strong, nonatomic) UIButton *enterBtn;

@property (strong, nonatomic) NSMutableArray *models;

@end

@implementation SLFilterView

#pragma mark -
#pragma mark - life cycle
- (instancetype)initWithDelegate:(id<SLFilterViewDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        
        self.frame = kScreenBounds;
        
        NSArray* arr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"]];
        
        for (NSDictionary *dict in arr) {
            SLHeaderModel *model = [SLHeaderModel yy_modelWithDictionary:dict];
            
            [self.models addObject:model];
        }
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        
        [self addSubview:self.containerView];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backBtn.x = 10;
    self.backBtn.y = 30;
    [self.backBtn sizeToFit];
    
    self.verticalLineView.x = 0;
    self.verticalLineView.width = self.containerView.width;
    self.verticalLineView.y = 64;
    self.verticalLineView.height = 1;
    
    self.titleLabel.centerX = self.verticalLineView.centerX;
    self.titleLabel.centerY = self.backBtn.centerY;
    [self.titleLabel sizeToFit];
    
    self.tableView.x = 0;
    self.tableView.y = CGRectGetMaxY(self.verticalLineView.frame);
    self.tableView.width = self.containerView.width;
    self.tableView.height = self.containerView.height - 50;
    
    self.resetBtn.x = 0;
    self.resetBtn.width = self.containerView.width * 0.5;
    self.resetBtn.height = 50;
    self.resetBtn.y = self.containerView.height - 50;
    
    self.enterBtn.x = self.containerView.width * 0.5;
    self.enterBtn.y = self.resetBtn.y;
    self.enterBtn.size = CGSizeMake(self.containerView.width * 0.5, 50);
}

#pragma mark -
#pragma mark - public methods
- (void)show {
    [kKeyWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformMakeTranslation(-315, 0);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.containerView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark - actions
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    for (UITouch *touch in touches) {
        if (!CGRectContainsPoint(self.containerView.frame, [touch locationInView:self])) {
            [self dismiss];
        }
    }
}

- (void)resetAction {
    [self.models removeAllObjects];
    NSArray* arr=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"]];
    
    for (NSDictionary *dict in arr) {
        SLHeaderModel *model = [SLHeaderModel yy_modelWithDictionary:dict];
        
        [self.models addObject:model];
    }
    [self.tableView reloadData];
}

- (void)doneAction {
    NSMutableArray *arr = [NSMutableArray array];
    [self.models enumerateObjectsUsingBlock:^(SLHeaderModel  *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:model.content];
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterView:didSelectFilter:)]) {
        [self.delegate filterView:self didSelectFilter:arr];
    }
    
    if (self.selectedFilterHandle) {
        self.selectedFilterHandle(arr);
    }
    
    [self dismiss];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SLHeaderModel *model = self.models[section];
    if (model.isOpen) {
        return model.secondoryModels.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLSecondoryCell *cell = [SLSecondoryCell cellWithTableView:tableView];
    
    SLHeaderModel *model = self.models[indexPath.section];
    SLSecondoryModel *secondLevelModel = model.secondoryModels[indexPath.row];
    
    cell.model = secondLevelModel;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SLHeaderModel *model = self.models[section];
    
    SLHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SLHeaderView class]) owner:self options:nil] lastObject];
    headerView.model = model;
    
    headerView.tapHandle = ^{
        [tableView reloadData];
    };
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SLHeaderModel *model = self.models[indexPath.section];
    SLSecondoryModel *secondLevelModel = model.secondoryModels[indexPath.row];
    
    if (!secondLevelModel.isSelected) {
        [model.secondoryModels enumerateObjectsUsingBlock:^(SLSecondoryModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = obj.isSelected ? NO : obj.isSelected;
        }];
    }
    
    secondLevelModel.isSelected = !secondLevelModel.isSelected;
    model.content = secondLevelModel.isSelected ? secondLevelModel.title : @"";
    
    [tableView reloadData];
}

#pragma mark -
#pragma mark - lazy load
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, 315, kScreenHeight)];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        [_containerView addSubview:self.backBtn];
        [_containerView addSubview:self.titleLabel];
        [_containerView addSubview:self.verticalLineView];
        [_containerView addSubview:self.tableView];
        [_containerView addSubview:self.resetBtn];
        [_containerView addSubview:self.enterBtn];
    }
    
    return _containerView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"筛选";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_titleLabel sizeToFit];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc] init];
        _verticalLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalLineView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        [_tableView registerClass:[SLSecondoryCell class] forCellReuseIdentifier:NSStringFromClass([SLSecondoryCell class])];
    }
    return _tableView;
}

- (UIButton *)resetBtn {
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] init];
        _resetBtn.backgroundColor = [UIColor yellowColor];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _resetBtn;
}

- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc] init];
        _enterBtn.backgroundColor = [UIColor yellowColor];
        [_enterBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_enterBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _enterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_enterBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}

- (NSMutableArray *)models {
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
@end
