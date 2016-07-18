//
//  ViewController.m
//  LRLayerSuperposition
//
//  Created by 卢然 on 16/7/17.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import "ViewController.h"
#import "LREffectCell.h"

#define LRCellHeight 150

#define LRLastCellHeight 230

#define LRGetImage(row) [UIImage imageNamed:[NSString stringWithFormat:@"%zd",row]]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, weak)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
}


//创建tableView
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    UIImageView *imagView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bak"]];
    imagView.contentMode = UIViewContentModeScaleAspectFill;
    tableView.backgroundView = imagView;
    tableView.contentInset = UIEdgeInsetsMake(LRLastCellHeight - LRCellHeight, 0, tableView.frame.size.height-LRLastCellHeight, 0);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
}

#pragma mark -<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LREffectCell * effectCell = [LREffectCell cellFromTableView:tableView];
    
    return effectCell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LREffectCell * effectCell = (LREffectCell *)cell;
    
    effectCell.backGImage.image = LRGetImage(indexPath.row);
    
    //初始化 -> 调用第一次滚动
    [effectCell cellOffsetOnTabelView:_tableView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LRCellHeight;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // [_tableView visibleCells]：获取表视图的可见单元格。(可见的视图)
    //遍历
    [[_tableView visibleCells] enumerateObjectsUsingBlock:^(LREffectCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //cell偏移设置
        [obj cellOffsetOnTabelView:_tableView];

    }];
    
}


@end

