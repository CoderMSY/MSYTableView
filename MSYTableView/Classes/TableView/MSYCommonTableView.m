//
//  MSYCommonTableView.m
//  OneCall
//
//  Created by SimonMiao on 2018/6/21.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import "MSYCommonTableView.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>

#import "MSYTableViewAdapter.h"
#import "MSYCommonTableData.h"

static NSUInteger const kTable_firstPageIndex = 0;

@interface MSYCommonTableView ()
{
    NSUInteger _pageIndex;
}
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong) MSYTableViewAdapter *adapter;

@end

@implementation MSYCommonTableView

//@synthesize dataSource = _dataSource;

#pragma mark - lifecycle methods

- (instancetype)init {
    self = [self initWithCellStyle:UITableViewCellStyleValue1];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [self initWithStyle:style cellStyle:UITableViewCellStyleDefault];
    
    return self;
}

- (instancetype)initWithCellStyle:(UITableViewCellStyle)cellStyle {
    self = [self initWithStyle:UITableViewStyleGrouped cellStyle:cellStyle];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
                    cellStyle:(UITableViewCellStyle)cellStyle {
    self = [super init];
    if (self) {
        _pageIndex = kTable_firstPageIndex;
        self.tableViewStyle = style;
        self.adapter.tableViewCellStyle = cellStyle;
        [self addSubview:self.tableView];
        self.tableView.delegate = self.adapter;
        self.tableView.dataSource = self.adapter;
        
        [self initConstraints];
        
        if (@available(iOS 15.0, *)) {
            self.tableView.sectionHeaderTopPadding = 0;
        }
    }
    return self;
}


#pragma mark - public methods

- (void)addHideKeyboardGesture {
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}

- (void)hideKeyboard {
    [self.tableView endEditing:YES];
    
    if ([self.delegate respondsToSelector:@selector(resignFirstResponderInCommonTableView:)]) {
        [self.delegate resignFirstResponderInCommonTableView:self];
    }
}

- (void)setTableViewBgColor:(UIColor *)color {
    if (!color) {
        return;
    }
    self.tableView.backgroundColor = color;
}

- (void)setTableHeaderView:(UIView *)tableHeaderView {
    self.tableView.tableHeaderView = tableHeaderView;
}

- (void)setTableFooterView:(UIView *)tableFooterView {
    self.tableView.tableFooterView = tableFooterView;
}
- (void)setEdgeInset:(UIEdgeInsets)edgeInset
{
    _edgeInset = edgeInset;
    self.tableView.contentInset = edgeInset;
    self.tableView.mj_header.ignoredScrollViewContentInsetTop = edgeInset.top;
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = edgeInset.bottom;
}

- (void)setIsHideSystemSeparator:(BOOL)isHideSystemSeparator {
    _isHideSystemSeparator = isHideSystemSeparator;
    
    self.tableView.separatorStyle = isHideSystemSeparator ? UITableViewCellSeparatorStyleNone : UITableViewCellSeparatorStyleSingleLine;
}

- (void)setIsShowCustomSeparator:(BOOL)isShowCustomSeparator {
    _isShowCustomSeparator = isShowCustomSeparator;
    
    self.adapter.isShowCustomSeparator = isShowCustomSeparator;
}

- (void)setCustomSeparatorColor:(UIColor *)customSeparatorColor {
    if (!customSeparatorColor) {
        return;
    }
    _customSeparatorColor = customSeparatorColor;
    self.adapter.customSeparatorColor = customSeparatorColor;
}

- (void)setIsNeedHeaderRefresh:(BOOL)isNeedHeaderRefresh {
    _isNeedHeaderRefresh = isNeedHeaderRefresh;
    
    if (isNeedHeaderRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction)];
    }
}

- (void)setIsNeedFooterRefresh:(BOOL)isNeedFooterRefresh {
    _isNeedFooterRefresh = isNeedFooterRefresh;
    
    if (isNeedFooterRefresh) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction)];
        if (@available(iOS 11.0, *)) {
            CGFloat safeBottom = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
            self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = safeBottom;
        }
    }
}

- (void)setIsScrollEnabled:(bool)isScrollEnabled {
    _isScrollEnabled = isScrollEnabled;
    self.tableView.scrollEnabled = isScrollEnabled;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    self.adapter.adapterArray = dataSource;
    [self.tableView reloadData];
}

//- (NSArray *)dataSource {
//    return self.adapter.adapterArray;
//}

- (void)resignCommonTableViewFirstResponder {
    [self hideKeyboard];
}

- (void)startHeaderRefreshingState {
    [self.tableView.mj_header beginRefreshing];
}

- (void)stopHeaderRefreshingState {
    [self.tableView.mj_header endRefreshing];
}

- (void)stopFooterRefreshingStateWithIsHadContent:(BOOL)isHadContent {
    [self.tableView.mj_footer endRefreshing];
    if (!isHadContent) {
        if (_pageIndex > kTable_firstPageIndex) {
            _pageIndex --;//没有刷新到数据，应减1
        }
    }
}

- (void)stopFooterRefreshingWithNoMoreDataIsHadContent:(BOOL)isHadContent {
    if (!isHadContent) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
        if (_pageIndex > kTable_firstPageIndex) {
            _pageIndex --;//没有刷新到数据，应减1
        }
    }
    else {
        [self.tableView.mj_footer endRefreshing];
    }
}

- (NSIndexPath *)getIndexPathForCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    return indexPath;
}

- (UITableViewCell *)getCurrentCellWithIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)insertRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!indexPaths.count) {
        return;
    }
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[indexPaths copy] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)insertRowsInCommonViewAtIndexSet:(NSIndexSet *)indexSet {
    if (!indexSet) {
        return;
    }
    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)deleteRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (!indexPaths.count) {
        return;
    }
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:[indexPaths copy] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (void)reloadRowsInCommonViewAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)reloadSectionsInCommonViewAtIndexSet:(NSIndexSet *)indexSet {
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

- (void)scrollToRowInCommonViewAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)scrollTableViewBottomInCommonView {
    BOOL animated = YES;
    NSInteger section = self.adapter.adapterArray.count > 1 ? self.adapter.adapterArray.count - 1 : 0;
    NSInteger rows = [self.tableView numberOfRowsInSection:section];
    if (rows > 0) {
        dispatch_block_t scrollBottomBlock = ^ {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:section]
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:animated];
        };
        if (animated) {
            //when use `estimatedRowHeight` and `scrollToRowAtIndexPath` at the same time, there are some issue.
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                scrollBottomBlock();
            });
        } else {
            scrollBottomBlock();
        }
        
    }
}

#pragma mark - private methods

- (void)initConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)headerRefreshAction {
    _pageIndex = kTable_firstPageIndex;
    [self.tableView.mj_footer resetNoMoreData];
    if ([_delegate respondsToSelector:@selector(commonTableView:headerRefreshActionWithPage:)] ) {
        [_delegate commonTableView:self headerRefreshActionWithPage:_pageIndex];
    }
}

- (void)footerRefreshAction {
    _pageIndex ++;
    if ([_delegate respondsToSelector:@selector(commonTableView:footerRefreshActionWithPage:)]) {
        [_delegate commonTableView:self footerRefreshActionWithPage:_pageIndex];
    }
}

#pragma mark - getter && setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.tableViewStyle];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (MSYTableViewAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[MSYTableViewAdapter alloc] init];
    }
    return _adapter;
}

@end
