//
//  SLHeaderView.m
//  SLTableViewCellUnfold
//
//  Created by emir on 2017/4/12.
//  Copyright © 2017年 swifterfit. All rights reserved.
//

#import "SLHeaderView.h"

@interface SLHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *seperatorLineView;

@end

@implementation SLHeaderView

#pragma mark -
#pragma mark - life cycle
-  (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark -
#pragma mark - setter
- (void)setModel:(SLHeaderModel *)model {
    _model = model;
    
    self.titleLabel.text = self.model.title;
    self.contentLabel.text = self.model.content ? self.model.content : @"";
    
    self.arrowImageView.image = self.model.isOpen ? [UIImage imageNamed:@"arrow-up"] : [UIImage imageNamed:@"arrow-down"];
}

#pragma mark -
#pragma mark - action
- (void)tapAction {
    self.model.isOpen = !self.model.isOpen;
    
    if (self.tapHandle) {
        self.tapHandle();
    }
}
@end
