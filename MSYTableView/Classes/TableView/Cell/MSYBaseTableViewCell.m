//
//  MSYBaseTableViewCell.m
//
//  Created by SimonMiao on 2017/9/21.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import "MSYBaseTableViewCell.h"

@implementation MSYBaseTableViewCell

+ (NSString *)cellReuseId {
    return NSStringFromClass([self class]);
}

+ (CGFloat)getCellHeight {
    return 44.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
