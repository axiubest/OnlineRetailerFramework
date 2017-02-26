//
//  XIU_ShoppingCart_GoodsModel.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShoppingCartViewController.h"
#import "XIU_ShoppingCartCell.h"
#import "XIU_ShoppingCart_ShopModel.h"
#import "XIU_ShoppingCart_GoodsModel.h"
#import "XIU_ShoppingCartHeaderView.h"
#import "XIU_ShoppingCartCalculationView.h"
#import "XIU_ShoppingCartEmptyView.h"

#import "XIU_CommodityDetailBaseController.h"

static NSInteger TableViewHeaderHeight = 40;
static NSInteger CartEmptyView = 100;
static NSInteger CartRowHeight = 100;
@interface XIU_ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource, XIU_ShoppingCartCalculationViewDelegate>

@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *XIUTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property (nonatomic, assign) XIU_ShoppingCartEmptyView *emptyView;
@end

@implementation XIU_ShoppingCartViewController

-(XIU_ShoppingCartEmptyView *)emptyView {
    if (!_emptyView) {
        XIU_ShoppingCartEmptyView *backgroundView = [[XIU_ShoppingCartEmptyView alloc]initWithFrame:CGRectMake(0, NaigationBarHeight, KWIDTH, KHEIGHT - NaigationBarHeight)WithTitle:@"" ImageName:@""];
        backgroundView.tag = CartEmptyView;
        _emptyView = backgroundView;
    }
    return _emptyView;
}

-(UITableView *)XIUTableView {
    if (!_XIUTableView) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT - 2  * TabBarHeight- NaigationBarHeight) style:UITableViewStyleGrouped];
        
        table.delegate = self;
        table.dataSource = self;
        
        table.rowHeight = CartRowHeight;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.backgroundColor = [UIColor colorWithRed:246 green:246 blue:248 alpha:1];
        [self.view addSubview:table];
        _XIUTableView = table;

    }
    return _XIUTableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataArray;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _selectedArray;
}


#pragma mark - viewController life cicle
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

//    if (self.selectedArray.count > 0) {
//        for (XIU_ShoppingCart_GoodsModel *model in self.selectedArray) {
//            model.select = NO;//这个其实有点多余,提交订单后的数据源不会包含这些,保险起见,加上了
//        }
//        [self.selectedArray removeAllObjects];
//    }
//    
//    _allSellectedButton.selected = NO;
//    _totlePriceLabel.attributedText = [NSString SetStringOfShoppingCartPriceString:@"￥0.00"];
}

-(void)creatData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist" inDirectory:nil];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSArray *array = [dic objectForKey:@"data"];
    if (array.count > 0) {
        for (NSDictionary *dic in array) {
            XIU_ShoppingCart_ShopModel *model = [[XIU_ShoppingCart_ShopModel alloc]init];
            model.shopID = [dic objectForKey:@"id"];
            model.shopName = [dic objectForKey:@"shopName"];
            model.sID = [dic objectForKey:@"sid"];
            [model configGoodsArrayWithArray:[dic objectForKey:@"items"]];
            
            [self.dataArray addObject:model];
        }
    }

}
- (void)loadData {
    [self creatData];
    [self changeView];
    
    if (self.selectedArray.count > 0) {
        for (XIU_ShoppingCart_GoodsModel *model in self.selectedArray) {
            model.select = NO;//这个其实有点多余,提交订单后的数据源不会包含这些,保险起见,加上了
        }
        [self.selectedArray removeAllObjects];
    }
    
    _allSellectedButton.selected = NO;
    _totlePriceLabel.attributedText = [NSString SetStringOfShoppingCartPriceString:@"￥0.00"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self loadData];
    

//    if (self.dataArray.count > 0) {
//        
//        [self setupCartView];
//    } else {
//        [self.view addSubview:self.emptyView];
//    }
}


//计算已选中商品金额
-(void)countPrice {
    double totlePrice = 0.0;
    
    for (XIU_ShoppingCart_GoodsModel *model in self.selectedArray) {
        
        double price = [model.price doubleValue];
        
        totlePrice += price * model.count;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.attributedText = [NSString SetStringOfShoppingCartPriceString:string];
}


#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    
    XIU_ShoppingCartCalculationView *backgroundView = [[XIU_ShoppingCartCalculationView alloc]initWithFrame:CGRectMake(0, KHEIGHT - 2 * TabBarHeight - NaigationBarHeight, KWIDTH, TabBarHeight)];
    backgroundView.MyDelegate = self;
        self.totlePriceLabel = backgroundView.priceLabel;

     [self.view addSubview:backgroundView];
    
    

}
#pragma mark -- 购物车为空时的默认视图
- (void)changeView {
    if (self.dataArray.count > 0) {
        UIView *view = [self.view viewWithTag:CartEmptyView];
        if (view != nil) {
            [view removeFromSuperview];
        }
        
        [self setupCartView];
    } else {
        UIView *bottomView = [self.view viewWithTag:CartEmptyView + 1];
        [bottomView removeFromSuperview];
        
        [self.XIUTableView removeFromSuperview];
        self.XIUTableView = nil;
        [self.view addSubview:self.emptyView];
    }
}

#pragma mark -- 购物车有商品时的视图
- (void)setupCartView {
    //创建底部视图
    [self setupCustomBottomView];

    [self.XIUTableView registerClass:[XIU_ShoppingCartHeaderView class] forHeaderFooterViewReuseIdentifier:XIU_ShoppingCartHeaderViewIdentifier];
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XIU_ShoppingCart_ShopModel *model = [self.dataArray objectAtIndex:section];
    return model.goodsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XIU_ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:XIU_ShoppingCartShopCellIdentifier];
    if (cell == nil) {
        cell = [[XIU_ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:XIU_ShoppingCartShopCellIdentifier];
    }
    
    XIU_ShoppingCart_ShopModel *shopModel = self.dataArray[indexPath.section];
    XIU_ShoppingCart_GoodsModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
    
    __block typeof(cell)wsCell = cell;
    
    [cell numberAddWithBlock:^(NSInteger number) {
        wsCell.lzNumber = number;
        model.count = number;
        
        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];
    
    [cell numberCutWithBlock:^(NSInteger number) {
        
        wsCell.lzNumber = number;
        model.count = number;
        
        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];
    
    [cell cellSelectedWithBlock:^(BOOL select) {
        
        model.select = select;
        if (select) {
            [self.selectedArray addObject:model];
        } else {
            [self.selectedArray removeObject:model];
        }
        
        [self verityAllSelectState];
        [self verityGroupSelectState:indexPath.section];
        
        [self countPrice];
    }];
    
    [cell reloadDataWithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"XIU_CommodityDetailBaseController" bundle:[NSBundle mainBundle]];
    
    XIU_CommodityDetailBaseController *myView = (XIU_CommodityDetailBaseController *)[story instantiateViewControllerWithIdentifier:@"XIU_CommodityDetailBaseController"];
    [self presentViewController:myView animated:YES completion:nil];
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XIU_ShoppingCartHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XIU_ShoppingCartHeaderViewIdentifier];
    XIU_ShoppingCart_ShopModel *model = [self.dataArray objectAtIndex:section];
    
    view.title = model.shopName;
    view.select = model.select;
    view.ClickBlock = ^(BOOL select) {
        model.select = select;
        if (select) {

            for (XIU_ShoppingCart_GoodsModel *good in model.goodsArray) {
                good.select = YES;
                if (![self.selectedArray containsObject:good]) {
                    
                    [self.selectedArray addObject:good];
                }
            }
            
        } else {
            for (XIU_ShoppingCart_GoodsModel *good in model.goodsArray) {
                good.select = NO;
                if ([self.selectedArray containsObject:good]) {
                    
                    [self.selectedArray removeObject:good];
                }
            }
        }
        
        [self verityAllSelectState];

        [tableView reloadData];
        [self countPrice];
    };
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return TableViewHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            XIU_ShoppingCart_ShopModel *shop = [self.dataArray objectAtIndex:indexPath.section];
            XIU_ShoppingCart_GoodsModel *model = [shop.goodsArray objectAtIndex:indexPath.row];
            
            [shop.goodsArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            if (shop.goodsArray.count == 0) {
                [self.dataArray removeObjectAtIndex:indexPath.section];
            }
            
            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }
            
            NSInteger count = 0;
            for (XIU_ShoppingCart_ShopModel *shop in self.dataArray) {
                count += shop.goodsArray.count;
            }
            
            if (self.selectedArray.count == count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }
            
            if (count == 0) {
                [self changeView];
            }
            
            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)reloadTable {
    [self.XIUTableView reloadData];
}
#pragma mark -- 页面按钮点击事件


- (void)verityGroupSelectState:(NSInteger)section {
    
    // 判断某个区的商品是否全选
    XIU_ShoppingCart_ShopModel *tempShop = self.dataArray[section];
    // 是否全选标示符
    BOOL isShopAllSelect = YES;
    for (XIU_ShoppingCart_GoodsModel *model in tempShop.goodsArray) {
        // 当有一个为NO的是时候,将标示符置为NO,并跳出循环
        if (model.select == NO) {
            isShopAllSelect = NO;
            break;
        }
    }
    
    XIU_ShoppingCartHeaderView *header = (XIU_ShoppingCartHeaderView *)[self.XIUTableView headerViewForSection:section];
    header.select = isShopAllSelect;
    tempShop.select = isShopAllSelect;
}

- (void)verityAllSelectState {
    
    NSInteger count = 0;
    for (XIU_ShoppingCart_ShopModel *shop in self.dataArray) {
        count += shop.goodsArray.count;
    }
    
    if (self.selectedArray.count == count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark XIU_ShoppingCartCalculationViewDelegate
- (void)clickResultPrice {
    if (self.selectedArray.count > 0) {
        for (XIU_ShoppingCart_GoodsModel *model in self.selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.count);
        }
    } else {
        
        NSLog(@"你还没有选择任何商品");
        
    }
    
}

- (void)selectAllProduct:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (XIU_ShoppingCart_GoodsModel *model in self.selectedArray) {
        model.select = NO;
    }
    
    [self.selectedArray removeAllObjects];
    
    if (sender.selected) {
        
        for (XIU_ShoppingCart_ShopModel *shop in self.dataArray) {
            shop.select = YES;
            for (XIU_ShoppingCart_GoodsModel *model in shop.goodsArray) {
                model.select = YES;
                [self.selectedArray addObject:model];
            }
        }
        
    } else {
        for (XIU_ShoppingCart_ShopModel *shop in self.dataArray) {
            shop.select = NO;
        }
    }
    
    [self.XIUTableView reloadData];
    [self countPrice];

}
@end
