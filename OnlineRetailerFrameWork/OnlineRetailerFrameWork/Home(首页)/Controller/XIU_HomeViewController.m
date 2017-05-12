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

#define kTopViewHeight 700 * kScreenWidthRatio

#import "XIU_CommodityDetailBaseController.h"
@interface XIU_HomeViewController ()
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

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




- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"",@"", nil];
    }
    return _dataArray;
}
- (void)createNavgationSearchBar {
    [self createSimulationSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
