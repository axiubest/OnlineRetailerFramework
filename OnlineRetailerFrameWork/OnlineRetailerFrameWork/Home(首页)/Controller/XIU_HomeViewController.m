//
//  XIU_HomeViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_HomeViewController.h"
#import "XIU_SearchBarViewController.h"
#import "XIU_SearchBarSimulationView.h"

#import "XIU_CommodityDetailBaseController.h"
@interface XIU_HomeViewController ()

@end

@implementation XIU_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self createNavgationSearchBar];
    
    
}
- (void)createNavgationSearchBar {

    XIU_SearchBarSimulationView *searchBarView = [[XIU_SearchBarSimulationView alloc] initWithFrame:CGRectMake(60, 7, KWIDTH - 2 * 60 , 30)];
    [searchBarView bk_whenTapped:^{
        __weak typeof (self) weakSelf = self;
        [weakSelf.navigationController pushViewController:[[XIU_SearchBarViewController alloc] init] animated:YES];
    }];
    self.navigationItem.titleView = searchBarView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
