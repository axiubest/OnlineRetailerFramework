//
//  XIU_ConfirmPayViewController.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ConfirmPayViewController.h"
#import "XIU_ConfirmPayAddressCell.h"
#import "XIU_PayManager.h"
@interface XIU_ConfirmPayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;



@end

@implementation XIU_ConfirmPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"确认订单";

    [_XIUTableView registerNib:[XIU_ConfirmPayAddressCell XIU_ClassNib] forCellReuseIdentifier:[XIU_ConfirmPayAddressCell XIU_ClassIdentifier]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return CGFLOAT_MIN;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XIU_ConfirmPayAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_ConfirmPayAddressCell XIU_ClassIdentifier]];
        return cell;
    }
    UITableViewCell *cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [XIU_PayManager payMessage];

}

@end
