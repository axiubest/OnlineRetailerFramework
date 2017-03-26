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
#import "XIU_ScanQRCodeViewController.h"

#import "XIU_CommodityDetailBaseController.h"
@interface XIU_HomeViewController ()

@end

@implementation XIU_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    
    
    [self createNavgationButtonWithImageNmae:@"设置" title:@"扫一扫" target:self action:@selector(QRCode) type:UINavigationItem_Type_LeftItem];
    [self createNavgationSearchBar];
    
    
}

- (void)QRCode {
    [self.navigationController pushViewController:[[XIU_ScanQRCodeViewController alloc] init] animated:YES];
}
- (void)createNavgationSearchBar {
    [self createSimulationSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
