//
//  TagFeedsViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/17.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#define NUMBER 20

#import "TagFeedsViewController.h"

@interface TagFeedsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    NSInteger _page;
    NSInteger _count;
}


@end

@implementation TagFeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _page = 0;
    _dataArray = [NSMutableArray array];
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    
    [self registCell];
    
    [self addRefresh];
    
    [self loadData];
}

#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"FeedCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"CountCell" bundle:nil];
    [self.tv registerNib:nib2 forCellReuseIdentifier:@"CountCell"];
}

#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        [self loadData];
        [self.tv.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"快松手 要刷新啦" forState:MJRefreshStateRefreshing];
    
    self.tv.header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadData];
        [self.tv.footer endRefreshing];
    }];
    self.tv.footer = footer;
}


#pragma mark - 下载数据
- (void)loadData{
    NSString *url = [NSString stringWithFormat:FIND_TAG_FEEDS, self.ID, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        NSDictionary *dict = data[@"data"];
        
        self.tagLabel.text = dict[@"name"];
        
        NSNumber *countNum = dict[@"count"];
        [_dataArray addObject:countNum.stringValue];
        
        NSArray *feedsArray = dict[@"feeds"];
        for (NSDictionary *dict1 in feedsArray) {
            NSDictionary *feedDict = dict1[@"feed"];
            FeedModel *model = [[FeedModel alloc] initWithDictionary:feedDict error:nil];
            model.hasFollowed = dict1[@"hasFollowed"];
            //model.likers = dict1[@"likes"];
            
            [_dataArray addObject:model];
        }
        
        [self.tv reloadData];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        CountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountCell"];
        if (_dataArray.count == 0) {
            cell.coutLabel.text = nil;
        }else {
            NSString *countStr = _dataArray[0];
            cell.coutLabel.text = [NSString stringWithFormat:@"%@%@", countStr, @"个瞬间"];
        }
        return cell;
    }else {
        
        FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        FeedModel *model = _dataArray[indexPath.row];
        [cell setModel:model];
        return cell;
    }
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 50;
    }else {
        
        FeedModel *model = _dataArray[indexPath.row];
        NSString *str = model.addonTitles;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return size.height + 520;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)addClick:(id)sender {
}
@end