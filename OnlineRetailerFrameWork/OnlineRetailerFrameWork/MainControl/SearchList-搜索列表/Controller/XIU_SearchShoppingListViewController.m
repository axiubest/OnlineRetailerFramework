//
//  XIU_SearchShoppingListViewController.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/25.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SearchShoppingListViewController.h"
#import "XIU_CommodityDetailBaseController.h"
#import "XIU_SearchShoppingListCell.h"
@interface XIU_SearchShoppingListViewController ()<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@end

@implementation XIU_SearchShoppingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSimulationSearchBar];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XIU_SearchShoppingListCell *cell = [tableView dequeueReusableCellWithIdentifier:XIU_SearchShoppingListIdentifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KHEIGHT / 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:XIU_CommodityDetailID bundle:nil];
    
    XIU_CommodityDetailBaseController *deliverAddress= [mainStoryBoard instantiateViewControllerWithIdentifier:XIU_CommodityDetailID];
    [self presentViewController:deliverAddress animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
