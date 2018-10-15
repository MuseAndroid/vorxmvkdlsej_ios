//
//  FFCapchaView.m
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFCaptcahView.h"

// View
#import "FFTextField.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFCaptcahView() <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) FFTextField *secureTxtFld;

@end

@implementation FFCaptcahView

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self makeUI];
    }
    return self;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(@.0f);
    }];
    
    [_captcahImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(80.f);
        make.centerX.equalTo(self).with.offset(-20.f);
        make.width.equalTo(@200.f);
        make.height.equalTo(@60.f);
    }];
    
    [_reCaptchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(80.f);
        make.left.equalTo(_captcahImage.mas_right).with.offset(12.5f);
        make.width.equalTo(@60.f);
        make.height.equalTo(@60.f);
    }];
    
    [_secureTxtFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_captcahImage.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self);
        make.width.equalTo(@240.f);
        make.height.equalTo(@40.f);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secureTxtFld.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self);
        make.width.equalTo(@240.f);
        make.height.equalTo(@40.f);
    }];
}

- (void) makeUI
{
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor ff_c5Color];
    
    _captcahImage = [[UIImageView alloc] init];
    
    _secureTxtFld = [[FFTextField alloc] init];
    _secureTxtFld.layer.cornerRadius = 5.f;
    _secureTxtFld.delegate = self;
    _secureTxtFld.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _secureTxtFld.textColor = [UIColor blackColor];
    _secureTxtFld.keyboardType = UIKeyboardTypeNumberPad;
    _secureTxtFld.returnKeyType = UIReturnKeyDone;
    _secureTxtFld.textAlignment = NSTextAlignmentCenter;
    
    _reCaptchaButton = [[UIButton alloc] init];
    _reCaptchaButton.backgroundColor = [UIColor clearColor];
    [_reCaptchaButton setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [_reCaptchaButton addTarget:self action:@selector(reCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmButton = [[UIButton alloc] init];
    _confirmButton.backgroundColor = [UIColor ff_c2Color];
    _confirmButton.layer.cornerRadius = 5.f;
    _confirmButton.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    [_confirmButton setTitle:@"보안문자확인" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(requestCertCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentView addSubview:_captcahImage];
    [_contentView addSubview:_secureTxtFld];
    [_contentView addSubview:_reCaptchaButton];
    [_contentView addSubview:_confirmButton];
    [self addSubview:_contentView];
    
    [self makeConstraints];
}

- (void) reCaptcha:(id) sender
{
    if (_reCaptchaHandler) {
        [self removeFromSuperview];
        _reCaptchaHandler();
    }
}

- (void) requestCertCode:(id) sender
{
    if (_confirmHandler) {
        _confirmHandler();
    }
}

- (void) setCapchaImage:(NSData *)imgData
{
    [self makeUI];
    [self setNeedsDisplay];
    [self.captcahImage setImage:[UIImage imageWithData:imgData]];
}

#pragma mark - Getter
- (NSString *)confirmTxt
{
    return _secureTxtFld.text;
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_secureTxtFld]) {
        _confirmHandler();
    }
    return YES;
}

@end
