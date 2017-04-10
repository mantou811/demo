//
//  NDDefaultSearchViewController.m
//  NDSearchTool
//
//  Created by NDMAC on 16/2/22.
//  Copyright © 2016年 NDEducation. All rights reserved.
//

#import "NDDefaultSearchViewController.h"

#import "NDSearchStockModel.h"
#import "NDSearchTool.h"

@interface NDDefaultSearchViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
#pragma clang diagnostic pop
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *searchDataSource;

@end

@implementation NDDefaultSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建搜索条
    self.tableView.tableHeaderView = self.searchBar;
}

#pragma mark - delegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableView == tableView) {
        return self.dataSource.count;
    }
    
    return self.searchDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    NDSearchStockModel *model;
    if (self.tableView == tableView) {
        model = self.dataSource[indexPath.row];
    } else {
        model = self.searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.code];
    
    return cell;
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    搜索得到的数组数据
    self.searchDataSource = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"name",@"pingyin",@"code"]
                                                                            inputString:searchText
                                                                                inArray:self.dataSource];
    //   刷新tableview，此时tableview不在是原来的tableview类型，而是searchResultsTableView类型
    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - getter and setter

- (NSMutableArray *)dataSource
{
    if (_dataSource) {
        return _dataSource;
    }
    
    _dataSource = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stockList" ofType:@"plist"];
    NSArray *fileArray = [NSArray arrayWithContentsOfFile:path];
//    转为模型数组
    for (NSDictionary *dict in fileArray) {
        NDSearchStockModel *model = [[NDSearchStockModel alloc] init];
        model.name = dict[@"name"];
        model.pingyin = dict[@"pingyin"];
        model.code = dict[@"code"];
        [_dataSource addObject:model];
    }
    
    return _dataSource;
}

- (UISearchBar *)searchBar
{
    if (_searchBar) {
        return _searchBar;
    }
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    _searchBar.placeholder = @"您可以通过股票名称，简拼或代码进行查询";
    _searchBar.delegate = self;
    
    return _searchBar;
}

- (UISearchDisplayController *)searchDisplayController
{
    if (_searchDisplayController) {
        return _searchDisplayController;
    }
//    给搜索条配置搜索控制器，并绑定到当前控制器self
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//    数据源和代理设置
    _searchDisplayController.searchResultsTableView.dataSource = self;
    _searchDisplayController.searchResultsTableView.delegate = self;
    
    return _searchDisplayController;
}
@end
