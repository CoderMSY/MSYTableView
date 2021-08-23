//
//  MSYExampleCustomCell.m
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import "MSYExampleCustomCell.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYExampleCustomModel.h"

@interface MSYExampleCustomCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;

@end

@implementation MSYExampleCustomCell

#pragma mark - lifecycle methods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailLab];
        
        [self initConstraints];
    }
    return self;
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(15);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.titleLab.mas_trailing).offset(20);
        make.trailing.mas_lessThanOrEqualTo(self.contentView).offset(-15);
    }];
}

#pragma mark - MSYTableViewCellProtocol

- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView {
    if ([rowData.extraInfo isKindOfClass:[MSYExampleCustomModel class]]) {
        MSYExampleCustomModel *model = (MSYExampleCustomModel *)rowData.extraInfo;
        self.titleLab.text = model.title;
        self.detailLab.text = model.detail;
    }
}

#pragma mark - getter && setter

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
    }
    return _titleLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [[UILabel alloc] init];
    }
    return _detailLab;
}

@end
