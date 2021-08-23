//
//  MSYCommonTableData.m
//  XCData
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import "MSYCommonTableData.h"

#define DefaultUIRowHeight  50.f
#define DefaultUIHeaderHeight  33.f
#define DefaultUIFooterHeight  33.f

@implementation MSYCommonTableSection

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[kDisable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _headerTitle = dict[kSec_headerTitle];
        _footerTitle = dict[kSec_footerTitle];
        _footerHeight = [dict[kSec_footerHeight] floatValue];
        _headerHeight = [dict[kSec_headerHeight] floatValue];
        _headerHeight = _headerHeight ? _headerHeight : DefaultUIHeaderHeight;
        _footerHeight = _footerHeight ? _footerHeight : DefaultUIFooterHeight;
        _headerClassName = dict[kSec_headerClassName];
        _footerClassName = dict[kSec_footerClassName];
        _headerModel = dict[kSec_headerModel];
        _footerModel = dict[kSec_footerModel];
        
        _rows = [MSYCommonTableRow rowsWithData:dict[kSec_rowContent]];
    }
    return self;
}

+ (NSArray *)sectionsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            MSYCommonTableSection * section = [[MSYCommonTableSection alloc] initWithDict:dict];
            if (section) {
                [array addObject:section];
            }
        }
    }
    return array;
}


@end



@implementation MSYCommonTableRow

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[kDisable] boolValue]) {
        return nil;
    }
    self = [super init];
    if (self) {
        _title          = dict[kRow_title];
        _detailTitle    = dict[kRow_detailTitle];
        _cellClassName  = dict[kRow_cellClass];
        _uiRowHeight    = dict[kRow_rowHeight] ? [dict[kRow_rowHeight] floatValue] : DefaultUIRowHeight;
        _extraInfo      = dict[kRow_extraInfo];
        _sepLeftEdge    = [dict[kRow_sepLeftEdge] floatValue];
        _showAccessory  = [dict[kRow_accessory] boolValue];
        _forbidSelect   = [dict[kRow_forbidSelect] boolValue];
    }
    return self;
}

+ (NSArray *)rowsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            MSYCommonTableRow * row = [[MSYCommonTableRow alloc] initWithDict:dict];
            if (row) {
                [array addObject:row];
            }
        }
    }
    return array;
}


@end
