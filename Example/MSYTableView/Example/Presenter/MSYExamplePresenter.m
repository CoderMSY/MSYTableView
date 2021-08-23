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

@end
