//
//  FFEmPwView.m
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFEmPwView.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFEmPwView() <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentController;
@property (strong, nonatomic) UILabel *lbEmail;
@property (strong, nonatomic) UILabel *lbSecNum;
@property (strong, nonatomic) UILabel *lbWarnStr;
@property (strong, nonatomic) UIView *v_gubun_line;
@property (strong, nonatomic) UIView *v_gubun_line1;

@end

@implementation FFEmPwView

- (instancetype) init
{
    self = [super init];
    if (self) {
        _contentController = [[UIView alloc] init];
        _contentController.backgroundColor = [UIColor ff_c5Color];
        
        _lbEmail = [[UILabel alloc] init];
        _lbEmail.backgroundColor = [UIColor clearColor];
        _lbEmail.text = @"이메일";
        _lbEmail.textColor = [UIColor blackColor];
        _lbEmail.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputEmail_pw = [[FFTextField alloc] init];
        _tfInputEmail_pw.backgroundColor = [UIColor clearColor];
        _tfInputEmail_pw.delegate = self;
        _tfInputEmail_pw.textColor = [UIColor blackColor];
        _tfInputEmail_pw.keyboardType = UIKeyboardTypeEmailAddress;
        _tfInputEmail_pw.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputEmail_pw.returnKeyType = UIReturnKeyNext;
        
        _btn_emPwReqNum = [[UIButton alloc] init];
        _btn_emPwReqNum.backgroundColor = [UIColor ff_c1Color];
        _btn_emPwReqNum.layer.cornerRadius = 5.f;
        _btn_emPwReqNum.titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
        [_btn_emPwReqNum setTitle:@"인증번호 받기" forState:UIControlStateNormal];
        [_btn_emPwReqNum setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btn_emPwReqNum addTarget:self action:@selector(getSecureNum1:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbSecNum = [[UILabel alloc] init];
        _lbSecNum.backgroundColor = [UIColor clearColor];
        _lbSecNum.text = @"인증번호";
        _lbSecNum.textColor = [UIColor blackColor];
        _lbSecNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputSecNum_emPw = [[FFTextField alloc] init];
        _tfInputSecNum_emPw.backgroundColor = [UIColor clearColor];
        _tfInputSecNum_emPw.delegate = self;
        _tfInputSecNum_emPw.keyboardType = UIKeyboardTypeNumberPad;
        _tfInputSecNum_emPw.textColor = [UIColor blackColor];
        _tfInputSecNum_emPw.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputSecNum_emPw.returnKeyType = UIReturnKeyDone;
        
        _lbWarnStr = [[UILabel alloc] init];
        _lbWarnStr.text = @"메일 종류에 따라 스팸메일함으로 분류될 수 있으니,\n스팸 메일함을 꼭 확인해 주시기 바랍니다.";
        _lbWarnStr.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _lbWarnStr.textColor = [UIColor ff_c2Color];
        _lbWarnStr.numberOfLines = 2;
        _lbWarnStr.textAlignment = NSTextAlignmentCenter;
        
        _v_gubun_line = [[UIView alloc] init];
        _v_gubun_line.backgroundColor = [UIColor ff_c19Color];
        
        _v_gubun_line1 = [[UIView alloc] init];
        _v_gubun_line1.backgroundColor = [UIColor ff_c19Color];
        
        _btn_emPwGoNext = [[UIButton alloc] init];
        _btn_emPwGoNext.backgroundColor = [UIColor ff_c1Color];
        _btn_emPwGoNext.layer.cornerRadius = 5.f;
        _btn_emPwGoNext.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btn_emPwGoNext setTitle:@"다음" forState:UIControlStateNormal];
        [_btn_emPwGoNext setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btn_emPwGoNext addTarget:self action:@selector(goNext2:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentController addSubview:_v_gubun_line];
        [_contentController addSubview:_lbEmail];
        [_contentController addSubview:_tfInputEmail_pw];
        [_contentController addSubview:_btn_emPwReqNum];
        [_contentController addSubview:_lbSecNum];
        [_contentController addSubview:_tfInputSecNum_emPw];
        [_contentController addSubview:_lbWarnStr];
        [_contentController addSubview:_v_gubun_line1];
        [_contentController addSubview:_btn_emPwGoNext];
        [self addSubview:_contentController];
        
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
    containerMaskPath = [UIBezierPath bezierPathWithRoundedRect:_contentController.bounds byRoundingCorners:corners cornerRadii:cornerSize];
    
    CAShapeLayer *containerMaskLayer = [[CAShapeLayer alloc] init];
    containerMaskLayer.frame = _contentController.bounds;
    containerMaskLayer.path = containerMaskPath.CGPath;
    _contentController.layer.mask = containerMaskLayer;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@210.f);
    }];
    
    [_v_gubun_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentController.mas_top);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentController.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputEmail_pw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbEmail.mas_right).with.offset(10.f);
        make.width.equalTo(@160.f);
        make.height.equalTo(@30.f);
    }];
    
    [_btn_emPwReqNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_tfInputEmail_pw.mas_right).with.offset(10.f);
        make.right.equalTo(_contentController.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbSecNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbEmail.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentController.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputSecNum_emPw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputEmail_pw.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbSecNum.mas_right).with.offset(10.f);
        make.right.equalTo(_contentController.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbWarnStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbSecNum.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self);
        make.height.equalTo(@40.f);
    }];
    
    [_v_gubun_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbWarnStr.mas_bottom).with.offset(12.5f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_btn_emPwGoNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo(@-12.5f);
        make.height.equalTo(@30.f);
    }];
}

- (void) getSecureNum1:(UIButton *) btn
{
    if (_req_emPwNumHandler) {
        _req_emPwNumHandler();
    }
}

- (void) goNext2:(UIButton *) btn
{
    
    if (_reqEmPwHandler) {
        _reqEmPwHandler();
    }
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_tfInputEmail_pw]) {
        [_tfInputSecNum_emPw becomeFirstResponder];
    } else {
        [_tfInputSecNum_emPw resignFirstResponder];
        _reqEmPwHandler();
    }
    return YES;
}

@end
