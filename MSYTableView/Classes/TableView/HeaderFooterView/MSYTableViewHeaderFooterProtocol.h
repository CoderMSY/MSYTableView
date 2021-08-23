//
//  MSYTableViewHeaderFooterProtocol.h
//  Regulatory
//
//  Created by SimonMiao on 2018/2/11.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSYTableViewHeaderFooterProtocol <NSObject>

@optional
- (void)refreshHeaderData:(id)headerData tableView:(UITableView *)tableView;
- (void)refreshFooterData:(id)footerData tableView:(UITableView *)tableView;

@end
