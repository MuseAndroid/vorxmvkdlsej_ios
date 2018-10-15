//
//  FFHIdView.m
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFHIdView.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"


@interface FFHIdView () <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UILabel *lbName;
@property (strong, nonatomic) UILabel *lbHpNum;
@property (strong, nonatomic) UILabel *lbSecNum;
@property (strong, nonatomic) UIView *v_gubun_line;
@property (strong, nonatomic) UIView *v_gubun_line1;

@end

@implementation FFHIdView

- (instancetype) init
{
    self = [super init];
    if (self) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        
        _lbName = [[UILabel alloc] init];
        _lbName.backgroundColor = [UIColor clearColor];
        _lbName.text = @"이름";
        _lbName.textColor = [UIColor blackColor];
        _lbName.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputName = [[FFTextField alloc] init];
        _tfInputName.backgroundColor = [UIColor clearColor];
        _tfInputName.delegate = self;
        _tfInputName.textColor = [UIColor blackColor];
        _tfInputName.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputName.returnKeyType = UIReturnKeyNext;
        
        _lbHpNum = [[UILabel alloc] init];
        _lbHpNum.backgroundColor = [UIColor clearColor];
        _lbHpNum.text = @"휴대폰번호";
        _lbHpNum.textColor = [UIColor blackColor];
        _lbHpNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputHp = [[FFTextField alloc] init];
        _tfInputHp.backgroundColor = [UIColor clearColor];
        _tfInputHp.delegate = self;
        _tfInputHp.keyboardType = UIKeyboardTypePhonePad;
        _tfInputHp.placeholder = @"입력 시 '-'제외";
        _tfInputHp.textColor = [UIColor blackColor];
        _tfInputHp.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputHp.returnKeyType = UIReturnKeyNext;
        
        _btnReqNum = [[UIButton alloc] init];
        _btnReqNum.backgroundColor = [UIColor ff_c1Color];
        _btnReqNum.layer.cornerRadius = 5.f;
        _btnReqNum.titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
        [_btnReqNum setTitle:@"인증번호 받기" forState:UIControlStateNormal];
        [_btnReqNum setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnReqNum addTarget:self action:@selector(getSecureNum:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbSecNum = [[UILabel alloc] init];
        _lbSecNum.backgroundColor = [UIColor clearColor];
        _lbSecNum.text = @"인증번호";
        _lbSecNum.textColor = [UIColor blackColor];
        _lbSecNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputSecNum = [[FFTextField alloc] init];
        _tfInputSecNum.backgroundColor = [UIColor clearColor];
        _tfInputSecNum.delegate = self;
        _tfInputSecNum.keyboardType = UIKeyboardTypeNumberPad;
        _tfInputSecNum.textColor = [UIColor blackColor];
        _tfInputSecNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputSecNum.returnKeyType = UIReturnKeyDone;
        
        _v_gubun_line = [[UIView alloc] init];
        _v_gubun_line.backgroundColor = [UIColor ff_c19Color];
        
        _v_gubun_line1 = [[UIView alloc] init];
        _v_gubun_line1.backgroundColor = [UIColor ff_c19Color];
        
        _btnGoNext1 = [[UIButton alloc] init];
        _btnGoNext1.backgroundColor = [UIColor ff_c1Color];
        _btnGoNext1.layer.cornerRadius = 5.f;
        _btnGoNext1.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btnGoNext1 setTitle:@"다음" forState:UIControlStateNormal];
        [_btnGoNext1 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnGoNext1 addTarget:self action:@selector(goNext1:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentContainer addSubview:_v_gubun_line];
        [_contentContainer addSubview:_lbName];
        [_contentContainer addSubview:_tfInputName];
        [_contentContainer addSubview:_lbHpNum];
        [_contentContainer addSubview:_tfInputHp];
        [_contentContainer addSubview:_btnReqNum];
        [_contentContainer addSubview:_lbSecNum];
        [_contentContainer addSubview:_tfInputSecNum];
        [_contentContainer addSubview:_v_gubun_line1];
        [_contentContainer addSubview:_btnGoNext1];
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
    
    [_lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbName.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbHpNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbName.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputHp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputName.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbHpNum.mas_right).with.offset(10.f);
        make.width.equalTo(@160.f);
        make.height.equalTo(@30.f);
    }];
    
    [_btnReqNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputName.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_tfInputHp.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbSecNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbHpNum.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputSecNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputHp.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbSecNum.mas_right).with.offset(10.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_v_gubun_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbSecNum.mas_bottom).with.offset(12.5f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_btnGoNext1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo(@-12.5f);
        make.height.equalTo(@30.f);
    }];
}

- (void) getSecureNum:(UIButton *) btn
{
    if (_reqNum1Handler) {
        _reqNum1Handler();
    }
}

- (void) goNext1:(UIButton *) btn
{
   
    if (_reqHIdHandler) {
        _reqHIdHandler();
    }
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_tfInputName]) {
        [_tfInputHp becomeFirstResponder];
    } else if ([textField isEqual:_tfInputHp]) {
        [_tfInputSecNum becomeFirstResponder];
    } else {
        [_tfInputSecNum resignFirstResponder];
        _reqHIdHandler();
    }
    return YES;
}

@end
