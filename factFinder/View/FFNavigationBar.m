//
//  FFNavigationBar.m
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFNavigationBar.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <sys/utsname.h>

@interface FFNavigationBar()

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation FFNavigationBar

-(instancetype) init
{
    return [self initWithStyle:FFNavigationBarStyleBack];
}

- (instancetype) initWithStyle:(FFNavigationBarStyle)style
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor ff_c1Color];
        _style = style;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:20.f];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _leftButton = [[UIButton alloc] init];
        _rightButton = [[UIButton alloc] init];
        [self reloadButtonIcon];
        [self.leftButton addTarget:self action:@selector(leftButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton addTarget:self action:@selector(rightButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleLabel];
        [self addSubview:_leftButton];
        [self addSubview:_rightButton];
        [self makeConstraints];
    }
    return self;
}

#pragma mark - Layout

-(void) makeConstraints
{
    [super makeConstraints];
    
    NSString *machineName = [self deviceName];
    NSLog(@"기기 모델명 = %@", machineName);
    if ([machineName isEqualToString:@"iPhone10,3"] || [machineName isEqualToString:@"iPhone10,6"] || [machineName isEqualToString:@"x86_64"]) {
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@35.f);
            make.bottom.equalTo(@.0f);
            make.height.equalTo(@70.f);
        }];
        
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40.f);
            make.left.equalTo(@10.f);
            make.bottom.equalTo((@-10.f));
            make.width.and.height.equalTo(@35.f);
        }];
        
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@40.f);
            make.right.equalTo((@-10.f));
            make.bottom.equalTo((@-10.f));
            make.width.and.height.equalTo(@25.f);
        }];
    } else {
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@20.f);
            make.bottom.equalTo(@.0f);
            make.height.equalTo(@44.f);
        }];
        
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@25.f);
            make.left.equalTo(@10.f);
            make.bottom.equalTo((@-10.f));
            make.width.and.height.equalTo(@35.f);
        }];
        
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@25.f);
            make.right.equalTo((@-10.f));
            make.bottom.equalTo((@-10.f));
            make.width.and.height.equalTo(@25.f);
        }];
    }
}

- (void) reloadButtonIcon
{
    UIImage *leftIcon;
    UIImage *rightIcon;
    if (_style == FFNavigationBarStyleBack) {
        leftIcon = [UIImage imageNamed:@"left_btn"];
        [_leftButton setImage:leftIcon forState:UIControlStateNormal];
    } else if (_style == FFNavigationBarStyleRight){
        rightIcon = [UIImage imageNamed:@"btnClose"];
        [_rightButton setImage:rightIcon forState:UIControlStateNormal];
    }
    
}

- (void)leftButtonTouched:(UIButton *)leftButton
{
    if (_leftButtonHandler) {
        _leftButtonHandler();
    }
}

- (void)rightButtonTouched:(UIButton *)rightButton
{
    if (_rightButtonHandler) {
        _rightButtonHandler();
    }
}

#pragma mark - Setter
- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setStyle:(FFNavigationBarStyle)style
{
    _style = style;
    [self reloadButtonIcon];
}

#pragma mark - Getter
- (NSString *)title
{
    return _titleLabel.text;
}

/**
 아이폰, 아이패드, 아이폰X을 검출하는 메서드
 
 아이폰 앱 배포 시 각 기기의 디자인가이드를 맞추기 위해 기기명 검색하는 메서드
 
 @return 기기명 (애플에서 지정한 기기명)
 */
- (NSString *)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

@end
