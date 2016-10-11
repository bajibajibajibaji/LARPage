//
//  ForgetPasswordView.m
//  LARPage
//
//  Created by 朱志先 on 16/6/26.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "ForgetPasswordView.h"
#import "NSString+ZXAdd.h"
#import <Masonry.h>
#import "NSString+ZXAdd.h"

@interface ForgetPasswordView () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UIImageView *phoneNumberTextFieldBackgroud;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *passwordtextFieldBackgroud;


@property (nonatomic, strong) UIImageView *phoneIcon;
@property (nonatomic, strong) UIImageView *shieldIcon;

@property (nonatomic, strong) UIButton *getDynamicPasswordButton;
@property (nonatomic, strong) UIButton *useEmailButton;
@property (nonatomic, strong) UIButton *usePhoneButton;

@property (nonatomic, strong) UIImageView *bottle;


@property (nonatomic, strong) UIImage *grayInputBackgroud;
@property (nonatomic, strong) UIImage *redInputBackgroud;
@property (nonatomic, strong) UIImage *greenInputBackgroud;

@property (nonatomic, assign) ForgetPasswordViewState state;
@property (nonatomic, assign) CGFloat ratio;

@end

@implementation ForgetPasswordView

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
        self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;
        
        self.grayInputBackgroud = kGetImage(@"Input box1.png");
        self.greenInputBackgroud = kGetImage(@"Input box2.png");
        self.redInputBackgroud = kGetImage(@"Input box3.png");
        
        ForgetPasswordView *superview = self;
        self.backgroundColor = [UIColor clearColor];
        
        
#pragma mark - 设置背景图和瓶子
        UIImageView *background2 = [[UIImageView alloc]init];
        background2.layer.contentsCenter = CGRectMake(0, 0.5, 1, 0.1);
        background2.image = [UIImage imageNamed:@"background2"];
        [self addSubview:background2];
        [background2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superview).insets(UIEdgeInsetsMake(65 * self.ratio, 0, 0, 0));
        }];
        
        
        
        self.bottle = [[UIImageView alloc]init];
        self.bottle.image = kGetImage(@"Retrieve.png");
        [self addSubview:self.bottle];
        [self.bottle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(115 * self.ratio);
            make.width.equalTo(111 * self.ratio);
            make.top.equalTo(superview);
            make.centerX.equalTo(superview.centerX).offset(0);
        }];
        
        UIImageView *background1 = [[UIImageView alloc]init];
        background1.layer.contentsCenter = CGRectMake(0, 0.5, 1, 0.1);
        background1.image = [UIImage imageNamed:@"background1"];
        [self addSubview:background1];
        [background1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superview).insets(UIEdgeInsetsMake(65 * self.ratio, 0, 0, 0));
        }];
        
        
        
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
        
        self.useEmailButton = [UIButton new];
        [self addSubview:self.useEmailButton];
        
        self.usePhoneButton = [UIButton new];
        [self addSubview:self.usePhoneButton];
        

        //设置电话图标
        self.phoneIcon.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:@"phone.png"]];
        [self.phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(50 * self.ratio, 50 * self.ratio));
            make.left.equalTo(superview.left).offset(15 * self.ratio);
            make.top.equalTo(superview.bottle.bottom).offset(-15 * self.ratio);
        }];
        
        //手机号输入框背景
        [self.phoneNumberTextFieldBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.phoneIcon.right).offset(5 * self.ratio);
            make.right.equalTo(superview).offset(- 20 * self.ratio);
            make.top.equalTo(superview.phoneIcon.top);
            make.height.equalTo(superview.phoneIcon.height);
        }];
        
        //设置手机号输入框
        self.phoneNumberTextField.placeholder = @"请输入手机号码";
        self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
        self.phoneNumberTextField.keyboardAppearance = UIKeyboardAppearanceDark;
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
        self.passwordTextField.placeholder = @"请输入验证码";
        self.passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.passwordTextField.keyboardAppearance = UIKeyboardTypeURL;
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
        [self.getDynamicPasswordButton addTarget:self action:@selector(tapGetDynamicPasswordButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.getDynamicPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(80 * self.ratio);
            make.height.equalTo(36 * self.ratio);
            make.top.equalTo(superview.passwordTextField.mas_top).offset(7 * self.ratio);
            make.right.equalTo(superview.passwordtextFieldBackgroud.mas_right).offset(-7 * self.ratio);
        }];
        
        //设置使用密码登录按钮
        [self.useEmailButton setTitle:@"使用邮箱验证" forState:(UIControlStateNormal)];
        self.useEmailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.useEmailButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.useEmailButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.useEmailButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.useEmailButton addTarget:self action:@selector(tapUseEmailButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.useEmailButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100 * self.ratio);
            make.height.equalTo(13 * self.ratio);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right);
            make.top.equalTo(superview.passwordTextField.mas_bottom).offset(7 * self.ratio);
        }];
        
        [self.usePhoneButton setTitle:@"使用手机验证" forState:(UIControlStateNormal)];
        self.usePhoneButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.usePhoneButton.titleLabel.font = [UIFont systemFontOfSize:12 * self.ratio];
        [self.usePhoneButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
        [self.usePhoneButton setTitleColor:[UIColor colorWithRed:0 green:91/256.0 blue:125.0/256.0 alpha:1] forState:(UIControlStateNormal)];
        [self.usePhoneButton addTarget:self action:@selector(tapUsePhoneButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.usePhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100 * self.ratio);
            make.height.equalTo(13 * self.ratio);
            make.right.equalTo(superview.phoneNumberTextFieldBackgroud.right);
            make.top.equalTo(superview.passwordTextField.mas_bottom).offset(7 * self.ratio);
        }];

        

        self.state = ForgetPasswordViewStateUsePhone;

    }
    
    return self;
}

#pragma mark - Button SEL

- (void)tapGetDynamicPasswordButton:(UIButton *)button
{
    switch (self.state) {
        case ForgetPasswordViewStateUseEmail:
            if ([self.delegate respondsToSelector:@selector(ForgetPasswordViewGetDynamicPassWord:WithEmail:)]) {
                [self.delegate ForgetPasswordViewGetDynamicPassWord:self WithEmail:self.phoneNumberTextField.text];
            }
            break;
        case ForgetPasswordViewStateUsePhone:
            if ([self.delegate respondsToSelector:@selector(ForgetPasswordViewGetDynamicPassWord:WithPhoneNumber:)]) {
                
                
                [self.delegate ForgetPasswordViewGetDynamicPassWord:self WithPhoneNumber:self.phoneNumberTextField.text];
            }
            break;
            
        default:
            break;
    }
}

- (void)tapUseEmailButton:(UIButton *) button
{
    self.state = ForgetPasswordViewStateUseEmail;
    self.phoneNumberTextField.placeholder = @"请输入电子邮箱";
}

- (void)tapUsePhoneButton:(UIButton *) button
{
    self.state = ForgetPasswordViewStateUsePhone;
    self.phoneNumberTextField.placeholder = @"请输入手机号";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    if (textField.tag == 1000)
    {
        
        switch (self.state) {
            case ForgetPasswordViewStateUseEmail:
                if ([self.delegate respondsToSelector:@selector(ForgetPasswordViewPrepareToVerify:WithEmail:AndPassword:)]) {
                    [self.delegate ForgetPasswordViewPrepareToVerify:self WithEmail:self.phoneNumberTextField.text AndPassword:self.passwordTextField.text];
                }
                break;
                
            case ForgetPasswordViewStateUsePhone:
                if ([self.delegate respondsToSelector:@selector(ForgetPasswordViewPrepareToVerify:WithPhoneNumber:AndPassword:)]) {
                    [self.delegate ForgetPasswordViewPrepareToVerify:self WithPhoneNumber:self.phoneNumberTextField.text AndPassword:self.passwordTextField.text];
                }
                break;
                
            default:
                break;
        }
    }
    return YES;
}

- (void)setState:(ForgetPasswordViewState)state
{
    if (_state != state) {
        _state = state;
        switch (state) {
            case ForgetPasswordViewStateUseEmail:
                self.usePhoneButton.hidden = NO;
                self.useEmailButton.hidden = YES;
                self.phoneNumberTextField.keyboardType = UIKeyboardTypeEmailAddress;
                break;
            case ForgetPasswordViewStateUsePhone:
                self.usePhoneButton.hidden = YES;
                self.useEmailButton.hidden = NO;
                self.phoneNumberTextField.keyboardType = UIKeyboardTypePhonePad;
                break;
            default:
                break;
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

@end
