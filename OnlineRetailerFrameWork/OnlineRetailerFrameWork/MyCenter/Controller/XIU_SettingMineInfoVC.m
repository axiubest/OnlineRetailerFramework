//
//  XIU_SettingMineInfoVC.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SettingMineInfoVC.h"


#import "JPViewController.h"

static CGFloat const Row_Height = 44.f;
static CGFloat const Section_HeaderHeight = 20.f;
//设置界面
@interface XIU_SettingMineInfoVC ()
@property (strong, nonatomic) XIU_User *curUser;
@property (nonatomic, strong) UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end


@implementation XIU_SettingMineInfoVC

-(NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"缓存清理", @"关于我们", @"帮助与反馈", @"分享", nil];
        [self isLogin] ? [_titleArray addObject:@"退出"]: _titleArray;
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"个人信息";
    self.curUser =[XIU_Login curLoginUser];
    
    //    添加myTableView
    _XIUTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor xiu_tableViewSectionBackgroundColor];
;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.estimatedRowHeight = Row_Height;
        tableView.sectionHeaderHeight = Section_HeaderHeight;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });


}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.row) {
        case SettingMenuItemType_Exit:
        {
            [XIU_Login doLogOut];
            NSLog(@"----login out success");
            if (![self isLogin]) {
                [_MyDelegate loginOutDelegate];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        case SettingMenuItemType_Share:
            [XIU_ShareView showShareView];
            break;
        case SettingMenuItemType_AboutUs:
            
            break;
        case SettingMenuItemType_CacheClean:
            
            break;
        case SettingMenuItemType_Help_feedback:
        {
            JPViewController *jp = [[JPViewController alloc] init];
            [self.navigationController pushViewController:jp animated:YES];
  
        }
            break;
        default:
            break;
    }
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    _XIUTableView.delegate = nil;
    _XIUTableView.dataSource = nil;
}


@end
