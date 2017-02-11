//
//  XIU_XIU_BaseRootTool.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2016/12/28.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_BaseRootTool.h"
//控制器选择工具

#import "XIU_HiddenTabBarController.h"
#import "XIU_BaseNavgationController.h"
#import "XIU_MyCenterMainInterfaceVC.h"//个人中心
#import "XIU_HomeViewController.h"//首页
#import "XIU_ShoppingCartViewController.h"//购物车

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"


@implementation XIU_BaseRootTool

+ (void)chooseRootViewController:(UIWindow *)window {

    
    XIU_HomeViewController *firstViewController = [[XIU_HomeViewController alloc] init];
    XIU_BaseNavgationController *firstNavigationController = [[XIU_BaseNavgationController alloc]initWithRootViewController:firstViewController];
    firstViewController.view.backgroundColor = [UIColor orangeColor];
    
    
    XIU_ShoppingCartViewController *secondViewController = [[XIU_ShoppingCartViewController alloc] init];
    XIU_BaseNavgationController *secondNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:secondViewController];

    
    XIU_MyCenterMainInterfaceVC *thirdViewController = [[XIU_MyCenterMainInterfaceVC alloc] init];
    XIU_BaseNavgationController *thirdNavigationController = [[XIU_BaseNavgationController alloc] initWithRootViewController:thirdViewController];
    
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,thirdNavigationController]];
    [self customizeTabBarForController:tabBarController];

    window.rootViewController = tabBarController;
    
}


#pragma mark - Methods

+ (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    NSArray *titleArray = @[@"首页",@"购物车",@"个人中心"];
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setTitle:titleArray[index]];
        
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:12],
                                           NSForegroundColorAttributeName: [UIColor orangeColor],
                                           };
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor redColor],
                                         };
        
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}



@end
