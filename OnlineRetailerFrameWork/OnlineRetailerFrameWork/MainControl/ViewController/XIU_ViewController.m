//
//  XIU_ViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/10.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ViewController.h"
#import "XIU_NetWorkReachability.h"
#import "XIU_SearchBarSimulationView.h"
#import "XIU_SearchBarViewController.h"
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


- (void)createNavgationButtonWithImageNmae:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action type:(UINavigationItem_Type)navigationItem_Type {
    if (title == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(0, 0, 25, 25);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:button];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }
    }else if (imageName == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 40, 25);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:button];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }
    }else {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(-5, -5, 30, 30)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(backView.x, backView.y, 25, 25);
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10.f];
        label.tag = 888;
        label.textAlignment = 1;
        label.textColor = [UIColor blackColor];
        label.text = title;
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button.mas_bottom).with.offset(0);

            make.centerX.equalTo(button.mas_centerX);
        }];
        
        UIBarButtonItem *Item = [[UIBarButtonItem alloc]initWithCustomView:backView];
        if (navigationItem_Type == UINavigationItem_Type_LeftItem) {
            self.navigationItem.leftBarButtonItem = Item;
        }else if (navigationItem_Type == UINavigationItem_Type_RightItem) {
            self.navigationItem.rightBarButtonItem = Item;
        }

        
        
    }

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setEditing:NO];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)createNavgationButtonOfLeftWithImageNmae:(NSString *)imageName target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
}

- (void)createSimulationSearchBar {
    
    XIU_SearchBarSimulationView *searchBarView = [[XIU_SearchBarSimulationView alloc] initWithFrame:CGRectMake(50, 7, KWIDTH - 2 * 60 , 30)];
    [searchBarView bk_whenTapped:^{
        XIU_WeakSelf(self);
        [weakself.navigationController pushViewController:[[XIU_SearchBarViewController alloc] init] animated:YES];
    }];
    self.navigationItem.titleView = searchBarView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
