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

@interface MSYExampleViewController () <MSYExamplePresenterOutput, MSYCommonTableViewDelegate>

@property (nonatomic, strong) MSYCommonTableView *listView;
@property (nonatomic, strong) MSYExamplePresenter *presenter;

@property (nonatomic, strong) NSMutableArray *sectionArrs;

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
        case MSYExampleType_refresh:
        {
            self.listView.isNeedHeaderRefresh = YES;
            self.listView.isNeedFooterRefresh = YES;
            self.listView.delegate = self;
            
            [self.listView startHeaderRefreshingState];
        }
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

- (void)reqListDataWithPageIndex:(NSInteger)pageIndex
                        isHeader:(BOOL)isHeader {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (0 == pageIndex && self.sectionArrs.count > 0) {
            [self.sectionArrs removeAllObjects];
        }
        
        MSYCommonTableSection *sectionModel = [self.presenter fetchRefreshTypeDataWithPageIndex:pageIndex];
        BOOL isHadContent;
        if (sectionModel) {
            [self.sectionArrs addObject:sectionModel];
            self.listView.dataSource = self.sectionArrs;
            
            isHadContent = YES;
        }
        else {
            isHadContent = NO;
        }
        
        if (isHeader) {
            [self.listView stopHeaderRefreshingState];
        }
        else {
            [self.listView stopFooterRefreshingWithNoMoreDataIsHadContent:isHadContent];
        }
    });
}

#pragma mark - MSYExamplePresenterOutput

- (void)renderDataSource:(NSArray *)dataSource {
    self.listView.dataSource = dataSource;
}

#pragma mark - MSYCommonTableViewDelegate

- (void)commonTableView:(MSYCommonTableView *)commonView headerRefreshActionWithPage:(NSUInteger)pageIndex {
    NSLog(@"%s:%ld", __func__, pageIndex);
    [self reqListDataWithPageIndex:pageIndex isHeader:YES];
}

- (void)commonTableView:(MSYCommonTableView *)commonView footerRefreshActionWithPage:(NSUInteger)pageIndex {
    NSLog(@"%s:%ld", __func__, pageIndex);
    [self reqListDataWithPageIndex:pageIndex isHeader:NO];
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

- (NSMutableArray *)sectionArrs {
    if (!_sectionArrs) {
        _sectionArrs = [NSMutableArray arrayWithCapacity:0];
    }
    return _sectionArrs;
}

@end
