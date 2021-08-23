//
//  MSYExampleViewController.m
//  MSYTableView_Example
//
//  Created by Simon Miao on 2021/8/23.
//  Copyright © 2021 SimonMiao. All rights reserved.
//

#import "MSYExampleViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>

#import "MSYExamplePresenter.h"

@interface MSYExampleViewController () <MSYExamplePresenterOutput>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYExamplePresenter *presenter;

@end

@implementation MSYExampleViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.listView];
    [self initConstraints];
    
    switch (self.exampleType) {
        case MSYExampleType_system:
            [self.presenter fetchSystemTypeDataSource];
            break;
        case MSYExampleType_custom:
            [self.presenter fetchCustomTypeDataSource];
            break;
        default:
            break;
    }
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - MSYExamplePresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - getter && setter

- (MSYCommonTableView *)listView {
    if (!_listView) {
        _listView = [[MSYCommonTableView alloc] initWithStyle:UITableViewStyleGrouped];
    }
    return _listView;
}

- (MSYExamplePresenter *)presenter {
    if (!_presenter) {
        _presenter = [[MSYExamplePresenter alloc] init];
        _presenter.output = self;
    }
    return _presenter;
}


@end
