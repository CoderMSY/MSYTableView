//
//  MSYExamplePresenter.m
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import "MSYExamplePresenter.h"
#import <MSYTableView/MSYCommonTableData.h>
#import "MSYExampleCustomCell.h"
#import "MSYExampleCustomModel.h"

@implementation MSYExamplePresenter

#pragma mark - MSYExamplePresenterInput

- (void)fetchSystemTypeDataSource {
    NSMutableArray *sectionDicArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rowDicArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < 10; i ++) {
        NSString *title = [NSString stringWithFormat:@"text:%ld", (long)i];
        NSDictionary *rowDic = @{
            kRow_title : title ? : @"",
            kRow_detailTitle : @"",
            kRow_rowHeight : @(44),
        };
        [rowDicArr addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_headerTitle : @"案例介绍",
        kSec_rowContent : rowDicArr,
    };
    [sectionDicArr addObject:sectionDic];
    
    NSArray *sections = [MSYCommonTableSection sectionsWithData:sectionDicArr];
    
    [self.output renderDataSource:sections];
}

- (void)fetchCustomTypeDataSource {
    NSMutableArray *sectionDicArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rowDicArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i < 10; i ++) {
        NSString *title = [NSString stringWithFormat:@"text:%ld", (long)i];
        MSYExampleCustomModel *model = [[MSYExampleCustomModel alloc] init];
        model.title = title;
        model.detail = @"自定义cell";
        NSDictionary *rowDic = @{
            kRow_extraInfo : model,
            kRow_rowHeight : @(60),
            kRow_cellClass : NSStringFromClass([MSYExampleCustomCell class])
        };
        [rowDicArr addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_headerTitle : @"自定义介绍",
        kSec_rowContent : rowDicArr,
    };
    [sectionDicArr addObject:sectionDic];
    
    NSArray *sections = [MSYCommonTableSection sectionsWithData:sectionDicArr];
    
    [self.output renderDataSource:sections];
}

- (MSYCommonTableSection *)fetchRefreshTypeDataWithPageIndex:(NSInteger)pageIndex {
    if (3 == pageIndex) {
        return nil;
    }
    
    NSMutableArray *rowDicArr = [NSMutableArray arrayWithCapacity:0];
    for (NSInteger i = 0; i < 10; i ++) {
        NSString *title = [NSString stringWithFormat:@"text:%ld", (long)i];
        NSDictionary *rowDic = @{
            kRow_title : title ? : @"",
            kRow_detailTitle : @"",
            kRow_rowHeight : @(44),
        };
        [rowDicArr addObject:rowDic];
    }
    
    NSString *headerTitle = [NSString stringWithFormat:@"第%ld页", (long)pageIndex];
    NSMutableDictionary *sectionDic = [NSMutableDictionary dictionaryWithDictionary:@{
        kSec_headerTitle : headerTitle,
        kSec_rowContent : rowDicArr,
        kSec_footerHeight : @(kSectionHeaderHeight_zero),
    }];
//    if (isHeader) {
//        sectionDic[kSec_headerTitle] = @"上拉下拉刷新案例";
//        sectionDic[kSec_headerHeight] = @(33);
//    }
//    else {
//        sectionDic[kSec_headerHeight] = @(kSectionHeaderHeight_zero);
//    }
    
    MSYCommonTableSection *sectionModel = [[MSYCommonTableSection alloc] initWithDict:sectionDic];
    
    return sectionModel;
}

@end
