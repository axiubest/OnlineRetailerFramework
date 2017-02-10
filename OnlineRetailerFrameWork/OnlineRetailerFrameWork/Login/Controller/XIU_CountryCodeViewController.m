//
//  XIU_CountryCodeViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/7.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_CountryCodeViewController.h"


//判断系统语言
#define CURR_LANG ([[NSLocale preferredLanguages] objectAtIndex:0])
#define LanguageIsEnglish ([CURR_LANG isEqualToString:@"en-US"] || [CURR_LANG isEqualToString:@"en-CA"] || [CURR_LANG isEqualToString:@"en-GB"] || [CURR_LANG isEqualToString:@"en-CN"] || [CURR_LANG isEqualToString:@"en"])

@interface XIU_CountryCodeViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *searchResultValuesArray;
@end

@implementation XIU_CountryCodeViewController
{
    UISearchBar *searchBar;
    UISearchDisplayController *searchController;
    NSDictionary *sortedNameDict; //代码字典
    NSArray *indexArray;


}

- (NSMutableArray *)searchResultValuesArray {
    if (!_searchResultValuesArray) {
        _searchResultValuesArray = [NSMutableArray array];
    }
    return _searchResultValuesArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择国家或地区";
    [self creatSubviews];

}

-(void)creatSubviews{
    
    UITableView *XIUTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KWIDTH,KHEIGHT) style:UITableViewStylePlain];
    XIUTableView.delegate = self;
    XIUTableView.dataSource = self;
    XIUTableView.backgroundColor = [UIColor whiteColor];
    self.XIUTableView  = XIUTableView;
    [self.view addSubview:XIUTableView];
    
    [XIUTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];


    searchBar = [[UISearchBar alloc] init];
    [searchBar sizeToFit];
    [searchBar setDelegate:self];
    //关闭系统自动联想和首字母大写功能
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [XIUTableView setTableHeaderView:searchBar];
    
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    [searchController setDelegate:self];
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    
    NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedChnames" ofType:@"plist"];
    NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedEnames" ofType:@"plist"];
    
    //判断当前系统语言
    if (LanguageIsEnglish) {
        sortedNameDict = [NSDictionary dictionaryWithContentsOfFile:plistPathEN];
    }else{
        sortedNameDict = [NSDictionary dictionaryWithContentsOfFile:plistPathCH];
    }
    
    indexArray = [sortedNameDict allKeys];
    indexArray = [indexArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self.searchResultValuesArray removeAllObjects];
    
    for (NSArray *array in [sortedNameDict allValues]) {
        for (NSString *value in array) {
            if ([value containsString:searchBar.text]) {
                [self.searchResultValuesArray addObject:value];
            }
        }
    }
    [searchController.searchResultsTableView reloadData];
}

#pragma mark - UITableView
//section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _XIUTableView) {
        return [sortedNameDict allKeys].count;
    }else{
        return 1;
    }
}
//row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _XIUTableView) {
        
        NSArray *array = [sortedNameDict objectForKey:[indexArray objectAtIndex:section]];
        return array.count;
        
    }else{
        return [self.searchResultValuesArray count];
    }
}
//height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
//初始化cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _XIUTableView) {
        static NSString *ID1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID1];
        }
        //初始化cell数据!
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
        
        cell.textLabel.text = [[sortedNameDict objectForKey:[indexArray objectAtIndex:section]] objectAtIndex:row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
        return cell;
    }else{
        static NSString *ID2 = @"cellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID2];
        }
        if ([self.searchResultValuesArray count] > 0) {
            cell.textLabel.text = [self.searchResultValuesArray objectAtIndex:indexPath.row];
        }
        return cell;
    }
}
//indexTitle
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (tableView == _XIUTableView) {
        return indexArray;
    }else{
        return nil;
    }
}
//
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (tableView == _XIUTableView) {
        return index;
    }else{
        return 0;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _XIUTableView) {
        if (section == 0) {
            return 0;
        }
        return 30;
    }else {
        return 0;
    }
    
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [indexArray objectAtIndex:section];
}

#pragma mark - 选择国际获取代码
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"选择相应国家,输出:%@",cell.textLabel.text);
    
    if (self.returnCountryCodeBlock != nil) {
        self.returnCountryCodeBlock(cell.textLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toReturnCountryCode:(returnCountryCodeBlock)block{
    self.returnCountryCodeBlock = block;
}

@end
