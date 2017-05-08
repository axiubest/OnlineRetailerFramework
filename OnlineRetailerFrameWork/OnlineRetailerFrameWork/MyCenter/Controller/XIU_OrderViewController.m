//
//  XIU_OrderViewController.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/4.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_OrderViewController.h"

@interface XIU_OrderViewController ()<UITableViewDelegate, UITableViewDataSource,XIU_OrderSegmentDelegate>

@property (nonatomic, weak)XIU_OrderSegmentView *segmentView;
@property (nonatomic, weak)UITableView *XIUTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

#define segmentHeight 40
@implementation XIU_OrderViewController




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    [self.view addSubview:self.segmentView];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, NaigationBarHeight + segmentHeight, KWIDTH, KHEIGHT - NaigationBarHeight + segmentHeight) style:UITableViewStyleGrouped];

    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _XIUTableView = table;
    [self.view addSubview:_XIUTableView];

    [self request];
}

- (void)request {
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];
    [self.dataArray addObject:@""];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark segment-Delegate
- (void)clickSegmentType:(PurchaseInformationStyle)style {
    switch (style) {
        case PurchaseInformationStyle_All:
            
            break;
        case PurchaseInformationStyle_Get:
            
            break;
        case PurchaseInformationStyle_Pay:
            
            break;
        case PurchaseInformationStyle_Send:
            
            break;
        case PurchaseInformationStyle_retund:
            
            break;
            
        default:
            break;
    }
}

-(void)setStyle:(PurchaseInformationStyle)style {
    _style = style;
    self.segmentView.style = style;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(XIU_OrderSegmentView *)segmentView {
    if (!_segmentView) {
        XIU_OrderSegmentView *segment = [[[NSBundle mainBundle] loadNibNamed:[XIU_OrderSegmentView XIU_ClassIdentifier] owner:self options:nil] lastObject];
        segment.frame = CGRectMake(0, NaigationBarHeight, KWIDTH, segmentHeight);
        segment.style = _style;
        segment.delegate = self;
        _segmentView  = segment;
    }
    return _segmentView;
}

@end
