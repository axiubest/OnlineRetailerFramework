//
//  XIU_LoginViewController.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2016/12/29.
//  Copyright © 2016年 杨岫峰. All rights reserved.
//

#import "XIU_LoginViewController.h"
#import "XIU_ResignPhoneNumberVC.h"
#import "XIU_LoginService.h"

@interface XIU_LoginViewController ()
{
    BOOL IsPasswordHidden;
    BOOL _passwordIsValid;
    BOOL _usernameIsValid;
}


/**
 AccountBottomLine
 */
@property (weak, nonatomic) IBOutlet UIView *AccountBottomLine;


/**
 PasswordBottomLine
 */
@property (weak, nonatomic) IBOutlet UIView *PswBottomLine;


@property (strong, nonatomic) XIU_LoginService *signInService;
/**
 Phone Number TextFfield
 */
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumTextField;


/**
 Password TextField
 */
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;


/**
 Password Hidden Button
 */
@property (weak, nonatomic) IBOutlet UIButton *PasswordHiddenButton;


/**
 Login Button
 */
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;


/**
 Register Button
 */
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;


/**
 Forget Password Button
 */
@property (weak, nonatomic) IBOutlet UIButton *ForgetPasswordButton;


/**
 WeChat Share View
 */
@property (weak, nonatomic) IBOutlet UIView *WeChatView;

/**
 QQ Share View
 */
@property (weak, nonatomic) IBOutlet UIView *QQView;

/**
 Weibo Share View
 */
@property (weak, nonatomic) IBOutlet UIView *WeiboView;

@end

@implementation XIU_LoginViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.navigationItem.title = @"登 录";
    
    [self addTapRecognizerOfShareView];

    [self updateUIState];

    self.signInService = [XIU_LoginService new];

    [self.PhoneNumTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self.PasswordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];

}

- (void)updateUIState {
    self.AccountBottomLine.backgroundColor = _usernameIsValid ? [UIColor greenColor] : [UIColor lightGrayColor];
    self.PswBottomLine.backgroundColor = _passwordIsValid ? [UIColor greenColor] : [UIColor lightGrayColor];
    self.LoginButton.enabled = _usernameIsValid && _passwordIsValid;
    self.LoginButton.backgroundColor = _usernameIsValid && _passwordIsValid ? [UIColor redColor] : [UIColor lightGrayColor];
}

- (void)usernameTextFieldChanged {
    _usernameIsValid = [self isValidUsername:self.PhoneNumTextField.text];
    [self updateUIState];
}

- (void)passwordTextFieldChanged {
    _passwordIsValid = [self isValidPassword:self.PasswordTextField.text];
    [self updateUIState];
}

#pragma mark password&username  standard setting
- (BOOL)isValidUsername:(NSString *)username {
    return username.length == 11;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 5 && password.length < 15;
}

- (void)addTapRecognizerOfShareView {
    
    [self addGestureRecognizerWithView:_WeiboView];
    [self addGestureRecognizerWithView:_QQView];
    [self addGestureRecognizerWithView:_WeiboView];

}

- (void)addGestureRecognizerWithView:(UIView *)view {
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chickedShareView:)]];
}

#pragma mark chicked login button method
- (IBAction)chickedLoginBtn:(id)sender {
    
    [self.signInService signInWithUsername:self.PhoneNumTextField.text
  password:self.PasswordTextField.text
  complete:^(BOOL success) {
      self.LoginButton.enabled = !success;
      if (success) {
          __weak typeof(self) weakSelf = self;
          NSLog(@"login_success%@",kPathCache);
          [_XIUDelegate login];
          [weakSelf.navigationController popViewControllerAnimated:YES];
 
      }
  }];
    
    

}

#pragma mark chciked register button method
- (IBAction)chickedRegisterBtn:(id)sender {
    
    [self.navigationController pushViewController:[[XIU_ResignPhoneNumberVC alloc] init] animated:YES];

}

#pragma makr chicked forget password button
- (IBAction)chickedForgetPasswordBtn:(id)sender {
    
}


- (void)chickedShareView:(UIView *)views {
    

    switch (views.tag) {
            
            
        case 1000:
            NSLog(@"微信分享");
            break;
        case 1001:
            NSLog(@"QQ分享");

            break;
        case 1002:
            NSLog(@"微博分享");
            break;

        default:
            break;
    }
}

#pragma mark chicked password hidden button
- (IBAction)chickedHiddenPasswordButton:(id)sender {

    if (IsPasswordHidden) {
        [sender setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
        _PasswordTextField.secureTextEntry = YES;
    }else {
       [sender setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
        _PasswordTextField.secureTextEntry = NO;

    }
    IsPasswordHidden = !IsPasswordHidden;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_PasswordTextField endEditing:YES];
    [_PhoneNumTextField endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
