//
//  XIU_SearchBarViewController.m
//  XIU_SearchBarDemo
//
//  Created by XIUDeveloper on 2017/1/19.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#define SIZE_MAGRIN_ITEM 12



#import "XIU_SearchBarViewController.h"
#import "XIU_SearchBarCell.h"
#import "Masonry.h"
#import "SearchBarModel.h"

@interface XIU_SearchBarViewController ()<UITableViewDelegate, UITableViewDataSource, SearchBarCellDelegate>

@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, weak)UISearchBar *searchBar;

@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation XIU_SearchBarViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 30; i++) {
            SearchBarModel *model = [[SearchBarModel alloc] init];
            
            model.title = [NSString stringWithFormat:@"dfdfdf"];
            if (i == 3) {
                model.title = @"jjohj;ohjohjohjjopihjhoioohiphoihohio;lhgfdsdfghjkdxsdfghjppppppppppppp";
            }if (i == 2) {
                model.title = @"12344jdsfdsdghjkgfgfdjgkdfghfjgkjfhdgfhfjgkhjfgdhfghjgkhgfgdhfgfjgkjfgdhfgdhjghfhfgjfjsdjf5";
            }

            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

-(UITableView *)XIUTableView {
    if (!_XIUTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _XIUTableView = tableView;
    }
    return _XIUTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self XIUTableView];
    [self createNavgationSearchBar];
    [self createChanelButton];
}

- (void)createChanelButton {
    UIButton *chanel = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 30, 20)];
    [chanel setTitle:@"取消" forState:UIControlStateNormal];
    chanel.titleLabel.font = [UIFont systemFontOfSize:14];
    [chanel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chanel addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:chanel];
    self.navigationItem.rightBarButtonItem = item;

}

- (void)createNavgationSearchBar {
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 140, 30)];
    searchBarView.backgroundColor  =[UIColor whiteColor];
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:searchBarView.frame];
    [searchBarView addSubview:search];
    search.placeholder = @"123";
    self.navigationItem.titleView = searchBarView;
    search.translatesAutoresizingMaskIntoConstraints = NO;
    search.backgroundImage = [UIImage imageNamed:@"clearImage"];
    search.returnKeyType = UIReturnKeySearch;
    [search becomeFirstResponder];
    _searchBar = search;
    
}

#pragma mark tableView---Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
      [self.searchBar resignFirstResponder];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self setHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XIU_SearchBarCell *cell = [[XIU_SearchBarCell alloc] initWithStyle:1 reuseIdentifier:@"cell" AndDataArray:self.dataSource];
    cell.XIUDelegate = self;
    if (!cell) {
        cell  =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        
    }
        return cell;
}
- (void)searchBarCell:(SearchBarModel *)model {
    NSLog(@"网络请求，开始搜索关键字");
    [self.searchBar resignFirstResponder];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelDidClick {
    NSLog(@"回跳");
}

- (CGFloat)setHeight {
    CGFloat x = 0,  y = 60 , margin = 18,total=0;
    x = margin;
    for(int i=0;i<self.dataSource.count;i++){
        
        NSString *str = [self.dataSource[i] title];
        
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13.f]};
        CGSize size=[str sizeWithAttributes:attrs];
        size.width > [UIScreen mainScreen].bounds.size.width ? size.width = [UIScreen mainScreen].bounds.size.width - 2 * margin - 2 * SIZE_MAGRIN_ITEM : size.width;
        x = margin+total;
        total += size.width+16+margin;
        if (total>[UIScreen mainScreen].bounds.size.width) {
            total = 0;
            y+=40;
            x = margin+total;
            total += size.width + SIZE_MAGRIN_ITEM + margin;
        }
    }
    return y + 30;

}
@end



