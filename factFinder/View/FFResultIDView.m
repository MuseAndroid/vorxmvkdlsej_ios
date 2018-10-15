//
//  FFResultIDView.m
//  factFinder
//
//  Created by Hong Junho on . 4. 2.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFResultIDView.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

@interface FFResultIDView()

@property (strong, nonatomic) UIView *contentContainer;

@end

@implementation FFResultIDView

- (instancetype) init
{
    self = [super init];
    if (self) {
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        _contentContainer.layer.cornerRadius = 5.f;
        
        _lbUserIDTitle = [[UILabel alloc] init];
        _lbUserIDTitle.backgroundColor = [UIColor clearColor];
        _lbUserIDTitle.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        _lbUserIDTitle.textColor = [UIColor blackColor];
        _lbUserIDTitle.text = @"아이디";
        
        _lbUserID = [[UILabel alloc] init];
        _lbUserID.backgroundColor = [UIColor clearColor];
        _lbUserID.textColor = [UIColor ff_c1Color];
        _lbUserID.font = [UIFont boldSystemFontOfSize:15.f];
        
        _gubunLineView1 = [[UIView alloc] init];
        _gubunLineView1.backgroundColor = [UIColor ff_c19Color];
        
        _btnGoLogin1 = [[UIButton alloc] init];
        _btnGoLogin1.backgroundColor = [UIColor ff_c1Color];
        _btnGoLogin1.layer.cornerRadius = 5.f;
        _btnGoLogin1.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_btnGoLogin1 setTitle:@"로그인" forState:UIControlStateNormal];
        [_btnGoLogin1 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnGoLogin1 addTarget:self action:@selector(goLoginPage:) forControlEvents:UIControlEventTouchUpInside];
        
        _btnMoveFindPW = [[UIButton alloc] init];
        _btnMoveFindPW.backgroundColor = [UIColor ff_c1Color];
        _btnMoveFindPW.layer.cornerRadius = 5.f;
        _btnMoveFindPW.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize: 13.f];
        [_btnMoveFindPW setTitle:@"비밀번호 찾기" forState:UIControlStateNormal];
        [_btnMoveFindPW setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_btnMoveFindPW addTarget:self action:@selector(goFindPwPage:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentContainer addSubview:_lbUserIDTitle];
        [_contentContainer addSubview:_lbUserID];
        [_contentContainer addSubview:_gubunLineView1];
        [_contentContainer addSubview:_btnGoLogin1];
        [_contentContainer addSubview:_btnMoveFindPW];
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
    
    [_lbUserIDTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(30.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(50.f);
        make.width.equalTo(@50.f);
        make.height.equalTo(@20.f);
    }];
    
    [_lbUserID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(25.f);
        make.left.equalTo(_lbUserIDTitle.mas_right).with.offset(20.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-20.f);
        make.height.equalTo(@30.f);
    }];
    
    [_gubunLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbUserIDTitle.mas_bottom).with.offset(30.f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@1.f);
    }];
    
    [_btnGoLogin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLineView1.mas_bottom).with.offset(30.f);
        make.centerX.equalTo(self).with.offset(-80.f);
        make.width.equalTo(@100.f);
        make.height.equalTo(@40.f);
    }];
    
    [_btnMoveFindPW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gubunLineView1.mas_bottom).with.offset(30.f);
        make.centerX.equalTo(self).with.offset(80.f);
        make.width.equalTo(@100.f);
        make.height.equalTo(@40.f);
    }];
}

- (void) goLoginPage:(UIButton *)btn
{
    if (_move_login1) {
        _move_login1();
    }
}

- (void) goFindPwPage:(UIButton *)btn
{
    if (_move_FindPW) {
        _move_FindPW();
    }
}



@end
