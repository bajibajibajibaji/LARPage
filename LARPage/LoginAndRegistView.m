//
//  LoginAndRegistView.m
//  LARPage
//
//  Created by 朱志先 on 16/6/24.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "LoginAndRegistView.h"
#import "NSString+ZXAdd.h"
#import <Masonry.h>
#import "NSString+ZXAdd.h"

@interface LoginAndRegistView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *phoneNumberTextFieldBackgroud;
@property (nonatomic, strong) UIImageView *passwordtextFieldBackgroud;

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UIButton *QQButton;
@property (nonatomic, strong) UIButton *weChatButton;
@property (nonatomic, strong) UIButton *weicoButton;

@property (nonatomic, strong) UIButton *forgetPaddwordButton;

@property (nonatomic, strong) UIButton *useDynamicPasswordButton;
@property (nonatomic, strong) UIButton *usePasswordButton;

@property (nonatomic, strong) UIButton *getDynamicPasswordButton;

@property (nonatomic, strong) UIButton *agreeProtocolButton;
@property (nonatomic, strong) UIButton *readProtocolButton;

@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIImageView *phoneIcon;
@property (nonatomic, strong) UIImageView *shieldIcon;
@property (nonatomic, strong) UIImageView *lockIcon;


@property (nonatomic, strong) UIImage *grayInputBackgroud;
@property (nonatomic, strong) UIImage *redInputBackgroud;
@property (nonatomic, strong) UIImage *greenInputBackgroud;

@property (nonatomic, strong) UIImageView *bottle;
@property (nonatomic, strong) UIImageView *titleView;

@property (nonatomic, assign) LoginAndRegistViewState state;
@property (nonatomic, assign) BOOL  isAgreeProtocol;

@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) BOOL securityInput;

@property (nonatomic, strong)  UIButton *eyeButton;

@property (nonatomic, assign) NSInteger timeConut;


@end

@implementation LoginAndRegistView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.securityInput = NO;
        self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;
        self.keyBoardDidAppear = NO;
#pragma mark - 初始化动态密码登录界面元素
        self.grayInputBackgroud = kGetImage(@"Input box1.png");
        self.greenInputBackgroud = kGetImage(@"Input box2.png");
        self.redInputBackgroud = kGetImage(@"Input box3.png");
        
        LoginAndRegistView *superview = self;
        self.backgroundColor = [UIColor clearColor];
        
        
#pragma mark - 设置背景图和瓶子
        UIImageView *background2 = [[UIImageView alloc]init];
        background2.layer.contentsCenter = CGRectMake(0, 0.5, 1, 0.1);
        background2.image = [UIImage imageNamed:@"background2"];
        [self addSubview:background2];
        [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(superview);
            make.top.equalTo(superview).offset(45 * self.ratio);
        }];
        
        
        
        self.bottle = [[UIImageView alloc]init];
        self.bottle.image = kGetImage(@"Bottle1.png");
        [self addSubview:self.bottle];
        [self.bottle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(75 * self.ratio);
            make.width.equalTo(72 * self.ratio);
            make.top.equalTo(superview);
            make.centerX.equalTo(superview.centerX).offset(-62 * self.ratio);
        }];
        
        UIImageView *background1 = [[UIImageView alloc]init];
        background1.image = [UIImage imageNamed:@"background1"];
        background1.layer.contentsCenter = CGRectMake(0, 0.5, 1, 0.1);
        [self addSubview:background1];
        [background1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(superview);
            make.top.equalTo(superview).offset(45 * self.ratio);
        }];
        
        
        
        self.loginButton = [[UIButton alloc]init];
        [self addSubview:self.loginButton];
        
        self.registButton = [UIButton new];
        [self addSubview:self.registButton];
        
        
        self.phoneIcon = [UIImageView new];
        [self addSubview:self.phoneIcon];
        
        self.shieldIcon = [UIImageView new];
        [self addSubview:self.shieldIcon];
        
        
        self.phoneNumberTextFieldBackgroud = [UIImageView new];
        self.phoneNumberTextFieldBackgroud.image = self.grayInputBackgroud;
        [self addSubview:self.phoneNumberTextFieldBackgroud];
        
        
        self.phoneNumberTextField = [UITextField new];
        [self addSubview:self.phoneNumberTextField];
        self.phoneNumberTextField.delegate = self;
        
        self.passwordtextFieldBackgroud = [UIImageView new];
        self.passwordtextFieldBackgroud.image = self.grayInputBackgroud;
        [self addSubview:self.passwordtextFieldBackgroud];
        
        self.passwordTextField = [UITextField new];
        [self addSubview:self.passwordTextField];
        self.passwordTextField.delegate = self;
        
        
        self.getDynamicPasswordButton = [UIButton new];
        [self addSubview:self.getDynamicPasswordButton];
        
        self.eyeButton = [UIButton new];
        [self addSubview:self.eyeButton];
        
        self.usePasswordButton = [UIButton new];
        [self addSubview:self.usePasswordButton];
        
        self.useDynamicPasswordButton = [UIButton new];
        [self addSubview:self.useDynamicPasswordButton];
        
        self.forgetPaddwordButton = [UIButton new];
        [self addSubview:self.forgetPaddwordButton];
        
        self.agreeProtocolButton = [UIButton new];
        [self addSubview:self.agreeProtocolButton];
        
        self.readProtocolButton = [UIButton new];
        [self addSubview:self.readProtocolButton];
        
        self.titleView = [[UIImageView alloc]init];
        [self addSubview:self.titleView];
        
        self.weicoButton = [UIButton new];
        [self addSubview:self.weicoButton];
        
        self.QQButton  =[UIButton new];
        [self addSubview:self.QQButton];
        
        self.weChatButton = [UIButton new];
        [self addSubview:self.weChatButton];
        
        
        
        
#pragma mark - 设置约束，及样式
        //设置登录按钮
        [self.loginButton setBackgroundImage:kGetImage(@"denglu.png") forState:(UIControlStateNormal)];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(75 * self.ratio);
            make.width.equalTo(72 * self.ratio);
            make.top.equalTo(superview);
            make.centerX.equalTo(superview.centerX).offset(-62 * self.ratio);
        }];
        [self.loginButton addTarget:self action:@selector(tapLogin:) forControlEvents:(UIControlEventTouchUpInside)];
        
        //设置注册按钮
        [self.registButton setBackgroundImage:kGetImage(@"zhuce.png") forState:(UIControlStateNormal)];
        [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(75 * self.ratio);
            make.width.equalTo(72 * self.ratio);
            make.top.equalTo(superview);
            make.centerX.equalTo(superview.centerX).offset(62 * self.ratio);
        }];
        [self.registButton addTarget:self action:@selector(tapRegistButton:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        
        //设置电话图标
        self.phoneIcon.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:@"phone.png"]];
        [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(50 * self.ratio, 50 * self.ratio));
            make.left.equalTo(superview.left).offset(15 * self.ratio);
            make.top.equalTo(superview.loginButton.bottom).offset(10 * self.ratio);
        }];
        
        //手机号输入框背景
        [self.phoneNumberTextFieldBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.phoneIcon.right).offset(5 * self.ratio);
            make.right.equalTo(superview).offset(- 20 * self.ratio);
            make.top.equalTo(superview.phoneIcon.top);
            make.height.equalTo(superview.phoneIcon.height);
        }];
        
        //设置手机号输入框
        self.phoneNumberTextField.placeholder = @"请输入手机号";
        self.phoneNumberTextField.keyboardAppearance = UIKeyboardAppearanceDark;
        self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
        self.phoneNumberTextField.tag = 100;
        [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.phoneNumberTextFieldBackgroud.left).offset(10 * self.ratio);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right).offset(- 10 * self.ratio);
            make.top.equalTo(superview.phoneIcon.top);
            make.height.equalTo(superview.phoneIcon.height);
        }];
        
        //设置盾牌图标
        self.shieldIcon.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:@"Dynamic code.png"]];
        [self.shieldIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(superview.phoneIcon);
            make.left.equalTo(superview.phoneIcon.left);
            make.top.equalTo(superview.phoneIcon.bottom).offset(15 * self.ratio);
        }];
        
        //密码输入框背景
        [self.passwordtextFieldBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.phoneNumberTextFieldBackgroud.left);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right);
            make.top.equalTo(superview.shieldIcon.top);
            make.height.equalTo(superview.shieldIcon.height);
        }];
        
        
        //设置密码输入框
        self.passwordTextField.keyboardAppearance = UIKeyboardAppearanceDark;
        self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        self.passwordTextField.tag = 1000;
        self.passwordTextField.returnKeyType = UIReturnKeyDone;
        self.passwordTextField.enablesReturnKeyAutomatically = YES;
        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.phoneNumberTextField.left);
            make.right.equalTo(superview.phoneNumberTextField.right).offset(- 80 * self.ratio);
            make.top.equalTo(superview.shieldIcon.top);
            make.height.equalTo(superview.shieldIcon.height);
        }];
        
        //设置获取动态密码按钮
        [self.getDynamicPasswordButton setBackgroundImage:kGetImage(@"Button.png") forState:UIControlStateNormal];
        [self.getDynamicPasswordButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        self.getDynamicPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio weight:2];
        self.getDynamicPasswordButton.titleLabel.numberOfLines = 0;
        self.getDynamicPasswordButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.getDynamicPasswordButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.getDynamicPasswordButton addTarget:self action:@selector(tapGetDynamicPasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.getDynamicPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(80 * self.ratio);
            make.height.equalTo(36 * self.ratio);
            make.top.equalTo(superview.passwordTextField.mas_top).offset(7 * self.ratio);
            make.right.equalTo(superview.passwordtextFieldBackgroud.mas_right).offset(-7 * self.ratio);
        }];
        
        //设置眼睛按钮
        [self.eyeButton setBackgroundImage:kGetImage(@"eyeclose.png") forState:(UIControlStateNormal)];
        self.eyeButton.hidden = YES;
        [self.eyeButton addTarget:self action:@selector(tapEyeButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(36);
            make.top.right.equalTo(superview.getDynamicPasswordButton);
        }];
        
        
        //设置使用密码登录按钮
        [self.usePasswordButton setTitle:@"使用密码登录" forState:(UIControlStateNormal)];
        self.usePasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.usePasswordButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.usePasswordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.usePasswordButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.usePasswordButton addTarget:self action:@selector(tapUsePasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.usePasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100 * self.ratio);
            make.height.equalTo(13 * self.ratio);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right);
            make.top.equalTo(superview.passwordTextField.mas_bottom).offset(9 * self.ratio);
        }];
        
        //设置使用动态密码登录按钮
        [self.useDynamicPasswordButton setTitle:@"动态密码登录" forState:(UIControlStateNormal)];
        self.useDynamicPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.useDynamicPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.useDynamicPasswordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.useDynamicPasswordButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.useDynamicPasswordButton addTarget:self action:@selector(tapDynamicPasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.useDynamicPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100 * self.ratio);
            make.height.equalTo(13 * self.ratio);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right);
            make.top.equalTo(superview.passwordTextField.mas_bottom).offset(9);
        }];
        
        //设置忘记密码按钮
        [self.forgetPaddwordButton setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        self.forgetPaddwordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.forgetPaddwordButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.forgetPaddwordButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.forgetPaddwordButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.forgetPaddwordButton addTarget:self action:@selector(tapForgetPasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.forgetPaddwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(13 * self.ratio);
            make.width.equalTo(100 * self.ratio);
            make.top.equalTo(superview.usePasswordButton);
            make.left.equalTo(superview.shieldIcon.left);
        }];
        
        
        //设置同意协议按钮
        [self.agreeProtocolButton setTitle:@" 我已同意并阅读" forState:(UIControlStateNormal)];
        self.agreeProtocolButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.agreeProtocolButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.agreeProtocolButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.agreeProtocolButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.agreeProtocolButton setImage:[UIImage imageNamed:@"Check1"] forState:(UIControlStateNormal)];
        [self.agreeProtocolButton addTarget:self action:@selector(tapAgreeProtocolButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.agreeProtocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(13 * self.ratio);
            make.width.equalTo(110 * self.ratio);
            make.top.equalTo(superview.usePasswordButton);
            make.left.equalTo(superview.shieldIcon.left);
        }];
        
        //设置阅读分贝协议按钮
        [self.readProtocolButton setTitle:@" 分贝用户协议" forState:(UIControlStateNormal)];
        self.readProtocolButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.readProtocolButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.readProtocolButton setTitleColor:[UIColor colorWithRed:1 green:0.2 blue:0.1 alpha:0.7] forState:(UIControlStateNormal)];
        [self.readProtocolButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.readProtocolButton addTarget:self action:@selector(tapReadProtocolButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.readProtocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(13 * self.ratio);
            make.width.equalTo(100 * self.ratio);
            make.top.equalTo(superview.usePasswordButton);
            make.left.equalTo(superview.shieldIcon.left).offset(101 * self.ratio);
        }];
        

        
        
        //设置关联登录标题
        self.titleView.image = kGetImage(@"relation.png");
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superview);
            make.height.equalTo(20 * self.ratio);
            make.top.equalTo(superview.usePasswordButton.bottom).offset(8 * self.ratio);
        }];
        
        //设置微博按钮
        [self.weicoButton setBackgroundImage:kGetImage(@"weibo relation.png") forState:(UIControlStateNormal)];
        [self.weicoButton addTarget:self action:@selector(tapWeico) forControlEvents:(UIControlEventTouchUpInside)];
        [self.weicoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(50 * self.ratio);
            make.top.equalTo(superview.titleView.bottom).offset(8 * self.ratio);
            make.right.equalTo(superview.QQButton.left).offset(-27 * self.ratio);
            
        }];
        
        //设置QQ按钮
        [self.QQButton setBackgroundImage:kGetImage(@"QQrelation.png") forState:(UIControlStateNormal)];
        [self.QQButton addTarget:self action:@selector(tapQQ) forControlEvents:(UIControlEventTouchUpInside)];
        [self.QQButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(superview.weicoButton);
            make.top.equalTo(superview.weicoButton.top);
            make.centerX.equalTo(superview.centerX);
        }];
        
        //设置微信按钮
        [self.weChatButton setBackgroundImage:kGetImage(@"WeChat relation.png") forState:(UIControlStateNormal)];
        [self.weChatButton addTarget:self action:@selector(tapWeChat) forControlEvents:(UIControlEventTouchUpInside)];
        [self.weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(superview.weicoButton);
            make.top.equalTo(superview.weicoButton.top);
            make.left.equalTo(superview.QQButton.mas_right).offset(27 * self.ratio);
        }];
        
        self.state = DynamicPasswordLogin;
        
        
        
    }
    return self;
}


#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length + string.length > 11 && textField.tag == 100)
    {
        return NO;
    }
    
    if (textField.text.length + string.length > 6 && textField.tag == 1000 && self.state != NormalPasswordLogin)
    {
        return NO;
    }
    
    if (textField.text.length + string.length > 18 && textField.tag == 1000 && self.state == NormalPasswordLogin)
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    switch (self.state) {
        case RegistState:
            if ([self.delegate respondsToSelector:@selector(loginAndRegistView:PrepareToRegistWithPhone:AndDynamicPassword:isAgreeProtocol:)])
            {
                [self.delegate loginAndRegistView:self PrepareToRegistWithPhone:self.phoneNumberTextField.text AndDynamicPassword:self.passwordTextField.text isAgreeProtocol:self.isAgreeProtocol];
            }
            
            break;
            
        case DynamicPasswordLogin:
            if ([self.delegate respondsToSelector:@selector(loginAndRegistView:PrepareToLoginWithPhone:AndDynamicPassword:)])
            {
                [self.delegate loginAndRegistView:self PrepareToLoginWithPhone:self.phoneNumberTextField.text AndDynamicPassword:self.passwordTextField.text];
            }
            break;
            
        case NormalPasswordLogin:
            if ([self.delegate respondsToSelector:@selector(loginAndRegistView:PrepareToLoginWithPhone:AndNormalPassword:)])
            {
                [self.delegate loginAndRegistView:self PrepareToLoginWithPhone:self.phoneNumberTextField.text AndNormalPassword:self.passwordTextField.text];
            }
            
        default:
            break;
    }
    return YES;
}



#pragma mark - Button SEL
- (void)tapLogin:(UIButton *)loginButton
{
    if (self.state == RegistState)
    {
        if ([self.delegate respondsToSelector:@selector(loginAndRegistViewChangeToLogin:)])
        {
            [self.delegate loginAndRegistViewChangeToLogin:self];
        }
        self.state = DynamicPasswordLogin;
        [self bottleMoveleft];
        if (!(self.keyBoardDidAppear && self.ratio != 1)) {
            [self stretchView];
        }
    }
}


- (void)tapRegistButton:(UIButton*)registButton
{
    
    if (self.state == DynamicPasswordLogin || self.state == NormalPasswordLogin )
    {
        if ([self.delegate respondsToSelector:@selector(loginAndRegistViewChangeToRegist:)])
        {
            [self.delegate loginAndRegistViewChangeToRegist:self];
        }
        self.state = RegistState;
        [self bottleMoveRight];
        [self compressView];
    }
}



- (void) tapGetDynamicPasswordButton:(UIButton *)button
{
    self.getDynamicPasswordButton.enabled = NO;
    self.timeConut = 15;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
    switch (self.state) {
        case DynamicPasswordLogin:
            if ([self.delegate respondsToSelector:@selector(loginAndRegistViewGetLonginDynamicPassword:WithPhoneNumber:)])
            {
                [self.delegate loginAndRegistViewGetLonginDynamicPassword:self WithPhoneNumber:self.phoneNumberTextField.text];
            }
            
            break;
        case RegistState:
            if ([self.delegate respondsToSelector:@selector(loginAndRegistViewGetRegistDynamicPassword:WithPhoneNumber:)])
            {
                [self.delegate loginAndRegistViewGetRegistDynamicPassword:self WithPhoneNumber:self.phoneNumberTextField.text];
            }
            
            break;
        default:
            break;
    }
}

- (void) tapEyeButton:(UIButton *)button
{
    self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
    if (self.passwordTextField.secureTextEntry) {
        [self.eyeButton setBackgroundImage:kGetImage(@"eyeclose.png") forState:(UIControlStateNormal)];
    }else
    {
        [self.eyeButton setBackgroundImage:kGetImage(@"eyeopen.png") forState:(UIControlStateNormal)];
    }
}

- (void) tapUsePasswordButton:(UIButton *)button
{
    self.state = NormalPasswordLogin;
}

- (void) tapDynamicPasswordButton:(UIButton *)button
{
    self.state = DynamicPasswordLogin;

    
}

- (void) tapForgetPasswordButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(loginAndRegistViewClickForgetPasswordButton:)])
    {
        [self.delegate loginAndRegistViewClickForgetPasswordButton:self];
    }
    
}

- (void) tapAgreeProtocolButton:(UIButton *)button
{
    self.isAgreeProtocol = !self.isAgreeProtocol;
    if (self.isAgreeProtocol) {
        [self.agreeProtocolButton setImage:[UIImage imageNamed:@"Check2"] forState:(UIControlStateNormal)];
    }
    else
    {
        [self.agreeProtocolButton setImage:[UIImage imageNamed:@"Check1"] forState:(UIControlStateNormal)];
    }
}

-(void) tapReadProtocolButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(loginAndRegistViewClickReadProtocol:)])
    {
        [self.delegate loginAndRegistViewClickReadProtocol:self];
    }
}

- (void) tapQQ
{
    if ([self.delegate respondsToSelector:@selector(loginAndRegistViewClickUseQQLoginButton:)]) {
        [self.delegate loginAndRegistViewClickUseQQLoginButton:self];
    }
}

- (void) tapWeico
{
    if ([self.delegate respondsToSelector:@selector(loginAndRegistViewClickUseWeicoLoginButton:)]) {
        [self.delegate loginAndRegistViewClickUseWeicoLoginButton:self];
    }
}

- (void) tapWeChat
{
    if ([self.delegate respondsToSelector:@selector(loginAndRegistViewClickUseWeChatLoginButton:)]) {
        [self.delegate loginAndRegistViewClickUseWeChatLoginButton:self];
    }
}


#pragma mark - 更改状态相关
- (void)setState:(LoginAndRegistViewState)state
{
    if (_state != state) {
        _state = state;
        switch (state) {
            case DynamicPasswordLogin:
                [self setForDynamicPasswordLoginStateAppearance];
                break;
            case NormalPasswordLogin:
                [self setForNormalPasswordLoginStateAppearance];
                break;
            case RegistState:
                [self setForRegistStateAppearance];
                break;
            default:
                break;
        }
    }
}

- (void)setForDynamicPasswordLoginStateAppearance
{
    
    self.readProtocolButton.hidden = YES;
    self.agreeProtocolButton.hidden = YES;
    self.forgetPaddwordButton.hidden = YES;
    self.useDynamicPasswordButton.hidden = YES;
    self.usePasswordButton.hidden = NO;
    self.eyeButton.hidden = YES;
    self.getDynamicPasswordButton.hidden = NO;
    
    self.passwordTextField.secureTextEntry = NO;
    self.passwordTextField.text = @"";
    self.passwordTextField.placeholder = @"请输入验证码";
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.shieldIcon.image = kGetImage(@"Dynamic code.png");


}

- (void)setForNormalPasswordLoginStateAppearance
{
    self.readProtocolButton.hidden = YES;
    self.agreeProtocolButton.hidden = YES;
    self.forgetPaddwordButton.hidden = NO;
    self.useDynamicPasswordButton.hidden = NO;
    self.usePasswordButton.hidden = YES;
    self.eyeButton.hidden = NO;
    self.getDynamicPasswordButton.hidden = YES;
    
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.text = @"";
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.placeholder = @"请输入密码";
    
    self.shieldIcon.image = kGetImage(@"password.png");

}

- (void) setForRegistStateAppearance
{
    self.readProtocolButton.hidden = NO;
    self.agreeProtocolButton.hidden = NO;
    self.forgetPaddwordButton.hidden = YES;
    self.useDynamicPasswordButton.hidden = YES;
    self.usePasswordButton.hidden = YES;
    self.eyeButton.hidden = YES;
    self.getDynamicPasswordButton.hidden = NO;
    
    self.passwordTextField.text = @"";
    self.passwordTextField.placeholder = @"请输入验证码";
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.shieldIcon.image = kGetImage(@"Dynamic code.png");
}

//
- (NSString *)phoneNumber
{
    return self.phoneNumberTextField.text;
}

- (NSString *)password
{
    return self.passwordTextField.text;
}

- (BOOL)agreeProtocol
{
    return self.isAgreeProtocol;
}

- (LoginAndRegistViewState)laState
{
    return self.state;
}


- (void)compressView
{
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(230 * self.ratio);
    }];
    
    [self.weicoButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(0);
    }];
    
    self.weicoButton.hidden = YES;
    self.QQButton.hidden = YES;
    self.weChatButton.hidden = YES;
    

    self.titleView.hidden = YES;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        [self layoutIfNeeded];
    } completion:nil];

}

- (void)stretchView
{
    self.titleView.hidden = NO;
    self.weicoButton.hidden = NO;
    self.QQButton.hidden = NO;
    self.weChatButton.hidden = NO;

    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(315 * self.ratio);
    }];
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished){
        [self.weicoButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(50 * self.ratio);
        }];
        
        [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            [self.QQButton layoutIfNeeded];
            [self.weChatButton layoutIfNeeded];
            [self.weicoButton layoutIfNeeded];
        } completion:nil];
        
    }];
    
}


- (void)bottleMoveleft
{
    [self.bottle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(- 62 * self.ratio);
    }];
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        [self.bottle layoutIfNeeded];
        [self layoutIfNeeded];
    } completion:nil];
}

- (void)bottleMoveRight
{
    [self.bottle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(62 * self.ratio);
    }];
    
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        [self.bottle layoutIfNeeded];
    } completion:nil];
   
}

- (void)countdown:(NSTimer *)timer
{
    self.timeConut = self.timeConut - 1;
    [self.getDynamicPasswordButton setTitle:[NSString stringWithFormat:@"%lds\n重新获取",self.timeConut] forState:(UIControlStateNormal)];
    if (self.timeConut == 0) {
        self.getDynamicPasswordButton.enabled = YES;
        [self.getDynamicPasswordButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [timer invalidate];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
