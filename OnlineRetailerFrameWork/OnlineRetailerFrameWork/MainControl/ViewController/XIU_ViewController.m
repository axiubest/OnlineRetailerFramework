//
//  XIU_ViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ViewController.h"
#import "XIU_NetWorkReachability.h"

@interface XIU_ViewController ()

@property (nonatomic, weak) UIView *NetWorkReachabilityView;

@end

@implementation XIU_ViewController

-(UIView *)NetWorkReachabilityView {
    if (!_NetWorkReachabilityView) {
        UIView *NetWorkReachabilityView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, 20)];
        NetWorkReachabilityView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        NetWorkReachabilityView.hidden = YES;
        [self.view addSubview:NetWorkReachabilityView];
//        [[UIApplication sharedApplication].keyWindow addSubview:NetWorkReachabilityView];

        _NetWorkReachabilityView = NetWorkReachabilityView;
        
        UILabel *text = [[UILabel alloc] init];
        text.text  =@"网络请求失败，请检查您的网络设置";
        text.frame = CGRectMake(10, 0, 300, 20);
        text.textColor = [UIColor whiteColor];
        [NetWorkReachabilityView addSubview:text];

        
    }
    return _NetWorkReachabilityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
       }

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kNetWorkReachabilityChangedNotification object:nil];

}

- (void)reachabilityChanged:(NSNotification *)notification
{
    XIU_NetWorkReachability *curReach = [notification object];
    HLNetWorkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus) {
        case XIUNetWorkStatusNotReachable:

            NSLog(@"网络状态:--%@", @"网络不可用");

            self.NetWorkReachabilityView.hidden = NO;
            break;
        case XIUNetWorkStatusUnknown:

            NSLog(@"网络状态:--%@", @"未知网络");

            self.NetWorkReachabilityView.hidden = YES;

            break;
        case XIUNetWorkStatusWWAN2G:

            NSLog(@"网络状态:--%@", @"2G网络");
            self.NetWorkReachabilityView.hidden = YES;

            break;
        case XIUNetWorkStatusWWAN3G:

            NSLog(@"网络状态:--%@", @"3G网络");

            self.NetWorkReachabilityView.hidden = YES;

            break;
        case XIUNetWorkStatusWWAN4G:

            NSLog(@"网络状态:--%@", @"4G网络");

            self.NetWorkReachabilityView.hidden = YES;

            break;
        case XIUNetWorkStatusWiFi:

            NSLog(@"网络状态:--%@", @"WiFi");
            self.NetWorkReachabilityView.hidden = YES;

            break;
            
        default:
            break;
    }
}


- (BOOL)isLogin {
   return  [XIU_Login isLogin];
}

- (void)showEmptyDataSetViewWithTitle:(NSDictionary *)emptyDictionary {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
