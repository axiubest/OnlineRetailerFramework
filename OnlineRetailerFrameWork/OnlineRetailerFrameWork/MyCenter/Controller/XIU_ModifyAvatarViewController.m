//
//  XIU_ModifyAvatarViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ModifyAvatarViewController.h"

#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"

#import "XIU_MyCenterTitleValueMoreCell.h"
#import "XIU_MyCenterModifyAvatarCell.h"
#import "UserInfoDetailTagCell.h"
#import "XIU_SettingTextViewController.h"

#import "NSDate+Helper.h"
#import "NSDate+Common.h"
/**
 个人信息修改
 */
@interface XIU_ModifyAvatarViewController ()
@property (strong, nonatomic) XIU_User *curUser;
@property (nonatomic, strong) UITableView *XIUTableView;

@end

#define kPaddingLeftWidth 15.0
@implementation XIU_ModifyAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"个人信息";
    self.curUser =[XIU_Login curLoginUser];
    
    _XIUTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor xiu_tableViewBackgroundColor];
        ;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[XIU_MyCenterTitleValueMoreCell XIU_ClassNib] forCellReuseIdentifier:[XIU_MyCenterTitleValueMoreCell XIU_ClassIdentifier]];

        [tableView registerNib:[XIU_MyCenterModifyAvatarCell XIU_ClassNib] forCellReuseIdentifier:[XIU_MyCenterModifyAvatarCell XIU_ClassIdentifier]];
        [tableView registerNib:[UserInfoDetailTagCell XIU_ClassNib] forCellReuseIdentifier:[UserInfoDetailTagCell XIU_ClassIdentifier]];

        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        XIU_MyCenterModifyAvatarCell *cell = [[XIU_MyCenterModifyAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XIU_MyCenterModifyAvatarCell XIU_ClassIdentifier]];
        cell.curUser = _curUser;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }else {
           XIU_MyCenterTitleValueMoreCell *cell = [[XIU_MyCenterTitleValueMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XIU_MyCenterTitleValueMoreCell XIU_ClassIdentifier]];
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                    [cell setTitleStr:@"昵称" valueStr:_curUser.userName];
                    
                    break;
                case 1:
                    [cell setTitleStr:@"性别" valueStr:_curUser.userSex];
                    
                    break;
                case 2:
                    [cell setTitleStr:@"生日" valueStr:_curUser.userBirth];
                    break;
                case 3:
                    [cell setTitleStr:@"爱好" valueStr:_curUser.hobby];
                    break;
                default:
                    break;
            }
            
        }
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kPaddingLeftWidth];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cellHeight = [XIU_MyCenterModifyAvatarCell cellHeight];
    }else {
        cellHeight = [XIU_MyCenterTitleValueMoreCell cellHeight];
    }
    return cellHeight;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 1)];
    [headerView setHeight:20.0];
    return headerView;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XIU_WeakSelf(self);
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        [actionSheet showInView:self.view];
        
    }else if (indexPath.section == 1)  {
        switch (indexPath.row) {
            case UserInformationItemStyle_userName: {
                XIU_SettingTextViewController *vc = [XIU_SettingTextViewController settingTextVCWithTitle:@"昵称" textValue:_curUser.userName  doneBlock:^(NSString *textValue) {

                    weakself.curUser.userName = textValue;
                    
                    [weakself.XIUTableView reloadData];
                    //                    request
                }];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case UserInformationItemStyle_sex: {
                [ActionSheetStringPicker showPickerWithTitle:nil rows:@[@[@"男", @"女", @"未知"]] initialSelection:@[_curUser.userSex] doneBlock:^(ActionSheetStringPicker *picker, NSArray * selectedIndex, NSArray *selectedValue) {
                    
                    weakself.curUser.userSex = @"";
                    [weakself.XIUTableView reloadData];
                    
                } cancelBlock:nil origin:self.view];
            }
                break;
            case UserInformationItemStyle_birthday: {
                NSDate *curDate = [NSDate dateFromString:_curUser.userBirth withFormat:@"yyyy-MM-dd"];
                if (!curDate) {
                    curDate = [NSDate dateFromString:@"1990-01-01" withFormat:@"yyyy-MM-dd"];
                }
                ActionSheetDatePicker *picker = [[ActionSheetDatePicker alloc] initWithTitle:nil datePickerMode:UIDatePickerModeDate selectedDate:curDate doneBlock:^(ActionSheetDatePicker *picker, NSDate *selectedDate, id origin) {

                    weakself.curUser.userBirth = [selectedDate string_yyyy_MM_dd];
                    [weakself.XIUTableView reloadData];
                    //                    request
                } cancelBlock:^(ActionSheetDatePicker *picker) {
                    
                } origin:self.view];
                picker.minimumDate = [[NSDate date] offsetYear:-120];
                picker.maximumDate = [NSDate date];
                [picker showActionSheetPicker];
                
            }
                break;
            case UserInformationItemStyle_hobby: {
                XIU_SettingTextViewController *vc = [XIU_SettingTextViewController settingTextVCWithTitle:@"爱好" textValue:_curUser.hobby  doneBlock:^(NSString *textValue) {

                    weakself.curUser.hobby = textValue;
                    
                    [weakself.XIUTableView reloadData];
                    //                    request
                }];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            default:
                break;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIActionSheetDelegate M
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    
    if (buttonIndex == 0) {
        //        拍照
        //        if (![Helper checkCameraAuthorizationStatus]) {
        //            return;
        //        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        //        相册
        //        if (![Helper checkPhotoLibraryAuthorizationStatus]) {
        //            return;
        //        }
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage, *originalImage;
        editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageWriteToSavedPhotosAlbum(originalImage, self, nil, NULL);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    _XIUTableView.delegate = nil;
    _XIUTableView.dataSource = nil;
}


@end
