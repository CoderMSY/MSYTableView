//
//  MSYCommonTableView.h
//  OneCall
//
//  Created by SimonMiao on 2018/6/21.
//  Copyright © 2018年 avatar. All rights reserved.
//  通用的tableView

#import <UIKit/UIKit.h>

@class MSYCommonTableView;
@protocol MSYCommonTableViewDelegate <NSObject>

@optional
- (void)commonTableView:(MSYCommonTableView *)commonView headerRefreshActionWithPage:(NSUInteger)pageIndex;
- (void)commonTableView:(MSYCommonTableView *)commonView footerRefreshActionWithPage:(NSUInteger)pageIndex;

/// 注销第一响应者时间回调
/// @param commonView 当前的commonTableView
- (void)resignFirstResponderInCommonTableView:(MSYCommonTableView *)commonView;

@end

@interface MSYCommonTableView : UIView

@property (nonatomic, strong, readonly) UITableView *tableView;

@property (nonatomic, weak) id <MSYCommonTableViewDelegate>delegate;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) UIEdgeInsets edgeInset;
///是否隐藏系统分离线，默认为NO
@property (nonatomic, assign) BOOL isHideSystemSeparator;
///是否显示自定义分离线，默认为NO
@property (nonatomic, assign) BOOL isShowCustomSeparator;
/// 自定义分离线颜色
@property (nonatomic, strong) UIColor *customSeparatorColor;

@property (nonatomic, assign) BOOL isNeedHeaderRefresh;//!<是否需要头部刷新，默认NO
@property (nonatomic, assign) BOOL isNeedFooterRefresh;//!<是否需要尾部刷新，默认NO

/// 设置tableView是否可以滚动
@property (nonatomic, assign) bool isScrollEnabled;

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (instancetype)initWithCellStyle:(UITableViewCellStyle)cellStyle;
- (instancetype)initWithStyle:(UITableViewStyle)style
                    cellStyle:(UITableViewCellStyle)cellStyle;

/// 添加点击空白区域，关闭键盘手势
- (void)addHideKeyboardGesture;


/// 设置tableView 背景颜色
/// @param color 背景颜色
- (void)setTableViewBgColor:(UIColor *)color;

/**
 设置tableHeaderView

 @param tableHeaderView 对象
 */
- (void)setTableHeaderView:(UIView *)tableHeaderView;

/**
 设置tableFooterView

 @param tableFooterView 对象
 */
- (void)setTableFooterView:(UIView *)tableFooterView;

- (void)resignCommonTableViewFirstResponder;

/**
 开始头部刷新
 */
- (void)startHeaderRefreshingState;
/**
 停止头部刷新
 */
- (void)stopHeaderRefreshingState;

/**
 停止尾部刷新

 @param isHadContent 是否有内容（尾部刷新，如无内容，pageIndex减一）
 */
- (void)stopFooterRefreshingStateWithIsHadContent:(BOOL)isHadContent;

/// 结束尾部刷新并显示无更多内容
/// @param isHadContent 是否有数据
- (void)stopFooterRefreshingWithNoMoreDataIsHadContent:(BOOL)isHadContent;


/**
 根据tableView获取当前的cell所在的indexPath

 @param cell 当前cell
 @return indexPath
 */
- (NSIndexPath *)getIndexPathForCell:(UITableViewCell *)cell;


/**
 根据tableView获取当前的indexPath所在的cell

 @param indexPath 当前indexPath
 @return cell
 */
- (UITableViewCell *)getCurrentCellWithIndexPath:(NSIndexPath *)indexPath;

/**
 tableView插入行

 @param indexPaths NSIndexPath类型的数组
 */
- (void)insertRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;


/**
 tableView插入组

 @param indexSet NSIndexSet对象
 */
- (void)insertRowsInCommonViewAtIndexSet:(NSIndexSet *)indexSet;

/**
 tableView删除行
 
 @param indexPaths NSIndexPath类型的数组
 */
- (void)deleteRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 刷新tableView指定行

 @param indexPaths NSIndexPath类型的数组
 */
- (void)reloadRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

/**
 刷新tableView指定组
 
 @param indexSet NSIndexSet对象
 */
- (void)reloadSectionsInCommonViewAtIndexSet:(NSIndexSet *)indexSet;
/**
 滚动到指定行

 @param indexPath NSIndexPath对象
 */
- (void)scrollToRowInCommonViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 滚动的tableView的底部
 */
- (void)scrollTableViewBottomInCommonView;

@end
