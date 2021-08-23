//
//  MSYExampleViewController.h
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MSYExampleType) {
    MSYExampleType_system,
    MSYExampleType_custom,
};

@interface MSYExampleViewController : UIViewController

@property (nonatomic, assign) MSYExampleType exampleType;

@end

NS_ASSUME_NONNULL_END
