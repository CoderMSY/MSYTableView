//
//  MSYBaseTableViewHeaderFooterView.h
//  OneCall
//
//  Created by SimonMiao on 2018/7/14.
//  Copyright © 2018年 avatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSYTableViewHeaderFooterProtocol.h"

@interface MSYBaseTableViewHeaderFooterView : UITableViewHeaderFooterView <MSYTableViewHeaderFooterProtocol>

+ (NSString *)headerFooterReuseId;

+ (CGFloat)getHeaderFooterHeight;

@end
