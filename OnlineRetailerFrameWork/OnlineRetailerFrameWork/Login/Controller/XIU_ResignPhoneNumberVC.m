//
//  XIU_ResignPhoneNumberVC.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/6.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ResignPhoneNumberVC.h"

#import "XIU_CountryCodeViewController.h"

#import "XIU_GetVerificationCodeVC.h"

#import "XIU_GraphicVerificationView.h"


#import "NSString+TextField.h"
@interface XIU_ResignPhoneNumberVC ()


/**
 手机号地区
 */
@property (nonatomic, weak)UILabel *localLab;


/**
 手机号
 */
@property (nonatomic, weak)UITextField *PhoneNumField;


@property (nonatomic, weak)UITextField *verificationField;

/**
 下一步
 */
@property (nonatomic, weak)UIButton *nextButton;

@property (nonatomic, weak)XIU_GraphicVerificationView *graphicVerificView;
@end

@implementation XIU_ResignPhoneNumberVC
{
    BOOL _isAgreeDelegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手机快速注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    [self setUpUIView];
}


- (void)setUpUIView {

    
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    [SV addSubview:phoneView];
    
    UIView *VerificationView = [[UIView alloc] init];
    VerificationView.backgroundColor = [UIColor whiteColor];
    [SV addSubview:VerificationView];

    
    UILabel *localLab = [[UILabel alloc] init];
    localLab.text = @"+86";
    localLab.textAlignment = 1;
    localLab.userInteractionEnabled = YES;
    [phoneView addSubview:localLab];
    [localLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chickedLocalLab)]];
    self.localLab = localLab;

    UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_buttom"]];
    arrowView.userInteractionEnabled = YES;
    [arrowView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chickedLocalLab)]];
    [phoneView addSubview:arrowView];
    
    UITextField *PhoneNumField = [[UITextField alloc] init];
    PhoneNumField.placeholder = @"请输入手机号";
    PhoneNumField.keyboardType = UIKeyboardTypePhonePad;
    [PhoneNumField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    PhoneNumField.clearButtonMode = 1;
    PhoneNumField.font = [UIFont systemFontOfSize:15];
    [phoneView addSubview:PhoneNumField];
    self.PhoneNumField  = PhoneNumField;
    
    
   //图形验证码
    XIU_GraphicVerificationView *graphicVerificView = [[XIU_GraphicVerificationView alloc] init];
    [self.view addSubview:graphicVerificView];
    graphicVerificView.backgroundColor = [UIColor whiteColor];
    self.graphicVerificView = graphicVerificView;
    
    
    UITextField *verificationField = [[UITextField alloc] init];
    verificationField.placeholder = @"请输入验证码";
    verificationField.clearButtonMode = 1;
    [SV addSubview:verificationField];
    _verificationField = verificationField;
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    nextButton.enabled = NO;
    [nextButton setTintColor:[UIColor grayColor]];
    [nextButton setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
    [nextButton addTarget:self action:@selector(chickedNextButton) forControlEvents:UIControlEventTouchUpInside];
    [SV addSubview:nextButton];
    self.nextButton = nextButton;
    
    UIButton *AgreeDelegateImageBtn = [[UIButton alloc] init];
    [AgreeDelegateImageBtn setImage:[UIImage imageNamed:@"yes_btn_select"] forState:UIControlStateNormal];
    _isAgreeDelegate = YES;
    [AgreeDelegateImageBtn addTarget:self action:@selector(chickedAgreeDelegateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AgreeDelegateImageBtn];
    
    
    UILabel *DelegateLab = [[UILabel alloc] init];
    DelegateLab.textColor = [UIColor grayColor];
    DelegateLab.font = [UIFont systemFontOfSize:14.f];
    [DelegateLab addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chickedDelegateLabel)]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"同意XX用户注册协议"];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor blackColor]
                          range:NSMakeRange(2, 8)];
    
    DelegateLab.attributedText = AttributedStr;
    DelegateLab.userInteractionEnabled = YES;
    [self.view addSubview:DelegateLab];
 
/**massory layout*/
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SV).with.offset(20);
        make.right.equalTo(SV).with.offset(-20);
        make.top.equalTo(SV).with.offset(100);
        make.height.offset(LAND_CONTORL_HEIGHT);
    }];
    
   
    [localLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(phoneView).with.offset(0);
        make.height.equalTo(phoneView);
        make.width.offset(60);
    }];
    

    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.localLab.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18,15));
        make.left.equalTo(self.localLab.mas_right).with.offset(0);
    }];
    
    [PhoneNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.right.equalTo(phoneView).with.offset(0);
        make.left.equalTo(arrowView.mas_right).with.offset(10);
    }];
    
    
    [VerificationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SV).with.offset(20);
        make.right.equalTo(SV).with.offset(-20);
        make.height.equalTo(phoneView);
        make.top.equalTo(phoneView.mas_bottom).with.offset(30);
        
    }];
    
    [graphicVerificView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(VerificationView).with.offset(-20);
        make.top.equalTo(VerificationView).with.offset(5);
        make.bottom.equalTo(VerificationView).with.offset(-5);
        make.width.offset(60);
    }];
    
    [verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerificationView).with.offset(20);
        make.right.equalTo(graphicVerificView.mas_left).with.offset(-15);
        make.top.equalTo(VerificationView).with.offset(8);
        make.bottom.equalTo(VerificationView).with.offset(-8);

    }];
    
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SV).with.offset(20);
        make.right.equalTo(SV).with.offset(-20);
        make.height.equalTo(phoneView);
        make.top.equalTo(VerificationView.mas_bottom).with.offset(30);
        
    }];
    
    [AgreeDelegateImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneView.mas_left);
        make.top.equalTo(nextButton.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(20,20));
    }];

    [DelegateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AgreeDelegateImageBtn.mas_centerY);
        make.left.equalTo(AgreeDelegateImageBtn.mas_right).with.offset(10);
        make.right.equalTo(SV).with.offset(0);
        make.height.offset(15);
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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


#pragma mark 手机号区域选择
- (void)chickedLocalLab {
    XIU_CountryCodeViewController *countryCode = [[XIU_CountryCodeViewController alloc] init];
    [countryCode toReturnCountryCode:^(NSString *countryCodeStr) {
        self.localLab.text = [[countryCodeStr componentsSeparatedByString:@" "] lastObject];
        
    }];
    [self.navigationController pushViewController:countryCode animated:YES];


}


#pragma mark 是否同意用户注册协议
- (void)chickedAgreeDelegateBtn:(UIButton *)sender {
    _isAgreeDelegate = !_isAgreeDelegate;
    _isAgreeDelegate == YES ? [sender setImage:[UIImage imageNamed:@"yes_btn_select"] forState:UIControlStateNormal] : [sender setImage:[UIImage imageNamed:@"yes_btn_unselect"] forState:UIControlStateNormal];
}

#pragma mark 查看协议
- (void)chickedDelegateLabel {
    NSLog(@"push to html");
}

#pragma mark 下一步按钮
- (void)chickedNextButton {
    if (_isAgreeDelegate == NO) {
        NSLog(@"请同意用户协议");
        return;
    }
    if (!([_verificationField.text caseInsensitiveCompare:self.graphicVerificView.changeString] == NSOrderedSame)) {
        [self.graphicVerificView randomNumber];
        [self.graphicVerificView setNeedsDisplay];

        NSLog(@"验证码错误");
        
        return;
    }
//    if (![NSString valiMobile:self.PhoneNumField.text]) {
//        NSLog(@"手机号码格式错误");
//        return;
//    }
    NSLog(@"手机号输入正确进入网络请求判断手机号是否可以绑定");
    XIU_GetVerificationCodeVC *verification = [[XIU_GetVerificationCodeVC alloc] init];
    verification.PhoneNumberStr = self.PhoneNumField.text;
    [self.navigationController pushViewController:verification animated:YES];
}
@end
