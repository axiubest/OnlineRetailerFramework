//
//  XIU_SettingTextViewController.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_HiddenTabBarController.h"


typedef NS_ENUM(NSInteger, SettingType)
{
    SettingTypeOnlyText = 0,
    SettingTypeFolderName,
    SettingTypeNewFolderName,
    SettingTypeFileVersionRemark,
    SettingTypeFileName
};

@interface XIU_SettingTextViewController : XIU_HiddenTabBarController<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) void(^doneBlock)(NSString *textValue);
@property (strong, nonatomic) NSString *textValue, *placeholderStr;
@property (assign, nonatomic) SettingType settingType;


+ (instancetype)settingTextVCWithTitle:(NSString *)title textValue:(NSString *)textValue doneBlock:(void(^)(NSString *textValue))block;
@end
