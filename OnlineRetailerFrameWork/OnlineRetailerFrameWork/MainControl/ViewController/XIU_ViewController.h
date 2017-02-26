//
//  XIU_ViewController.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UINavigationItem_Type) {
    UINavigationItem_Type_LeftItem,
    UINavigationItem_Type_RightItem
};

@interface XIU_ViewController : UIViewController

/**
 create navgation button

 @param imageName type:NSString
 */
- (void)createNavgationButtonWithImageNmae:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action type:(UINavigationItem_Type)navigationItem_Type;

- (void)showEmptyDataSetViewWithTitle:(NSDictionary *)emptyDictionary;
- (BOOL)isLogin;
- (void)createSimulationSearchBar;

@end
