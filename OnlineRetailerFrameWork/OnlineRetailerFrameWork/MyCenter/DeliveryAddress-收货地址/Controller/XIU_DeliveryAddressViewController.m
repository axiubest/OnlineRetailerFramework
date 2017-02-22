//
//  XIU_DeliveryAddressViewController.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressViewController.h"
#import "XIU_DeliveryAddressListCell.h"
@interface XIU_DeliveryAddressViewController ()<UITableViewDelegate, UITableViewDataSource, XIU_DeliveryAddressListCellDelegate>
{
    XIU_DeliveryAddressListCell *_cell;
}
@property (weak, nonatomic) IBOutlet UILabel *bottomAddNewAddressButton;

@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;
@end

@implementation XIU_DeliveryAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _XIUTableView.tableHeaderView.frame = CGRectZero;
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


#pragma maek XIU_DeliveryAddressListCellDelegate
- (void)deleteFunc {
    
}

- (void)editFunc {
    
}
@end
