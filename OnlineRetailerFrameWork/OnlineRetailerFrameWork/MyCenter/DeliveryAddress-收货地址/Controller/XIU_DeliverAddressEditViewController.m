//
//  XIU_DeliverAddressEditViewController.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliverAddressEditViewController.h"

#import "XIU_DeliveryAddressPickerView.h"

#import "XIU_DeliveryAddressEditLocationCell.h"
#import "XIU_DeliveryAddressEditInformationCell.h"
#import "XIU_DeliveryAddressEditDestribtionLocCell.h"


@interface XIU_DeliverAddressEditViewController ()<UITableViewDelegate, UITableViewDataSource, XIU_DeliveryAddressPickerViewDelegate>
{
    XIU_DeliveryAddressEditLocationCell         *locationCell;
    XIU_DeliveryAddressEditInformationCell      *personCell;
    XIU_DeliveryAddressEditInformationCell      *phoneCell;
    XIU_DeliveryAddressEditDestribtionLocCell   *DestribtionCell;
}
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@property (nonatomic, strong) XIU_DeliveryAddressPickerView *areaPickerView;

//data
@property (strong, nonatomic) NSDictionary *pickerDic;


@property (nonatomic, strong) CALayer *hiddenLayer;
@end

@implementation XIU_DeliverAddressEditViewController



-(XIU_DeliverAdderssModel *)model {
    if (_model) {
        self.navigationItem.title =@"修改地址";
    }else {
        self.navigationItem.title = @"添加新地址";
    }
    
    return _model;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self getLocationPickerSource];
    [self createNavgationButtonWithImageNmae:nil title:@"确定" target:self action:@selector(clickedSureButton) type:UINavigationItem_Type_RightItem];

}



- (void)getLocationPickerSource {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
        self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section == 0 ? 4 : 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model ? 3 : 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case DeliverAddressEditType_Person: {          XIU_DeliveryAddressEditInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_DeliveryAddressEditInformationCell XIU_ClassIdentifier]];
                    personCell = cell;
                    cell.indexPath = indexPath;
                    if (self.model) {
                        cell.InformationTexfField.text = self.model.getPerson;
                    }
                    return cell;
                }
                    break;
                case DeliverAddressEditType_Phone: {XIU_DeliveryAddressEditInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_DeliveryAddressEditInformationCell XIU_ClassIdentifier]];
                    phoneCell = cell;
                    cell.InformationTexfField.text = self.model.phoneNumber;
                     cell.indexPath = indexPath;
                    return cell;
                }
                    break;
                case DeliverAddressEditType_Location: {
                    XIU_DeliveryAddressEditLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_DeliveryAddressEditLocationCell XIU_ClassIdentifier]];
                    locationCell = cell;
                    cell.locationLabel.text = self.model.Location;
                    return cell;
                }
                    break;
                case DeliverAddressEditType_Distribtion: {
                    XIU_DeliveryAddressEditDestribtionLocCell *cell = [tableView dequeueReusableCellWithIdentifier:[XIU_DeliveryAddressEditDestribtionLocCell XIU_ClassIdentifier]];
                    DestribtionCell = cell;
                    cell.Legitimate = self.model.detialLocation;
                    return cell;
                }
                    break;
                default:
                    break;
            }
            break;
        case 1: {
            XIU_DeliveryAddressEditInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XIU_DeliveryAddressEditInformationCell"];
             cell.indexPath = indexPath;
            return cell;
        }
            
            break;
        case 2: {
            XIU_DeliveryAddressEditInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XIU_DeliveryAddressEditInformationCell"];
             cell.indexPath = indexPath;
            return cell;
        }
            
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   return indexPath.section == 0 && indexPath.row == 3 ? 88 : 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:YES];
    if (indexPath.section == 0 && indexPath.row == 2) {
        
         _areaPickerView= [[XIU_DeliveryAddressPickerView alloc]initWithFrame:CGRectMake(0, 0, KWIDTH, self.view.frame.size.height) pickerDic:self.pickerDic];
        _areaPickerView.Delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_areaPickerView];
        
    }
    return;

}


#pragma mark XIU_DeliveryAddressPickerViewDelegate
- (void)clickedMaskView {
    [self removePickerView];
}

- (void)clickedLocationWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town {
    [self removePickerView];
    locationCell.locationLabel.text = [NSString stringWithFormat:@"%@-%@-%@", province, city, town];
}

- (void)removePickerView {
    [_areaPickerView removeFromSuperview];

}

- (void)clickedSureButton {

    if ([personCell Legitimate] != nil && [phoneCell Legitimate] != nil && [locationCell Legitimate] != nil && [DestribtionCell Legitimate] != nil) {
            [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
