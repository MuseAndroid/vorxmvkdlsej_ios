//
//  FFReBuildPasswordView.m
//  factFinder
//
//  Created by Hong Junho on . 4. 2.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFReBuildPasswordView.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

@interface FFReBuildPasswordView() <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIView *gubunLine1;
@property (strong, nonatomic) UIView *gubunLine2;
@property (strong, nonatomic) UILabel *lbPasswordWarn;

@end

@implementation FFReBuildPasswordView

-(instancetype) init
{
    self = [super init];
    if (self) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        _contentContainer.layer.cornerRadius = 5.f;
        
        _userIDStr1Title = [[UILabel alloc] init];
        _userIDStr1Title.backgroundColor = [UIColor clearColor];
        _userIDStr1Title.text = @"아이디";
        _userIDStr1Title.textColor = [UIColor blackColor];
        _userIDStr1Title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _userIDStr1 = [[UILabel alloc] init];
        _userIDStr1.backgroundColor = [UIColor clearColor];
        _userIDStr1.textColor = [UIColor ff_c1Color];
        _userIDStr1.text = @"test@genexon.co.kr";
        _userIDStr1.font = [UIFont boldSystemFontOfSize:15.f];
        
        _gubunLine1 = [[UIView alloc] init];
        _gubunLine1.backgroundColor = [UIColor ff_c19Color];
        
        _userPwTitle = [[UILabel alloc] init];
        _userPwTitle.backgroundColor = [UIColor clearColor];
        _userPwTitle.text = @"비밀번호";
        _userPwTitle.textColor = [UIColor blackColor];
        _userPwTitle.textAlignment = NSTextAlignmentCenter;
        _userPwTitle.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfWritePw = [[FFTextField alloc] init];
        _tfWritePw.backgroundColor = [UIColor clearColor];
        _tfWritePw.delegate = self;
        _tfWritePw.secureTextEntry = YES;
        _tfWritePw.textColor = [UIColor blackColor];
        _tfWritePw.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _userPwReTitle = [[UILabel alloc] init];
        _userPwReTitle.backgroundColor = [UIColor clearColor];
        _userPwReTitle.text = @"비밀번호 재확인";
        _userPwReTitle.textAlignment = NSTextAlignmentCenter;
        _userPwReTitle.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _userPwReTitle.textColor = [UIColor blackColor];
        
        _tfWritePwRe = [[FFTextField alloc] init];
        _tfWritePwRe.backgroundColor = [UIColor clearColor];
        _tfWritePwRe.delegate = self;
        _tfWritePwRe.secureTextEntry = YES;
        _tfWritePwRe.textColor = [UIColor blackColor];
        _tfWritePwRe.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _lbPasswordWarn = [[UILabel alloc] init];
        _lbPasswordWarn.backgroundColor = [UIColor clearColor];
        _lbPasswordWarn.text = @"영문자와 숫자를 조합하고\n8자 이상의 비밀번호 사용을 권장합니다";
        _lbPasswordWarn.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _lbPasswordWarn.textColor = [UIColor ff_c2Color];
        _lbPasswordWarn.numberOfLines = 2;
        _lbPasswordWarn.textAlignment = NSTextAlignmentCenter;
        
        _gubunLine2 = [[UIView alloc] init];
        _gubunLine2.backgroundColor = [UIColor ff_c19Color];
        
        _btnGoLogin1 = [[UIButton alloc] init];
        _btnGoLogin1.backgroundColor = [UIColor ff_c1Color];
        _btnGoLogin1.layer.cornerRadius = 5.f;
        _btnGoLogin1.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btnGoLogin1 setTitle:@"로그인" forState:UIControlStateNormal];
        [_btnGoLogin1 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnGoLogin1 addTarget:self action:@selector(goLoginPage2:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnSavePw = [[UIButton alloc] init];
        _btnSavePw.backgroundColor = [UIColor ff_c1Color];
        _btnSavePw.layer.cornerRadius = 5.f;
        _btnSavePw.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btnSavePw setTitle:@"저장" forState:UIControlStateNormal];
        [_btnSavePw setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnSavePw addTarget:self action:@selector(saveUserPassword:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentContainer addSubview:_userIDStr1Title];
        [_contentContainer addSubview:_userIDStr1];
        [_contentContainer addSubview:_gubunLine1];
        [_contentContainer addSubview:_userPwTitle];
        [_contentContainer addSubview:_tfWritePw];
        [_contentContainer addSubview:_userPwReTitle];
        [_contentContainer addSubview:_tfWritePwRe];
        [_contentContainer addSubview:_lbPasswordWarn];
        [_contentContainer addSubview:_gubunLine2];
        [_contentContainer addSubview:_btnGoLogin1];
        [_contentContainer addSubview:_btnSavePw];
        [self addSubview:_contentContainer];
        
        [self makeConstraints];
    }
    return self;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_userIDStr1Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(30.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(50.f);
        make.width.equalTo(@50.f);
        make.height.equalTo(@20.f);
    }];
    
    [_userIDStr1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(25.f);
        make.left.equalTo(_userIDStr1Title.mas_right).with.offset(20.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-20.f);
        make.height.equalTo(@30.f);
    }];
    
    [_gubunLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIDStr1Title.mas_bottom).with.offset(30.f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_userPwTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLine1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.width.equalTo(@120.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfWritePw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLine1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_userPwTitle.mas_right).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@30.f);
    }];
    
    [_userPwReTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userPwTitle.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.width.equalTo(@120.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfWritePwRe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfWritePw.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_userPwReTitle.mas_right).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbPasswordWarn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userPwReTitle.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_gubunLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbPasswordWarn.mas_bottom).with.offset(12.5f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_btnGoLogin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLine2.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self).with.offset(-80.f);
        make.width.equalTo(@100.f);
        make.height.equalTo(@40.f);
    }];
    
    [_btnSavePw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLine2.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self).with.offset(80.f);
        make.width.equalTo(@100.f);
        make.height.equalTo(@40.f);
    }];
}

- (void) goLoginPage2:(UIButton *)btn
{
    if (_move_login2) {
        _move_login2();
    }
}

- (void) saveUserPassword:(UIButton *)btn
{
    if (_save_password) {
        _save_password();
    }
}
- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_tfWritePw]) {
        [_tfWritePwRe becomeFirstResponder];
    } else {
        [_tfWritePwRe resignFirstResponder];
        _save_password();
    }
    return YES;
}

@end
