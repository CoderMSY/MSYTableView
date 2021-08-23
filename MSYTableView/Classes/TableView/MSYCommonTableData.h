//
//  MSYCommonTableData.h
//  XCData
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SepLineLeft 15 //分割线距左边距离
//在iOS9上，如果headerHeight设置为0，API就会默认系统高度
static CGFloat const kSectionHeaderHeight_zero = 0.00001f;

//section key
static NSString *const kSec_headerTitle  = @"headerTitle";
static NSString *const kSec_footerTitle  = @"footerTitle";
static NSString *const kSec_headerHeight = @"headerHeight";
static NSString *const kSec_footerHeight = @"footerHeight";
static NSString *const kSec_headerClassName = @"headerClassName";
static NSString *const kSec_footerClassName = @"footerClassName";
static NSString *const kSec_headerModel = @"headerModel";
static NSString *const kSec_footerModel = @"footerModel";
static NSString *const kSec_rowContent   = @"row";

//row key
static NSString *const kRow_title        = @"title";
static NSString *const kRow_detailTitle  = @"detailTitle";
static NSString *const kRow_cellClass    = @"cellClass";
static NSString *const kRow_extraInfo    = @"extraInfo";
static NSString *const kRow_rowHeight    = @"rowHeight";
static NSString *const kRow_sepLeftEdge  = @"leftEdge";  //分离线距离左边的间距
static NSString *const kRow_forbidSelect = @"forbidSelect"; //cell不响应select事件


//common key
static NSString *const kDisable       = @"disable";      //cell不可见
static NSString *const kRow_accessory    = @"accessory";    //cell显示>箭头


@interface MSYCommonTableSection : NSObject

@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, copy) NSString *headerClassName;//头部视图的类名
@property (nonatomic, copy) NSString *footerClassName;//尾部视图的类名
@property (nonatomic, strong) id headerModel; //SectionHeader原始模型
@property (nonatomic, strong) id footerModel; //SectionFooter原始模型

@property (nonatomic, strong)   NSArray  *rows;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)sectionsWithData:(NSArray *)data;

@end

@interface MSYCommonTableRow : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) NSString *detailTitle;

@property (nonatomic, copy) NSString *cellClassName;

@property (nonatomic, assign) CGFloat  uiRowHeight;

@property (nonatomic, assign) CGFloat  sepLeftEdge;

@property (nonatomic, assign) BOOL     showAccessory;

@property (nonatomic, assign) BOOL     forbidSelect;

@property (nonatomic, strong) id extraInfo;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)rowsWithData:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
