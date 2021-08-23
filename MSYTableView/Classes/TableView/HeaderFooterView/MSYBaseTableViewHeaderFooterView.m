//
//  MSYBaseTableViewHeaderFooterView.m
//  OneCall
//
//  Created by SimonMiao on 2018/7/14.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import "MSYBaseTableViewHeaderFooterView.h"

@implementation MSYBaseTableViewHeaderFooterView

+ (NSString *)headerFooterReuseId {
    return NSStringFromClass([self class]);
}

+ (CGFloat)getHeaderFooterHeight {
    return 33.0;
}

@end
