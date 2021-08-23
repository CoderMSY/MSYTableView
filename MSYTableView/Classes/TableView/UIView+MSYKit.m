//
//  UIView+MSYKit.m
//  Regulatory
//
//  Created by SimonMiao on 2018/1/13.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#import "UIView+MSYKit.h"

@implementation UIView (MSYKit)

- (CGFloat)msy_left {
    return self.frame.origin.x;
}

///
- (void)setMsy_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

///
- (CGFloat)msy_top {
    return self.frame.origin.y;
}

///
- (void)setMsy_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

///
- (CGFloat)msy_right {
    return self.frame.origin.x + self.frame.size.width;
}

///
- (void)setMsy_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

///
- (CGFloat)msy_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

///
- (void)setMsy_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

///
- (CGFloat)msy_centerX {
    return self.center.x;
}

///
- (void)setMsy_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

///
- (CGFloat)msy_centerY {
    return self.center.y;
}


///
- (void)setMsy_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///
- (CGFloat)msy_width {
    return self.frame.size.width;
}


///
- (void)setMsy_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///
- (CGFloat)msy_height {
    return self.frame.size.height;
}


///
- (void)setMsy_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
///
- (CGPoint)msy_origin {
    return self.frame.origin;
}


///
- (void)setMsy_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)msy_size {
    return self.frame.size;
}

- (void)setMsy_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (UIViewController *)msy_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UITableViewCell *)msy_tableViewCell {
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell*)nextResponder;
        }
    }
    return nil;
}

@end
