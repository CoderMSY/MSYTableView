//
//  MSYTableViewAdapter.m
//  XCData
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import "MSYTableViewAdapter.h"
#import "UIView+MSYKit.h"
#import "MSYCommonTableData.h"
#import "MSYTableViewCellProtocol.h"
#import "MSYTableViewHeaderFooterProtocol.h"
#import "MSYTableViewProtocol.h"

static NSUInteger const kTBCellSepLineTag = 10001;

static NSString *kDefaultTableCell = @"UITableViewCell";
static NSString *kDefaultTableHeaderFooterView = @"UITableViewHeaderFooterView";

@interface MSYTableViewAdapter ()

@property (nonatomic, weak) UIViewController *currentCtr;

@end

@implementation MSYTableViewAdapter

- (UITableViewCellStyle)tableViewCellStyle {
    if (!_tableViewCellStyle) {
        _tableViewCellStyle = UITableViewCellStyleValue1;
    }
    return _tableViewCellStyle;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultSeparatorLeftEdge = SepLineLeft;
        self.customSeparatorColor = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.adapterArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    return tableSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *tableSection = self.adapterArray[indexPath.section];
    MSYCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    NSString *identity = tableRow.cellClassName.length ? tableRow.cellClassName : kDefaultTableCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        Class clazz = NSClassFromString(identity);
        cell = [[clazz alloc] initWithStyle:self.tableViewCellStyle reuseIdentifier:identity];
        
        if (self.isShowCustomSeparator) {
            UIView *sep = [[UIView alloc] initWithFrame:CGRectZero];
            sep.tag = kTBCellSepLineTag;
            sep.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            sep.backgroundColor = self.customSeparatorColor;
            [cell addSubview:sep];
        }
    }
    if (![cell respondsToSelector:@selector(refreshData:tableView:)]) {
        UITableViewCell *defaultCell = (UITableViewCell *)cell;
        [self refreshData:tableRow cell:defaultCell];
    }else{
        [(id<MSYTableViewCellProtocol>)cell refreshData:tableRow tableView:tableView];
    }
    cell.accessoryType = tableRow.showAccessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *tableSection = self.adapterArray[indexPath.section];
    MSYCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    return tableRow.uiRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MSYCommonTableSection *tableSection = self.adapterArray[indexPath.section];
    MSYCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    if (!tableRow.forbidSelect) {
        UIViewController *ctr = tableView.msy_viewController;
        
        if ([ctr respondsToSelector:@selector(msy_tableView:didSelectRowAtIndexPath:)]) {
            [(id<MSYTableViewProtocol>)ctr msy_tableView:tableView didSelectRowAtIndexPath:indexPath];
        }
        else {
            NSLog(@"#####没有点击方法:第%ld组 第%ld行#####", (long)indexPath.section, (long)indexPath.row);
        }

    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isShowCustomSeparator) {
        return;
    }
    
    MSYCommonTableSection *tableSection = self.adapterArray[indexPath.section];
    MSYCommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    UIView *sep = [cell viewWithTag:kTBCellSepLineTag];
    CGFloat sepHeight = 0.25f;
    CGFloat sepWidth;
    if (tableRow.sepLeftEdge) {
        sepWidth  = cell.msy_width - tableRow.sepLeftEdge;
    } else {
        MSYCommonTableSection *section = self.adapterArray[indexPath.section];
        if (indexPath.row == section.rows.count - 1) {
            //最后一行
            sepWidth = 0;
        } else {
            sepWidth = cell.msy_width - self.defaultSeparatorLeftEdge;
        }
    }
    sepWidth  = sepWidth > 0 ? sepWidth : 0;
    sep.frame = CGRectMake(cell.msy_width - sepWidth, cell.msy_height - sepHeight, sepWidth, sepHeight);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    return tableSection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    
    return tableSection.headerHeight;
    
    /*
    if (section == 0) {
        return 25.f;
    }
    return [tableSection.headerTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]}].height;
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    
    return tableSection.footerHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    return tableSection.footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    if (tableSection.headerTitle.length) {
        return nil;
    }
    
    MSYCommonTableSection *sectionModel = self.adapterArray[section];
    NSString *headerId = sectionModel.headerClassName.length ? sectionModel.headerClassName : kDefaultTableHeaderFooterView;
    //参考上面的cell
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headerView) {
        Class clazz = NSClassFromString(headerId);
        headerView = [[clazz alloc] initWithReuseIdentifier:headerId];
    }
    if ([headerView respondsToSelector:@selector(refreshHeaderData:tableView:)]) {
        [(id<MSYTableViewHeaderFooterProtocol>)headerView refreshHeaderData:sectionModel.headerModel tableView:tableView];
    }
    
    return headerView;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    MSYCommonTableSection *tableSection = self.adapterArray[section];
    if (tableSection.footerTitle.length) {
        return nil;
    }
    
    MSYCommonTableSection *sectionModel = self.adapterArray[section];
    NSString *footerId = sectionModel.footerClassName.length ? sectionModel.footerClassName : kDefaultTableHeaderFooterView;
    //参考上面的cell
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerId];
    if (!footerView) {
        Class clazz = NSClassFromString(footerId);
        footerView = [[clazz alloc] initWithReuseIdentifier:footerId];
    }
    if ([footerView respondsToSelector:@selector(refreshFooterData:tableView:)]) {
        [(id<MSYTableViewHeaderFooterProtocol>)footerView refreshFooterData:sectionModel.headerModel tableView:tableView];
    }
    
    return footerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.currentCtr) {
        self.currentCtr = scrollView.msy_viewController;
    }
    
    if ([self.currentCtr respondsToSelector:@selector(msy_scrollViewDidScroll:)]) {
        [(id<MSYTableViewProtocol>)self.currentCtr msy_scrollViewDidScroll:scrollView];
    }
}

#pragma mark - Private
- (void)refreshData:(MSYCommonTableRow *)rowData cell:(UITableViewCell *)cell{
    cell.textLabel.text = rowData.title;
    cell.detailTextLabel.text = rowData.detailTitle;
}


@end
