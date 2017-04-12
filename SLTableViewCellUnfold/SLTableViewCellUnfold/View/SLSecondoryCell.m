//
//  SLSecondoryCell.m
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "SLSecondoryCell.h"

@interface SLSecondoryCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *horizantalLineView;

@end

@implementation SLSecondoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SLSecondoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLSecondoryCell class])];
    if (!cell) {
        cell = [[SLSecondoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass([SLSecondoryCell class])];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.horizantalLineView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(20, 15, 100, 20);
    self.horizantalLineView.frame = CGRectMake(0, self.contentView.frame.size.height - 1, self.contentView.frame.size.width, 1);
}

- (void)setModel:(SLSecondoryModel *)model {
    _model = model;
    
    self.titleLabel.textColor = self.model.isSelected ? [UIColor greenColor] : [UIColor blackColor];
    self.titleLabel.text = self.model.title;
}

#pragma mark -
#pragma mark - lazy load
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)horizantalLineView {
    if (!_horizantalLineView) {
        _horizantalLineView = [[UIView alloc] init];
        _horizantalLineView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _horizantalLineView;
}

@end
