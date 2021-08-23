//
//  UIView+MSYKit.h
//  Regulatory
//
//  Created by SimonMiao on 2018/1/13.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MSYKit)

@property (nonatomic) CGFloat msy_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat msy_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat msy_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat msy_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat msy_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat msy_height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat msy_centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat msy_centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint msy_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize msy_size;

/** 找到自己的vc */
- (UIViewController *)msy_viewController;

/**
 获取父视图tableViewCell

 @return 父视图tableViewCell
 */
- (UITableViewCell *)msy_tableViewCell;

@end
