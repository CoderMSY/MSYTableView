//
//  MSYTableViewProtocol.h
//  XCData
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYTableViewProtocol <NSObject>

@optional
- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)msy_scrollViewDidScroll:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
