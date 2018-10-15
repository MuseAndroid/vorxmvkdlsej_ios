//
//  FFEmIdView.m
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFEmIdView.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

@interface FFEmIdView() <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentController;
@property (strong, nonatomic) UILabel *lbName1;
@property (strong, nonatomic) UILabel *lbEmail;
@property (strong, nonatomic) UILabel *lbSecNum;
@property (strong, nonatomic) UIView *v_gubun_line;
@property (strong, nonatomic) UIView *v_gubun_line1;
@property (strong, nonatomic) UILabel *lbWarnStr;

@end

@implementation FFEmIdView

- (instancetype) init
{
    self = [super init];
    if (self) {
        _contentController = [[UIView alloc] init];
        _contentController.backgroundColor = [UIColor ff_c5Color];
        
        _lbName1 = [[UILabel alloc] init];
        _lbName1.backgroundColor = [UIColor clearColor];
        _lbName1.text = @"이름";
        _lbName1.textColor = [UIColor blackColor];
        _lbName1.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputName1 = [[FFTextField alloc] init];
        _tfInputName1.backgroundColor = [UIColor clearColor];
        _tfInputName1.delegate = self;
        _tfInputName1.textColor = [UIColor blackColor];
        _tfInputName1.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputName1.returnKeyType = UIReturnKeyNext;
        
        _lbEmail = [[UILabel alloc] init];
        _lbEmail.backgroundColor = [UIColor clearColor];
        _lbEmail.text = @"이메일";
        _lbEmail.textColor = [UIColor blackColor];
        _lbEmail.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputEmail = [[FFTextField alloc] init];
        _tfInputEmail.backgroundColor = [UIColor clearColor];
        _tfInputEmail.delegate = self;
        _tfInputEmail.textColor = [UIColor blackColor];
        _tfInputEmail.keyboardType = UIKeyboardTypeEmailAddress;
        _tfInputEmail.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputEmail.returnKeyType = UIReturnKeyNext;
        
        _btnReqNum1 = [[UIButton alloc] init];
        _btnReqNum1.backgroundColor = [UIColor ff_c1Color];
        _btnReqNum1.layer.cornerRadius = 5.f;
        _btnReqNum1.titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
        [_btnReqNum1 setTitle:@"인증번호 받기" forState:UIControlStateNormal];
        [_btnReqNum1 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnReqNum1 addTarget:self action:@selector(getSecureNum1:) forControlEvents:UIControlEventTouchUpInside];
        
        _lbSecNum = [[UILabel alloc] init];
        _lbSecNum.backgroundColor = [UIColor clearColor];
        _lbSecNum.text = @"인증번호";
        _lbSecNum.textColor = [UIColor blackColor];
        _lbSecNum.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        
        _tfInputSecNum1 = [[FFTextField alloc] init];
        _tfInputSecNum1.backgroundColor = [UIColor clearColor];
        _tfInputSecNum1.delegate = self;
        _tfInputSecNum1.keyboardType = UIKeyboardTypeNumberPad;
        _tfInputSecNum1.textColor = [UIColor blackColor];
        _tfInputSecNum1.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _tfInputSecNum1.returnKeyType = UIReturnKeyDone;
        
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
        
        _btnGoNext2 = [[UIButton alloc] init];
        _btnGoNext2.backgroundColor = [UIColor ff_c1Color];
        _btnGoNext2.layer.cornerRadius = 5.f;
        _btnGoNext2.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btnGoNext2 setTitle:@"다음" forState:UIControlStateNormal];
        [_btnGoNext2 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnGoNext2 addTarget:self action:@selector(goNext2:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentController addSubview:_v_gubun_line];
        [_contentController addSubview:_lbName1];
        [_contentController addSubview:_tfInputName1];
        [_contentController addSubview:_lbEmail];
        [_contentController addSubview:_tfInputEmail];
        [_contentController addSubview:_btnReqNum1];
        [_contentController addSubview:_lbSecNum];
        [_contentController addSubview:_tfInputSecNum1];
        [_contentController addSubview:_lbWarnStr];
        [_contentController addSubview:_v_gubun_line1];
        [_contentController addSubview:_btnGoNext2];
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
        make.height.equalTo(@250.f);
    }];
    
    [_v_gubun_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentController.mas_top);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_lbName1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentController.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputName1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbName1.mas_right).with.offset(10.f);
        make.right.equalTo(_contentController.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbName1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentController.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputName1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_lbEmail.mas_right).with.offset(10.f);
        make.width.equalTo(@160.f);
        make.height.equalTo(@30.f);
    }];
    
    [_btnReqNum1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputName1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_tfInputEmail.mas_right).with.offset(10.f);
        make.right.equalTo(_contentController.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];
    
    [_lbSecNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbEmail.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentController.mas_left).with.offset(5.f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_tfInputSecNum1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfInputEmail.mas_bottom).with.offset(12.5f);
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
    
    [_btnGoNext2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_v_gubun_line1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo(@-12.5f);
        make.height.equalTo(@30.f);
    }];
}

- (void) getSecureNum1:(UIButton *) btn
{
    if (_reqNum2Handler) {
        _reqNum2Handler();
    }
}

- (void) goNext2:(UIButton *) btn
{
    
    if (_reqEmIdHandler) {
        _reqEmIdHandler();
    }
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_tfInputName1]) {
        [_tfInputEmail becomeFirstResponder];
    } else if ([textField isEqual:_tfInputEmail]) {
        [_tfInputSecNum1 becomeFirstResponder];
    } else {
        [_tfInputSecNum1 resignFirstResponder];
        _reqEmIdHandler();
    }
    return YES;
}

@end
