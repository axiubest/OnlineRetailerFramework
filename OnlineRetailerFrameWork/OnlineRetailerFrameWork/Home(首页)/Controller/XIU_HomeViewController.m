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
#import "PullDownMenu.h"
#import "XIU_WaterFallLayout.h"
#import "XIU_HomeWaterFallModel.h"
#import "MJExtension.h"
#import "XIU_HomeWaterFallCell.h"
#import "XIU_CommodityDetailBaseController.h"
#define kTopViewHeight 700 * kScreenWidthRatio

#import "XIU_CommodityDetailBaseController.h"
@interface XIU_HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XIU_FlowLayoutDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) PullDownMenu *pullMenu;

@property (weak, nonatomic) UICollectionView *collection;
@property(nonatomic,strong)NSMutableArray * dataSource;
@property (nonatomic, assign)CGRect transformedFrame;
@property (nonatomic, strong)UIImageView *lookImg;

@property (nonnull, strong)XIU_WaterFallLayout *layOut;
@end


@implementation XIU_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    [self createNavgationButtonWithImageNmae:@"设置" title:@"扫一扫" target:self action:@selector(QRCode) type:UINavigationItem_Type_LeftItem];
    [self createNavgationSearchBar];
    
    [self createWaterFall];
    [self createPullDownMenu];

}

- (void)createWaterFall {
    NSArray * arr = [XIU_HomeWaterFallModel mj_objectArrayWithFilename:@"1.plist"];
    [self.dataSource addObjectsFromArray:arr];
    [self.view addSubview:self.collection];
   }


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"%ld", indexPath.row];
            [self.collection registerClass:[XIU_HomeWaterFallCell class] forCellWithReuseIdentifier:identifier];
    XIU_HomeWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.row]];
    
    return cell;
}

-(CGFloat)Flow:(XIU_WaterFallLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath{
    XIU_HomeWaterFallModel *model = self.dataSource[indexPath.row];
    return  model.h/model.w*width;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     UIStoryboard *story = [UIStoryboard storyboardWithName:@"XIU_CommodityDetailBaseController" bundle:[NSBundle mainBundle]];
    XIU_CommodityDetailBaseController *myView = (XIU_CommodityDetailBaseController *)[story instantiateViewControllerWithIdentifier:@"XIU_CommodityDetailBaseController"];
    [self presentViewController:myView animated:YES completion:nil];

}


- (void)createPullDownMenu {
    self.pullMenu = [[PullDownMenu alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 40) menuTitleArray:@[@"空间",@"风格",@"价格"]];
    _pullMenu.hiddenBlock = 1;
    NSArray *sortRuleArray=@[@"0-5k",@"5k-10k",@"10k-50k",@"50k-100k"];
    self.pullMenu.menuDataArray = [NSMutableArray arrayWithObjects:@[@"厨房",@"大厅",@"卧室",@"花园"],@[@"欧式",@"现代",@"中式", @"美式"],sortRuleArray, nil];
    [self.view addSubview:self.pullMenu];
//    [self pullSelect];
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

-(NSMutableArray *)dataSource{
    if (!_dataSource) {

        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(UICollectionView *)collection {
    if (!_collection) {
        _layOut = [[XIU_WaterFallLayout alloc] init];
        _layOut.degelate =self;

        UICollectionView *colect  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, KWIDTH, self.view.frame.size.height - 40 - NaigationBarHeight - TabBarHeight) collectionViewLayout:_layOut];
        colect.backgroundColor  = [UIColor whiteColor];
        colect.delegate = self;
        colect.dataSource = self;

        
        _collection = colect;
    }
    return _collection;
}
- (void)createNavgationSearchBar {
    [self createSimulationSearchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
