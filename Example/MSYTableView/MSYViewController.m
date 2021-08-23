//
//  MSYViewController.m
//  MSYTableView
//
//  Created by SimonMiao on 08/20/2021.
//  Copyright (c) 2021 SimonMiao. All rights reserved.
//

#import "MSYViewController.h"
#import <Masonry/Masonry.h>
#import <MSYTableView/MSYCommonTableView.h>
#import <MSYTableView/MSYCommonTableData.h>
#import <MSYTableView/MSYTableViewProtocol.h>

#import "MSYExampleViewController.h"

static NSString *const kTitle_system = @"系统自带cell";
static NSString *const kTitle_custom = @"自定义的cell";

@interface MSYViewController () <MSYTableViewProtocol>

@property (nonatomic, strong) MSYCommonTableView *homeView;

@end

@implementation MSYViewController

#pragma mark - lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.homeView];
    [self initConstraints];
    
    [self loadDataSource];
}

#pragma mark - public methods

#pragma mark - private methods

- (void)initConstraints {
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)loadDataSource {
    
    NSArray *historyList = @[kTitle_system, kTitle_custom];
    
    NSMutableArray *sectionDicArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *rowDicArr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString *text in historyList) {
        NSDictionary *rowDic = @{
            kRow_title : text ? : @"",
            kRow_detailTitle : @"",
            kRow_rowHeight : @(44),
            kRow_sepLeftEdge : @(100)
        };
        [rowDicArr addObject:rowDic];
    }
    
    NSDictionary *sectionDic = @{
        kSec_headerTitle : @"案例介绍",
        kSec_rowContent : rowDicArr,
    };
    [sectionDicArr addObject:sectionDic];
    
    NSArray *sections = [MSYCommonTableSection sectionsWithData:sectionDicArr];
    
    self.homeView.dataSource = sections;
}

#pragma mark - MSYTableViewProtocol

- (void)msy_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSYCommonTableSection *secionModel = self.homeView.dataSource[indexPath.section];
    MSYCommonTableRow *rowModel = secionModel.rows[indexPath.row];
    
    if ([rowModel.title isEqualToString:kTitle_system]) {
        MSYExampleViewController *ctr = [[MSYExampleViewController alloc] init];
        ctr.exampleType = MSYExampleType_system;
        
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if ([rowModel.title isEqualToString:kTitle_custom]) {
        MSYExampleViewController *ctr = [[MSYExampleViewController alloc] init];
        ctr.exampleType = MSYExampleType_custom;
        
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else {
        
    }
    
}

#pragma mark - getter && setter

- (MSYCommonTableView *)homeView {
    if (!_homeView) {
        _homeView = [[MSYCommonTableView alloc] initWithStyle:UITableViewStylePlain cellStyle:UITableViewCellStyleSubtitle];
        _homeView.isHideSystemSeparator = YES;//是否隐藏系统分离线
        _homeView.isShowCustomSeparator = YES;//是否显示自定义分离线
        _homeView.customSeparatorColor = [UIColor redColor];//自定义分离线颜色
    }
    return _homeView;
}

@end
