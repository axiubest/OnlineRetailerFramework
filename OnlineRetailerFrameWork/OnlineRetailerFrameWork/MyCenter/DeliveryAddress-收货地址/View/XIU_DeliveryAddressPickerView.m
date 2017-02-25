//
//  XIU_DeliveryAddressPickerView.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/23.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_DeliveryAddressPickerView.h"


#define TOPCONTROL_HEIGHT 40
#define PickerViewHeight KWIDTH * 0.5

@interface XIU_DeliveryAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *topView;


@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;
@property (nonatomic, weak) UIPickerView *myPicker;
@end

@implementation XIU_DeliveryAddressPickerView


-(instancetype)initWithFrame:(CGRect)frame pickerDic:(NSDictionary *)pickerDic {
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerDic = pickerDic;
        
        self.provinceArray = [self.pickerDic allKeys];
        self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
        
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        }
        
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        }

        [self createUIWithframe:frame];
        

    }
    return self;
}

- (void)createUIWithframe:(CGRect)frame {
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, frame.size.height - PickerViewHeight)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6f];
    [maskView bk_whenTapped:^{
        [_Delegate clickedMaskView];
    }];
    [self addSubview:maskView];
    
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, KHEIGHT - PickerViewHeight - TOPCONTROL_HEIGHT, KWIDTH,TOPCONTROL_HEIGHT)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton addTarget:self action:@selector(clickedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTintColor:[UIColor blackColor]];
    [self.topView addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton addTarget:self action:@selector(clickedSureButton) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.topView addSubview:sureButton];
    
    
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KHEIGHT -PickerViewHeight, KWIDTH, PickerViewHeight)];
    pick.delegate = self;
    pick.dataSource = self;
    _myPicker = pick;
    [self addSubview:pick];
    
    
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(30,20));
    }];
    
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topView.mas_centerY);
        make.right.equalTo(self).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(30,20));
    }];
    

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = 1;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)clickedSureButton {
    [_Delegate clickedLocationWithProvince:[self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]] city:[self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]] town:[self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]]];
}

- (void)clickedCancelButton {
    [_Delegate clickedMaskView];
}



#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}

@end
