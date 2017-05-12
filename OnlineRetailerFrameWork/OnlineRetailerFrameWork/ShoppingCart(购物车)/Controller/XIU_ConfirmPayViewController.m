//
//  XIU_ConfirmPayViewController.m
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ConfirmPayViewController.h"
#import "XIU_PayManager.h"
@interface XIU_ConfirmPayViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *XIUTableView;

@end

@implementation XIU_ConfirmPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [XIU_PayManager payMessage];

}

@end
