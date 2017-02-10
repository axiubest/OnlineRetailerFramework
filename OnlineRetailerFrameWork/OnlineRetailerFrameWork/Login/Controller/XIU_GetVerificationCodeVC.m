//
//  XIU_GetVerificationCodeVC.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/7.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_GetVerificationCodeVC.h"

static id _instance = nil;
@interface XIU_GetVerificationCodeVC ()
{
    NSInteger _count;
    NSTimer *_Timer;
}
@property (nonatomic, weak)UITextField *VerificationField;


@property (nonatomic, weak)UIButton *nextButton;

@property (nonatomic, weak)UIButton *getVerificationNum;


@end

@implementation XIU_GetVerificationCodeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"手机快速注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self creatSubView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatSubView {
    UILabel *topLab = [[UILabel alloc] init];
    topLab.text = [NSString stringWithFormat:@"请输入%@收到的短信验证码", _PhoneNumberStr];
    topLab.font = [UIFont systemFontOfSize:14.f];
    [self.view addSubview:topLab];
    
    UITextField *VerificationField = [[UITextField alloc] init];
    VerificationField.placeholder = @"   请输入验证码";
    VerificationField.keyboardType = UIKeyboardTypePhonePad;
    VerificationField.backgroundColor = [UIColor whiteColor];
    [VerificationField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    VerificationField.clearButtonMode = 1;
    [SV addSubview:VerificationField];
    _VerificationField = VerificationField;
    
    UIButton *getVerificationNum = [[UIButton alloc] init];
    [getVerificationNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerificationNum.titleLabel.font = [UIFont systemFontOfSize:15];
    getVerificationNum.tintColor = [UIColor whiteColor];
    getVerificationNum.backgroundColor = [UIColor colorWithHexString:@"#F2302F"];
    [getVerificationNum addTarget:self action:@selector(chickedGetVerificationBtn:) forControlEvents:UIControlEventTouchUpInside];
    getVerificationNum.userInteractionEnabled = YES;
    [SV addSubview:getVerificationNum];
    _getVerificationNum = getVerificationNum;
    
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.enabled = NO;
    [nextButton setTintColor:[UIColor grayColor]];
    [nextButton setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [nextButton addTarget:self action:@selector(chickedNextButton) forControlEvents:UIControlEventTouchUpInside];
    [SV addSubview:nextButton];
    _nextButton = nextButton;

    
//-----------masonry layout------------
    
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(300, 15));
        make.top.offset(40);
        make.left.offset(20);
    }];
    
    [VerificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(LAND_CONTORL_HEIGHT);
        make.left.offset(20);
        make.top.equalTo(topLab.mas_bottom).with.offset(15);
        make.width.offset(KWIDTH / 2);
    }];

    [getVerificationNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerificationField.mas_right).with.offset(10);
        make.right.offset(-20);
        make.height.offset(LAND_CONTORL_HEIGHT);
        make.top.equalTo(VerificationField.mas_top);
    }];
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SV).with.offset(20);
        make.right.equalTo(SV).with.offset(-20);
        make.height.offset(LAND_CONTORL_HEIGHT);
        make.top.equalTo(getVerificationNum.mas_bottom).with.offset(30);
        
    }];

}

-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length != 0) {
        [self.nextButton setBackgroundColor:[UIColor redColor]];
        self.nextButton.enabled = YES;
        [self.nextButton setTintColor:[UIColor whiteColor]];
    }else {
        [self.nextButton setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
        [self.nextButton setTintColor:[UIColor grayColor]];
        self.nextButton.enabled = NO;
        
    }
}


#pragma mark 点击获取验证码按钮
- (void)chickedGetVerificationBtn:(UIButton *)sender{
    _count = 60;
    sender.enabled = NO;
    sender.backgroundColor = [UIColor lightGrayColor];
    sender.tintColor = [UIColor darkGrayColor];
   _Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
 
}

-(void)timerFired:(NSTimer *)timer
{
    if (_count !=1) {
        _count -=1;
        [self.getVerificationNum setTitle:[NSString stringWithFormat:@"%ld  秒",_count] forState:UIControlStateNormal];
        NSLog(@"%ld", _count);
    }
    else
    {
        [timer invalidate];
        self.getVerificationNum.enabled = YES;
        [self.getVerificationNum setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getVerificationNum.backgroundColor = [UIColor redColor];
        self.getVerificationNum.tintColor = [UIColor whiteColor];
        
    }
}

//下一步按钮
- (void)chickedNextButton {
    NSLog(@"下一步");
}

-(void)dealloc {
    [self invaldateTimer];
}

- (void)invaldateTimer {
    [_Timer invalidate];
    _Timer = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [self invaldateTimer];
}


@end
