//
//  XIU_SettingTextViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SettingTextViewController.h"
#import "SettingTextCell.h"
@interface XIU_SettingTextViewController ()
@property (strong, nonatomic) UITableView *XIUTableView;
@property (strong, nonatomic) NSString *myTextValue;
@end

@implementation XIU_SettingTextViewController
+ (instancetype)settingTextVCWithTitle:(NSString *)title textValue:(NSString *)textValue doneBlock:(void(^)(NSString *textValue))block{
    XIU_SettingTextViewController *vc = [[XIU_SettingTextViewController alloc] init];
    vc.title = title;
    vc.textValue = textValue? textValue : @"";
    vc.doneBlock = block;
    vc.settingType = SettingTypeOnlyText;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myTextValue = [_textValue mutableCopy];
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithBtnTitle:@"完成" target:self action:@selector(doneBtnClicked:)] animated:YES];
//    @weakify(self);
//    RAC(self.navigationItem.rightBarButtonItem, enabled) =
//    [RACSignal combineLatest:@[RACObserve(self, myTextValue)] reduce:^id (NSString *newTextValue){
//        @strongify(self);
//        if ([self.textValue isEqualToString:newTextValue]) {
//            return @(NO);
//        }else if (self.settingType != SettingTypeOnlyText && newTextValue.length <= 0){
//            return @(NO);
//        }
//        return @(YES);
//    }];
    
    //    添加myTableView
    _XIUTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor xiu_tableViewBackgroundColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[SettingTextCell class] forCellReuseIdentifier:kCellIdentifier_SettingText];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    if (self.settingType != SettingTypeOnlyText) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    }
}

#pragma mark doneBtn
- (void)doneBtnClicked:(id)sender{
    if (self.doneBlock) {
        self.doneBlock(_myTextValue);
    }
    if (self.settingType == SettingTypeOnlyText) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)dismissSelf{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Table M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XIU_WeakSelf(self);
    SettingTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_SettingText forIndexPath:indexPath];
    [cell setTextValue:_textValue andTextChangeBlock:^(NSString *textValue) {
        weakself.myTextValue = textValue;
    }];
    cell.textField.placeholder = self.placeholderStr ?: @"未填写";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    headerView.backgroundColor = [UIColor xiu_tableViewSectionBackgroundColor];
    [headerView setHeight:30.0];
    return headerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc
{
    _XIUTableView.delegate = nil;
    _XIUTableView.dataSource = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
