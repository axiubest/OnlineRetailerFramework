//
//  XIU_MyCenterMainInterfaceVC.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2016/12/29.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_MyCenterMainInterfaceVC.h"
#import "XIU_SettingMineInfoVC.h"
#import "XIU_ModifyAvatarViewController.h"
#import "XIU_DeliveryAddressViewController.h"

//text
#import "XIU_LoginViewController.h"
#import "UINavigationBar+Awesome.h"


#import "XIU_MyCenterPurchaseInformationCell.h"
#import "XIU_MyCenterUtilitiesCell.h"

#import "XIU_MyCenterUserHeaderView.h"

static NSInteger NAVBAR_CHANGE_POINT = 50;

static  NSString *const NavgationBarRightImageName = @"设置";

@interface XIU_MyCenterMainInterfaceVC ()<UITableViewDelegate, UITableViewDataSource,SettingMineInfoDelegate, XIU_LoginViewControllerDelegate, XIU_MyCenterUserHeaderViewDelegate>
{
    UIImageView *navBarHairlineImageView;

}
@property (nonatomic, weak)UITableView *XIUTableViw;
@end

@implementation XIU_MyCenterMainInterfaceVC




-(UITableView *)XIUTableViw {
    if (!_XIUTableViw) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, KWIDTH, KHEIGHT + 20) style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.sectionHeaderHeight = 0.00001;
        tableView.backgroundColor = [UIColor xiu_tableViewSectionBackgroundColor];
        [self.view addSubview:tableView];
        _XIUTableViw = tableView;
        
        
    TableView_ResignNib([XIU_MyCenterPurchaseInformationCell xiu_classNib], XIU_MyCenterPurchaseInformationIdentifier);
      TableView_ResignNib([XIU_MyCenterUtilitiesCell xiu_classNib], XIU_MyCenterUtilitiesIdentifier);

    }
    return _XIUTableViw;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self XIUTableViw];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    [self createNavgationButtonWithImageNmae:NavgationBarRightImageName title:nil target:self action:@selector(chickedNavSettingButton) type:UINavigationItem_Type_RightItem];

}


#pragma mark setting
- (void)chickedNavSettingButton {
    
    XIU_SettingMineInfoVC *text= [[XIU_SettingMineInfoVC alloc] init];
    text.MyDelegate = self;
    [self.navigationController pushViewController:text animated:YES];
}

#pragma maek SettingMineInfoVC-Delegate
- (void)loginOutDelegate {
    [self.XIUTableViw reloadData];
    
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor whiteColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark----------tableViewDelegate--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

   return  indexPath.section == 0 ? 100 : 220;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        XIU_MyCenterPurchaseInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:XIU_MyCenterPurchaseInformationIdentifier];
       
        return cell;
    }
        XIU_MyCenterUtilitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:XIU_MyCenterUtilitiesIdentifier];
        return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        XIU_MyCenterUserHeaderView *userHeaderView = [[XIU_MyCenterUserHeaderView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KWIDTH * 0.4)];
        userHeaderView.XIUDelegate = self;
        return userHeaderView;
    }
    return nil;
}


#pragma mark XIU_MyCenterUserHeaderView-Delegate
-(void)pushToLogin {
    XIU_LoginViewController *login = [[XIU_LoginViewController alloc] init];
    login.XIUDelegate = self;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)pushToUserInformation {
    [self.navigationController pushViewController:[[XIU_ModifyAvatarViewController alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return section == 0 ?  KWIDTH, KWIDTH * 0.4 : 0;
}

#pragma mark XIU_LoginViewControllerDelegate
- (void)login {
    
    [_XIUTableViw reloadData];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:XIU_DeliveryAddressID bundle:nil];
    
    XIU_DeliveryAddressViewController *deliverAddress= [mainStoryBoard instantiateViewControllerWithIdentifier:XIU_DeliveryAddressID];

    [self.navigationController pushViewController:deliverAddress animated:YES];
}
@end
