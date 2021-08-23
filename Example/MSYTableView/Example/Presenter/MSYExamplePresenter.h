//
//  MSYExamplePresenter.h
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSYExamplePresenterIO.h"

NS_ASSUME_NONNULL_BEGIN

@interface MSYExamplePresenter : NSObject <MSYExamplePresenterInput>

@property (nonatomic, weak) id <MSYExamplePresenterOutput>output;

@end

NS_ASSUME_NONNULL_END
