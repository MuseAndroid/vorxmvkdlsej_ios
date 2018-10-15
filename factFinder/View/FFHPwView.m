//
//  FFHPwView.m
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFHPwView.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFHPwView() <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UILabel *lbId;
@property (strong, nonatomic) UILabel *lbHpNum;
@property (strong, nonatomic) UILabel *lbSecNum;
@property (strong, nonatomic) UIView *v_gubun_line;
@property (strong, nonatomic) UIView *v_gubun_line1;

@end

@implementation FFHPwView

- (instancetype) init
{
    self = [super init];
    if (self) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        
        _lbId = [[UILabel alloc] init];
        _lbId.backgroundColor = [UIColor clearColor];
        _lbId.text = @"아이디";
        _lbId.textColor = [UIColor blackColor];
        _lbId.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputID = [[FFTextField alloc] init];
        _tfInputID.backgroundColor = [UIColor clearColor];
        _tfInputID.delegate = self;
        _tfInputID.textColor = [UIColor blackColor];
        _tfInputID.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputID.keyboardType = UIKeyboardTypeEmailAddress;
        _tfInputID.returnKeyType = UIReturnKeyNext;
        
        _lbHpNum = [[UILabel alloc] init];
        _lbHpNum.backgroundColor = [UIColor clearColor];
        _lbHpNum.text = @"휴대폰번호";
        _lbHpNum.textColor = [UIColor blackColor];
        _lbHpNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputHp_pw = [[FFTextField alloc] init];
        _tfInputHp_pw.backgroundColor = [UIColor clearColor];
        _tfInputHp_pw.delegate = self;
        _tfInputHp_pw.keyboardType = UIKeyboardTypePhonePad;
        _tfInputHp_pw.placeholder = @"입력 시 '-'제외";
        _tfInputHp_pw.textColor = [UIColor blackColor];
        _tfInputHp_pw.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputHp_pw.returnKeyType = UIReturnKeyNext;
        
        _btnReqNum_pw = [[UIButton alloc] init];
        _btnReqNum_pw.backgroundColor = [UIColor ff_c1Color];
        _btnReqNum_pw.layer.cornerRadius = 5.f;
        _btnReqNum_pw.titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
        [_btnReqNum_pw setTitle:@"인증번호 받기" forState:UIControlStateNormal];
        [_btnReqNum_pw setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnReqNum_pw addTarget:self action:@selector(getSecureNum:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbSecNum = [[UILabel alloc] init];
        _lbSecNum.backgroundColor = [UIColor clearColor];
        _lbSecNum.text = @"인증번호";
        _lbSecNum.textColor = [UIColor blackColor];
        _lbSecNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputSecNum_pw = [[FFTextField alloc] init];
        _tfInputSecNum_pw.backgroundColor = [UIColor clearColor];
        _tfInputSecNum_pw.delegate = self;
        _tfInputSecNum_pw.keyboardType = UIKeyboardTypeNumberPad;
        _tfInputSecNum_pw.textColor = [UIColor blackColor];
        _tfInputSecNum_pw.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputSecNum_pw.returnKeyType = UIReturnKeyDone;
        
        _v_gubun_line = [[UIView alloc] init];
        _v_gubun_line.backgroundColor = [UIColor ff_c19Color];
        
        _v_gubun_line1 = [[UIView alloc] init];
        _v_gubun_line1.backgroundColor = [UIColor ff_c19Color];
        
        _btn_pwGoNext = [[UIButton alloc] init];
        _btn_pwGoNext.backgroundColor = [UIColor ff_c1Color];
        _btn_pwGoNext.layer.cornerRadius = 5.f;
        _btn_pwGoNext.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btn_pwGoNext setTitle:@"다음" forState:UIControlStateNormal];
        [_btn_pwGoNext setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btn_pwGoNext addTarget:self action:@selector(goNext1:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentContainer addSubview:_v_gubun_line];
        [_contentContainer addSubview:_lbId];
        [_contentContainer addSubview:_tfInputID];
        [_contentContainer addSubview:_lbHpNum];
        [_contentContainer addSubview:_tfInputHp_pw];
        [_contentContainer addSubview:_btnReqNum_pw];
        [_contentContainer addSubview:_lbSecNum];
        [_contentContainer addSubview:_tfInputSecNum_pw];
        [_contentContainer addSubview:_v_gubun_line1];
        [_contentContainer addSubview:_btn_pwGoNext];
        [self addSubview:_contentContainer];
        
        [self makeConstraints];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UIRectCorner corners;
    CGSize cornerSize = CGSizeMake(5.f, 5.f);
    corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *containerMaskPath;
    containerMaskPath = [UIBezierPath bezierPathWithRoundedRect:_contentContainer.bounds byRoundingCorners:corners cornerRadii:cornerSize];
    
    CAShapeLayer *containerMaskLayer = [[CAShapeLayer alloc] init];
    containerMaskLayer.frame = _contentContainer.bounds;
    containerMaskLayer.path = containerMaskPath.CGPath;
    _contentContainer.layer.mask = containerMaskLayer;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@210.f);
    }];
    
    [_v_gubun_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_lbId mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbId.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbHpNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbId.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputHp_pw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputID.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbHpNum.mas_right).with.offset(10.f);
        make.width.equalTo(@160.f);
        make.height.equalTo(@30.f);
    }];
    
    [_btnReqNum_pw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputID.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_tfInputHp_pw.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbSecNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbHpNum.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputSecNum_pw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputHp_pw.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbSecNum.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_v_gubun_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbSecNum.mas_bottom).with.offset(12.5f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_btn_pwGoNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo(@-12.5f);
        make.height.equalTo(@30.f);
    }];
}

- (void) getSecureNum:(UIButton *) btn
{
    if (_req_pwNumHandler) {
        _req_pwNumHandler();
    }
}

- (void) goNext1:(UIButton *) btn
{
    
    if (_reqHPwHandler) {
        _reqHPwHandler();
    }
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_tfInputID]) {
        [_tfInputHp_pw becomeFirstResponder];
    } else if ([textField isEqual:_tfInputHp_pw]) {
        [_tfInputSecNum_pw becomeFirstResponder];
    } else {
        [_tfInputSecNum_pw resignFirstResponder];
        _reqHPwHandler();
    }
    return YES;
}

@end
