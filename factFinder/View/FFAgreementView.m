//
//  FFAgreementView.m
//  factFinder
//
//  Created by Hong Junho on . 1. 14.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFAgreementView.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFAgreementView ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIButton *allAgreeBtn;
@property (strong, nonatomic) UIButton *userServiceBtn;
@property (strong, nonatomic) UIButton *personalInfoBtn;
@property (strong, nonatomic) UIView *cellLine1;
@property (strong, nonatomic) UIView *cellLine2;
@property (strong, nonatomic) UIView *cellLine3;
@property (strong, nonatomic) UIButton *userServiceViewBtn;
@property (strong, nonatomic) UIButton *personalInfoViewBtn;
@property (strong, nonatomic) UIButton *goNextBtn;

@end

@implementation FFAgreementView

-(instancetype) init
{
    self = [super init];
    if (self) {
        UIImage *nor_check_btn = [UIImage imageNamed:@"icon_check_02"];
        UIImage *pre_check_btn = [UIImage imageNamed:@"icon_check_01"];
        UIImage *right_btn = [UIImage imageNamed:@"right_btn"];
        
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        
        _allAgreeBtn = [[UIButton alloc] init];
        _allAgreeBtn.clipsToBounds = YES;
        _allAgreeBtn.selected = NO;
        _allAgreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _allAgreeBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:15.f];
        [_allAgreeBtn setImage:nor_check_btn forState:UIControlStateNormal];
        [_allAgreeBtn setImage:pre_check_btn forState:UIControlStateSelected];
        [_allAgreeBtn setTitle:@"  이용약관, 개인정보 수집 및 이용에 모두 동의합니다." forState:UIControlStateNormal];
        [_allAgreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allAgreeBtn addTarget:self action:@selector(checkAll:) forControlEvents:UIControlEventTouchUpInside];
        
        _userServiceBtn = [[UIButton alloc] init];
        _userServiceBtn.clipsToBounds = YES;
        _userServiceBtn.selected = NO;
        _userServiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _userServiceBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:15.f];
        [_userServiceBtn setImage:nor_check_btn forState:UIControlStateNormal];
        [_userServiceBtn setImage:pre_check_btn forState:UIControlStateSelected];
        [_userServiceBtn setTitle:@"  서비스 이용약관 동의(필수)" forState:UIControlStateNormal];
        [_userServiceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_userServiceBtn addTarget:self action:@selector(checkUserService:) forControlEvents:UIControlEventTouchUpInside];
        
        _personalInfoBtn = [[UIButton alloc] init];
        _personalInfoBtn.clipsToBounds = YES;
        _personalInfoBtn.selected = NO;
        _personalInfoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _personalInfoBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:15.f];
        [_personalInfoBtn setImage:nor_check_btn forState:UIControlStateNormal];
        [_personalInfoBtn setImage:pre_check_btn forState:UIControlStateSelected];
        [_personalInfoBtn setTitle:@"  개인정보 수집 및 이용에 대한 안내(필수)" forState:UIControlStateNormal];
        [_personalInfoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_personalInfoBtn addTarget:self action:@selector(checkPersonalInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        _cellLine1 = [[UIView alloc] init];
        _cellLine1.backgroundColor = [UIColor ff_c16Color];
        
        _cellLine2 = [[UIView alloc] init];
        _cellLine2.backgroundColor = [UIColor ff_c16Color];
        
        _cellLine3 = [[UIView alloc] init];
        _cellLine3.backgroundColor = [UIColor ff_c16Color];
        
        _userServiceViewBtn = [[UIButton alloc] init];
        _userServiceViewBtn.clipsToBounds = YES;
        [_userServiceViewBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_userServiceViewBtn setImage:right_btn forState:UIControlStateNormal];
        [_userServiceViewBtn addTarget:self action:@selector(goUserServicePopup:) forControlEvents:UIControlEventTouchUpInside];
        
        _personalInfoViewBtn = [[UIButton alloc] init];
        _personalInfoViewBtn.clipsToBounds = YES;
        [_personalInfoViewBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_personalInfoViewBtn setImage:right_btn forState:UIControlStateNormal];
        [_personalInfoViewBtn addTarget:self action:@selector(goPersonalInfoPopup:) forControlEvents:UIControlEventTouchUpInside];
        
        _goNextBtn = [[UIButton alloc] init];
        _goNextBtn.clipsToBounds = YES;
        _goNextBtn.backgroundColor = [UIColor ff_c1Color];
        _goNextBtn.layer.cornerRadius = 5.f;
        _goNextBtn.titleLabel.font=[UIFont boldSystemFontOfSize:20.f];
        _goNextBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_goNextBtn setTitle:@"다음" forState:UIControlStateNormal];
        [_goNextBtn addTarget:self action:@selector(goNextView:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentContainer addSubview:_allAgreeBtn];
        [_contentContainer addSubview:_userServiceBtn];
        [_contentContainer addSubview:_personalInfoBtn];
        [_contentContainer addSubview:_cellLine1];
        [_contentContainer addSubview:_cellLine2];
        [_contentContainer addSubview:_cellLine3];
        [_contentContainer addSubview:_userServiceViewBtn];
        [_contentContainer addSubview:_personalInfoViewBtn];
        [_contentContainer addSubview:_goNextBtn];
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
        make.left.and.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_allAgreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(10.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_cellLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allAgreeBtn.mas_bottom).with.offset(3.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@1.f);
    }];
    
    [_userServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellLine1.mas_bottom).with.offset(3.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-30.f);
        make.height.equalTo(@30.f);
    }];
    
    [_userServiceViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellLine1.mas_bottom).with.offset(3.f);
        make.left.equalTo(_userServiceBtn.mas_right);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_cellLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userServiceBtn.mas_bottom).with.offset(3.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@1.f);
    }];
    
    [_personalInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellLine2.mas_bottom).with.offset(3.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-30.f);
        make.height.equalTo(@30.f);
    }];
    
    [_personalInfoViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellLine2.mas_bottom).with.offset(3.f);
        make.left.equalTo(_personalInfoBtn.mas_right);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_cellLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_personalInfoBtn.mas_bottom).with.offset(3.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@1.f);
    }];
    
    [_goNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cellLine3.mas_bottom).with.offset(300.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@50.f);
    }];
}

/**
 전체동의 체크버튼 터치 시 동작하는 메서드

 @param sender 전체동의 체크버튼 객체
 */
- (void)checkAll:(id) sender
{
    if (!_allAgreeBtn.isSelected) {
        _allAgreeBtn.selected = YES;
        _userServiceBtn.selected = YES;
        _personalInfoBtn.selected = YES;
    } else {
        _allAgreeBtn.selected = NO;
        _userServiceBtn.selected = NO;
        _personalInfoBtn.selected = NO;
    }
}

/**
 첫번째 고객정보 동의 체크버튼 터치 시 진입하는 메서드

 @param sender 첫번째 고객정보 동의 체크버튼 객체
 */
- (void)checkUserService:(id) sender
{
    if (!_userServiceBtn.isSelected) {
        _userServiceBtn.selected = YES;
        if (_personalInfoBtn.isSelected) {
            _allAgreeBtn.selected = YES;
        } else {
            _allAgreeBtn.selected = NO;
        }
    } else {
        _userServiceBtn.selected = NO;
        _allAgreeBtn.selected = NO;
    }
}

/**
 두번째 고객정보 동의 체크버튼 터치 시 진입하는 메서드

 @param sender 두번째 고객정보 동의 체크버튼 객체
 */
- (void)checkPersonalInfo:(id) sender
{
    if (!_personalInfoBtn.isSelected) {
        _personalInfoBtn.selected = YES;
        if (_userServiceBtn.isSelected) {
            _allAgreeBtn.selected = YES;
        } else {
            _allAgreeBtn.selected = NO;
        }
    } else {
        _personalInfoBtn.selected = NO;
        _allAgreeBtn.selected = NO;
    }
}

/**
 회원가입 화면으로 이동하는 다음 버튼을 누를 때 진입하는 메서드

 @param sender 다음 버튼 객체
 */
- (void)goNextView:(id) sender
{
    if (_goJoinHandler) {
        _goJoinHandler();
    }
}

/**
 첫번째 고객정보 팝업 보여줄 때 진입하는 메서드

 @param sender 첫번째 고객정보 표현 view 객체
 */
- (void)goUserServicePopup:(id) sender
{
    if (_goAgreePopup1Handler) {
        _goAgreePopup1Handler();
    }
}

/**
 두번째 고객정보 팝업 보여줄 때 진입하는 메서드

 @param sender 두번째 고객정보 표현 view 객체
 */
- (void)goPersonalInfoPopup:(id) sender
{
    if (_goAgreePopup2Handler) {
        _goAgreePopup2Handler();
    }
}


@end
