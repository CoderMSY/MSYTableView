//
//  MSYExamplePresenterIO.h
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MSYExamplePresenterInput <NSObject>

- (void)fetchSystemTypeDataSource;

- (void)fetchCustomTypeDataSource;

@end

@protocol MSYExamplePresenterOutput <NSObject>

- (void)renderDataSource:(NSArray *)dataSource;

@end

NS_ASSUME_NONNULL_END
