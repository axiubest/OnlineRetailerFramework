//
//  XIU_DeliveryAddressViewController.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressViewController.h"
#import "XIU_DeliverAddressEditViewController.h"
#import "XIU_DeliveryAddressListCell.h"
#import "XIU_DeliverAdderssModel.h"

@interface XIU_DeliveryAddressViewController ()<UITableViewDelegate, UITableViewDataSource, XIU_DeliveryAddressListCellDelegate>
{
    XIU_DeliveryAddressListCell *_cell;
}


@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@end

@implementation XIU_DeliveryAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _XIUTableView.tableHeaderView.frame = CGRectZero;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"收货地址";

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    XIU_DeliveryAddressListCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"XIU_DeliveryAddressListCellIdentifier"];
    _cell.delegate = self;
    _cell = cell;
    [cell setUpData:@"北京市东花市北里20号楼6单元501室"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

   NSString *str = @"北京市东花市北里20号楼6单元501室";
    return [_cell CellHeightWithModel:str];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)bottomAddNewAddressButton:(id)sender {
    //添加地址按钮点击传入空模型进入新建地址
    [self pushXIU_DeliverAddressEditViewControllerWithModel:nil];
}

#pragma maek XIU_DeliveryAddressListCellDelegate
- (void)deleteFunc {
    
}

- (void)editFunc {
    //编辑状体下传入模型进入新建地址
    XIU_DeliverAdderssModel *model = [[XIU_DeliverAdderssModel alloc] init];
    model.getPerson = @"dffd";
    model.phoneNumber = @"1787878787";
    model.Location = @"dsfsfsadfasfadsfdsfsf";
    model.detialLocation = @"中国浙江省杭州市中国浙江省杭州市中国浙江省杭州市中国浙江省杭州市中国浙江省杭州市";
    [self pushXIU_DeliverAddressEditViewControllerWithModel:model];
}

- (void)pushXIU_DeliverAddressEditViewControllerWithModel:(XIU_DeliverAdderssModel *)model {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:XIU_DeliverAddressEditID bundle:nil];
    
    XIU_DeliverAddressEditViewController *deliverAddress= [mainStoryBoard instantiateViewControllerWithIdentifier:XIU_DeliverAddressEditID];
    deliverAddress.model = model;
    [self.navigationController pushViewController:deliverAddress animated:YES];
}
@end
