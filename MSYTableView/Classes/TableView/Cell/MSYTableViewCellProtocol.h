//
//  MSYTableViewCellProtocol.h
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MSYCommonTableRow;

@protocol MSYTableViewCellProtocol <NSObject>

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@optional
- (void)refreshData:(MSYCommonTableRow *)rowData tableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
