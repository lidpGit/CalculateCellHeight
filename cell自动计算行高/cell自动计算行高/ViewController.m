//
//  ViewController.m
//  cell自动计算行高
//
//  Created by lidp on 2016/11/16.
//  Copyright © 2016年 lidp. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "TableHeaderView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

static NSString *const cell_identifier = @"cellID";
static NSString *const head_identifier = @"headerID";

@implementation ViewController{
    UITableView         *_tableView;
    NSMutableArray      *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    NSDictionary *section = @{@"sectionTitle":@"分区标题分区标题分区标题分区标题分区标题分区标题分区标题分区标题分区标题分区标题0",
                              @"list":@[@{@"text":@"自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,section 0",
                                          @"image":@"http://f.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=67440d2e0ed162d985bb6a1824ef85da/5366d0160924ab18f267a2dd31fae6cd7a890be2.jpg"
                                          }]
                              };
    [_dataSource addObject:section];
    
    section = @{@"sectionTitle":@"分区标题分区标题分区标题1",
                @"list":@[@{@"text":@"自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,section 2\n自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,自动计算cell高度,section 2",
                            @"image":@""}]
                };
    [_dataSource addObject:section];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [_tableView registerClass:TableViewCell.class forCellReuseIdentifier:cell_identifier];
    [_tableView registerClass:TableHeaderView.class forHeaderFooterViewReuseIdentifier:head_identifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ---------------------- UITableViewDelegate/UITableDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    cell.dict = _dataSource[indexPath.section][@"list"][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head_identifier];
    headerView.text = _dataSource[section][@"sectionTitle"];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dp_heightForCellWithIdentifier:cell_identifier configuration:^(id tempCell) {
        TableViewCell *cell = tempCell;
        cell.dict = _dataSource[indexPath.section][@"list"][indexPath.row];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [tableView dp_heightForHeaderFooterViewReuseIdentifier:head_identifier configuration:^(id tempHeaderFooterView) {
        TableHeaderView *headerView = tempHeaderFooterView;
        headerView.text = _dataSource[section][@"sectionTitle"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section][@"list"] count];
}

@end
