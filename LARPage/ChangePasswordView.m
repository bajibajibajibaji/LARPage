//
//  ChangePasswordView.m
//  LARPage
//
//  Created by 朱志先 on 16/6/26.
//  Copyright © 2016年 朱志先. All rights reserved.
//

#import "ChangePasswordView.h"
#import "NSString+ZXAdd.h"
#import <Masonry.h>
#import "NSString+ZXAdd.h"
@interface ChangePasswordView() <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIImageView *passwordtextFieldBackgroud;

@property (nonatomic, strong) UIImageView *lockIcon;

@property (nonatomic, strong) UIButton *getDynamicPasswordButton;

@property (nonatomic, strong) UIImageView *bottle;

@property (nonatomic, strong) UIImage *grayInputBackgroud;

@property (nonatomic, assign) CGFloat ratio;
@end

@implementation ChangePasswordView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ratio = [UIScreen mainScreen].bounds.size.width > 320 ? 1 : 320/375.0;
        
        self.grayInputBackgroud = kGetImage(@"Input box1.png");

        
        ChangePasswordView *superview = self;
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
        self.bottle.image = kGetImage(@"change.png");
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
        
        
        
        self.lockIcon = [UIImageView new];
        [self addSubview:self.lockIcon];
        
        self.passwordtextFieldBackgroud = [UIImageView new];
        self.passwordtextFieldBackgroud.image = self.grayInputBackgroud;
        [self addSubview:self.passwordtextFieldBackgroud];
        
        self.passwordTextField = [UITextField new];
        [self addSubview:self.passwordTextField];
        self.passwordTextField.delegate = self;;
        
        self.getDynamicPasswordButton = [UIButton new];
        [self addSubview:self.getDynamicPasswordButton];

        
        //设置盾牌图标
        self.lockIcon.image = [UIImage imageWithContentsOfFile:[NSString adaptiveImagePathWithFullImageName:@"Dynamic code.png"]];
        [self.lockIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(50 * self.ratio, 50 * self.ratio));
            make.left.equalTo(superview.left).offset(15 * self.ratio);
            make.top.equalTo(superview.bottle.bottom).offset(-15 * self.ratio);
        }];
        
        //密码输入框背景
        [self.passwordtextFieldBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.lockIcon.right).offset(5 * self.ratio);
            make.right.equalTo(superview).offset(- 20 * self.ratio);
            make.top.equalTo(superview.lockIcon.top);
            make.height.equalTo(superview.lockIcon.height);
        }];
     
        //设置密码输入框
        self.passwordTextField.placeholder = @"请输入新密码";
        self.passwordTextField.keyboardType = UIKeyboardTypeWebSearch;
        self.passwordTextField.keyboardAppearance = UIKeyboardAppearanceDark;
        self.passwordTextField.tag = 1000;
        self.passwordTextField.returnKeyType = UIReturnKeyDone;
        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview.passwordtextFieldBackgroud.left).offset(10 * self.ratio);
            make.right.equalTo(superview.passwordtextFieldBackgroud.right).offset(- 10 * self.ratio);
            make.top.equalTo(superview.lockIcon.top);
            make.height.equalTo(superview.lockIcon.height);
        }];
        
        //设置获取动态密码按钮
        [self.getDynamicPasswordButton setBackgroundImage:kGetImage(@"eyeclose.png") forState:UIControlStateNormal];
        [self.getDynamicPasswordButton addTarget:self action:@selector(tapEyeIcon:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.getDynamicPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(36 * self.ratio);
            make.height.equalTo(36 * self.ratio);
            make.top.equalTo(superview.passwordTextField.mas_top).offset(7 * self.ratio);
            make.right.equalTo(superview.passwordtextFieldBackgroud.mas_right).offset(-7 * self.ratio);
        }];

        
    }
    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(ChangePasswordViewChangePassword:WithNewPassWord:)]) {
        [self.delegate ChangePasswordViewChangePassword:self WithNewPassWord:self.passwordTextField.text];
    }
    
    return YES;
}



- (void)tapEyeIcon:(UIButton *)button
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}



@end
