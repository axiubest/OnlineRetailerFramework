//
//  XIU_SettingMineInfoVC.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//



typedef NS_ENUM(NSInteger, SettingMenuItemType) {
    SettingMenuItemType_CacheClean,
    SettingMenuItemType_AboutUs,
    SettingMenuItemType_Help_feedback,
    SettingMenuItemType_Share,
    SettingMenuItemType_Exit
};


#import "XIU_HiddenTabBarController.h"

/**
 个人信息修改
 */


@protocol SettingMineInfoDelegate <NSObject>

@optional
- (void)loginOutDelegate;

@end

@interface XIU_SettingMineInfoVC : XIU_HiddenTabBarController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign)id<SettingMineInfoDelegate> MyDelegate;

@end
