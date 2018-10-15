//
//  FFJoinView.m
//  factFinder
//
//  Created by Hong Junho on . 1. 21.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFJoinView.h"

// View
#import "FFTextField.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <Masonry/Masonry.h>

@interface FFJoinView()

@property (strong, nonatomic) UIView *contentContainer;

@property (strong, nonatomic) UIView *emailContent;
@property (strong, nonatomic) UIImageView *emailImg;
@property (strong, nonatomic) FFTextField *emailTF;

@property (strong, nonatomic) UIView *line1;

@property (strong, nonatomic) UIView *nameContent;
@property (strong, nonatomic) UIImageView *nameImg;
@property (strong, nonatomic) FFTextField *nameTF;

@property (strong, nonatomic) UIView *line2;

@property (strong, nonatomic) UIView *passwdContent;
@property (strong, nonatomic) UIImageView *passwdImg;
@property (strong, nonatomic) FFTextField *passwdTF;

@property (strong, nonatomic) UIView *line3;

@property (strong, nonatomic) UIView *rePasswdContent;
@property (strong, nonatomic) UIImageView *rePasswdImg;
@property (strong, nonatomic) FFTextField *rePasswdTF;

@property (strong, nonatomic) UIView *line4;

@property (strong, nonatomic) UIView *mobileContent;
@property (strong, nonatomic) UIImageView *mobileImg;
@property (strong, nonatomic) FFTextField *mobileTF;

@property (strong, nonatomic) UIView *line5;

@end

@implementation FFJoinView

- (instancetype) init
{
    self = [super init];
    if(self) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor clearColor];
        
        _emailContent = [[UIView alloc] init];
        _emailContent.backgroundColor = [UIColor whiteColor];
        
        _emailImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_log_email"]];
        
        _emailTF = [[FFTextField alloc] init];
        _emailTF.backgroundColor = [UIColor clearColor];
        _emailTF.layer.borderColor = [UIColor clearColor].CGColor;
        _emailTF.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _emailTF.textColor = [UIColor blackColor];
        _emailTF.placeholder = @"이메일";
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor grayColor];
        
        _nameContent = [[UIView alloc] init];
        _nameContent.backgroundColor = [UIColor clearColor];
        
        _nameImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_log_name"]];
        
        _nameTF = [[FFTextField alloc] init];
        _nameTF.backgroundColor = [UIColor clearColor];
        _nameTF.layer.borderColor = [UIColor clearColor].CGColor;
        _nameTF.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _nameTF.textColor = [UIColor blackColor];
        _nameTF.placeholder = @"이름";
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor grayColor];
        
        _passwdContent = [[UIView alloc] init];
        _passwdContent.backgroundColor = [UIColor clearColor];
        
        _passwdImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_log_pw"]];
        
        _passwdTF = [[FFTextField alloc] init];
        _passwdTF.backgroundColor = [UIColor clearColor];
        _passwdTF.layer.borderColor = [UIColor clearColor].CGColor;
        _passwdTF.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _passwdTF.textColor = [UIColor blackColor];
        _passwdTF.secureTextEntry = YES;
        _passwdTF.placeholder = @"비밀번호";
        
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor grayColor];
        
        _rePasswdContent = [[UIView alloc] init];
        _rePasswdContent.backgroundColor = [UIColor clearColor];
        
        _rePasswdImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_log_pw_c"]];
        
        _rePasswdTF = [[FFTextField alloc] init];
        _rePasswdTF.backgroundColor = [UIColor clearColor];
        _rePasswdTF.layer.borderColor = [UIColor clearColor].CGColor;
        _rePasswdTF.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _rePasswdTF.textColor = [UIColor blackColor];
        _rePasswdTF.secureTextEntry = YES;
        _rePasswdTF.placeholder = @"비밀번호 재확인";
        
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = [UIColor grayColor];
        
        _mobileContent = [[UIView alloc] init];
        _mobileContent.backgroundColor = [UIColor clearColor];
        
        _mobileImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_log_mobile"]];
        
        _mobileTF = [[FFTextField alloc] init];
        _mobileTF.backgroundColor = [UIColor clearColor];
        _mobileTF.layer.borderColor = [UIColor clearColor].CGColor;
        _mobileTF.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _mobileTF.textColor = [UIColor blackColor];
        _mobileTF.placeholder = @"핸드폰번호";
        
        _line5 = [[UIView alloc] init];
        _line5.backgroundColor = [UIColor grayColor];
        
        _joinBtn = [[UIButton alloc] init];
        _joinBtn.backgroundColor = [UIColor ff_c1Color];
        _joinBtn.layer.cornerRadius = 5.f;
        _joinBtn.titleLabel.textColor = [UIColor ff_c5Color];
        _joinBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:15.f];
        [_joinBtn setTitle:@"회원가입" forState:UIControlStateNormal];
        [_joinBtn addTarget:self action:@selector(joinMber:) forControlEvents:UIControlEventTouchUpInside];
        
        [_emailContent addSubview:_emailImg];
        [_emailContent addSubview:_emailTF];
        
        [_nameContent addSubview:_nameImg];
        [_nameContent addSubview:_nameTF];
        
        [_passwdContent addSubview:_passwdImg];
        [_passwdContent addSubview:_passwdTF];
        
        [_rePasswdContent addSubview:_rePasswdImg];
        [_rePasswdContent addSubview:_rePasswdTF];
        
        [_mobileContent addSubview:_mobileImg];
        [_mobileContent addSubview:_mobileTF];
        
        [_contentContainer addSubview:_emailContent];
        [_contentContainer addSubview:_line1];
        [_contentContainer addSubview:_nameContent];
        [_contentContainer addSubview:_line2];
        [_contentContainer addSubview:_passwdContent];
        [_contentContainer addSubview:_line3];
        [_contentContainer addSubview:_rePasswdContent];
        [_contentContainer addSubview:_line4];
        [_contentContainer addSubview:_mobileContent];
        [_contentContainer addSubview:_line5];
        [_contentContainer addSubview:_joinBtn];
        
        [self addSubview:_contentContainer];
        
        [self makeConstraints];
    }
    return self;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.equalTo(@.0f);
        make.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_emailContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_emailImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_emailContent.mas_top).with.offset(5.f);
        make.left.equalTo(_emailContent.mas_left).with.offset(5.f);
        make.width.equalTo(@30.f);
        make.bottom.equalTo(_emailContent.mas_bottom).with.offset(-5.f);
    }];
    
    [_emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_emailContent.mas_top).with.offset(5.f);
        make.left.equalTo(_emailImg.mas_right).with.offset(5.f);
        make.right.equalTo(_emailContent.mas_right);
        make.bottom.equalTo(_emailContent.mas_bottom).with.offset(5.f);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_emailContent.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@1.f);
    }];
    [_nameContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_nameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameContent.mas_top).with.offset(5.f);
        make.left.equalTo(_nameContent.mas_left).with.offset(5.f);
        make.width.equalTo(@30.f);
        make.bottom.equalTo(_nameContent.mas_bottom).with.offset(-5.f);
    }];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameContent.mas_top).with.offset(5.f);
        make.left.equalTo(_nameImg.mas_right).with.offset(5.f);
        make.right.equalTo(_nameContent.mas_right);
        make.bottom.equalTo(_nameContent.mas_bottom).with.offset(5.f);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameContent.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@1.f);
    }];
    [_passwdContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_passwdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwdContent.mas_top).with.offset(5.f);
        make.left.equalTo(_passwdContent.mas_left).with.offset(5.f);
        make.width.equalTo(@30.f);
        make.bottom.equalTo(_passwdContent.mas_bottom).with.offset(-5.f);
    }];
    
    [_passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwdContent.mas_top).with.offset(5.f);
        make.left.equalTo(_passwdImg.mas_right).with.offset(5.f);
        make.right.equalTo(_passwdContent.mas_right);
        make.bottom.equalTo(_passwdContent.mas_bottom).with.offset(5.f);
    }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwdContent.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@1.f);
    }];
    [_rePasswdContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_rePasswdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rePasswdContent.mas_top).with.offset(5.f);
        make.left.equalTo(_rePasswdContent.mas_left).with.offset(5.f);
        make.width.equalTo(@30.f);
        make.bottom.equalTo(_rePasswdContent.mas_bottom).with.offset(-5.f);
    }];
    
    [_rePasswdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rePasswdContent.mas_top).with.offset(5.f);
        make.left.equalTo(_rePasswdImg.mas_right).with.offset(5.f);
        make.right.equalTo(_rePasswdContent.mas_right);
        make.bottom.equalTo(_rePasswdContent.mas_bottom).with.offset(5.f);
    }];
    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rePasswdContent.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@1.f);
    }];
    [_mobileContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line4.mas_top).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@40.f);
    }];
    
    [_mobileImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileContent.mas_top).with.offset(5.f);
        make.left.equalTo(_mobileContent.mas_left).with.offset(5.f);
        make.width.equalTo(@30.f);
        make.bottom.equalTo(_mobileContent.mas_bottom).with.offset(-5.f);
    }];
    
    [_mobileTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileContent.mas_top).with.offset(5.f);
        make.left.equalTo(_mobileImg.mas_right).with.offset(5.f);
        make.right.equalTo(_mobileContent.mas_right);
        make.bottom.equalTo(_mobileContent.mas_bottom).with.offset(5.f);
    }];
    
    [_line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mobileContent.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@1.f);
    }];
    
    [_joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line5.mas_bottom).with.offset(180.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(-12.5f);
    }];
    
}

/**
 회원가입 버튼을 누를 때 진입하는 메서드

 @param btn 회원가입 버튼 객체
 */
- (void) joinMber:(UIButton *)btn
{
    if (_joinUserHandler)
    {
        _joinUserHandler();
    }
}

- (NSDictionary *)getUserData
{
    NSDictionary *userDataSet = @{
                                  @"uEmail":_emailTF.text,
                                  @"uName":_nameTF.text,
                                  @"uPasswd":_passwdTF.text,
                                  @"uRePasswd":_rePasswdTF.text,
                                  @"uMobile":_mobileTF.text
                                  };
    
    NSLog(@"파라미터 정보 = %@", userDataSet);
    return userDataSet;
}

@end
