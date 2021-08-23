//
//  MSYTableViewAdapter.h
//  XCData
//
//  Created by SimonMiao on 2019/6/16.
//  Copyright © 2019 avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MSYCommonTableSection;
@interface MSYTableViewAdapter : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) UITableViewCellStyle tableViewCellStyle;

@property (nonatomic, strong) NSArray <MSYCommonTableSection *>*adapterArray;
/// Whether you need to display a custom separation line, default:NO
@property (nonatomic, assign) BOOL isShowCustomSeparator;
/// Custom separation line color, default:[UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *customSeparatorColor;
@property (nonatomic, assign) CGFloat defaultSeparatorLeftEdge;

@end

NS_ASSUME_NONNULL_END
