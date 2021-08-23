//
//  MSYBaseTableViewCell.h
//  
//
//  Created by SimonMiao on 2017/9/21.
//  Copyright © 2017年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSYTableViewCellProtocol.h"

@interface MSYBaseTableViewCell : UITableViewCell <MSYTableViewCellProtocol>

/// 复用id，类名的字符串
+ (NSString *)cellReuseId;

//默认为44.0，自定义请在子类重写该方法
+ (CGFloat)getCellHeight;

@end
