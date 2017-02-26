//
//  XIU_SearchBarViewController.m
//  XIU_SearchBarDemo
//
//  Created by XIUDeveloper on 2017/1/19.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#define SIZE_MAGRIN_ITEM 12
static NSInteger historySearchCount = 10;


#import "XIU_SearchBarViewController.h"
#import "XIU_SearchBarCell.h"
#import "XIU_SearchShoppingListViewController.h"


@interface XIU_SearchBarViewController ()<UITableViewDelegate, UITableViewDataSource, SearchBarCellDelegate, UISearchBarDelegate>

@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, weak)UISearchBar *searchBar;

@property (nonatomic, strong)NSMutableArray *dataSource;
@end

@implementation XIU_SearchBarViewController

- (NSMutableArray *)dataSource {
        
        return  [[NSUserDefaults standardUserDefaults]objectForKey:history_search];

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
    
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(DeleteAllHistorySearch:) name:@"DeleteAllHistorySearchNotification" object:nil];
    
    [self XIUTableView];
    [self createNavgationSearchBar];
    [self createChanelButton];
}


- (void)DeleteAllHistorySearch:(NSNotification *)notificaton {
    [self.XIUTableView reloadData];
}
- (void)createChanelButton {
    
    [self createNavgationButtonWithImageNmae:nil title:@"取消" target:self action:@selector(cancelDidClick) type:UINavigationItem_Type_RightItem];
}

- (void)createNavgationSearchBar {
    
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 140, 30)];
    searchBarView.backgroundColor  =[UIColor whiteColor];

    UISearchBar *search = [[UISearchBar alloc] init];
    search.delegate = self;
    [searchBarView addSubview:search];
    search.placeholder = @"123";
    self.navigationItem.titleView = searchBarView;
    search.translatesAutoresizingMaskIntoConstraints = NO;
    search.backgroundImage = [UIImage imageNamed:@"clearImage"];
    search.returnKeyType = UIReturnKeySearch;
    [search becomeFirstResponder];
    
    [search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(searchBarView).with.insets(UIEdgeInsetsMake(0, 0,0,0));
    }];
    _searchBar = search;
    
}

#pragma mark tableView---Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
      [self.searchBar resignFirstResponder];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self setHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    XIU_SearchBarCell *cell = [[XIU_SearchBarCell alloc] initWithStyle:1 reuseIdentifier:XIU_SearchBarIdentifier AndDataArray:self.dataSource];
    cell.XIUDelegate = self;
    if (!cell) {
        cell  =[tableView dequeueReusableCellWithIdentifier:XIU_SearchBarIdentifier];
        
    }
        return cell;
}
- (void)searchBarCellWithKeyword:(NSString *)keyword {
    [self pustSearchShoppingListViewControllerWithKeyword:keyword];
}

- (void)pustSearchShoppingListViewControllerWithKeyword:(NSString *)keyword {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:XIU_SearchShoppingListID bundle:nil];
    XIU_SearchShoppingListViewController *deliverAddress= [mainStoryBoard instantiateViewControllerWithIdentifier:XIU_SearchShoppingListID];
    [self.navigationController pushViewController:deliverAddress animated:YES];
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
        
        NSString *str = self.dataSource[i];
        
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


#pragma mark searchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSMutableArray *arr= [NSMutableArray arrayWithObject:searchBar.text];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:history_search]) {
        [[NSUserDefaults standardUserDefaults]setObject:arr forKey:history_search];
    }else {
        
        [arr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:history_search]];
        arr.count > historySearchCount ? [arr removeLastObject] : arr;
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:history_search];
    }
    [self pustSearchShoppingListViewControllerWithKeyword:@""];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end



