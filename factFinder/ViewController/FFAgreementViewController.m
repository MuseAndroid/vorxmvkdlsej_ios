//
//  FFAgreementViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 11.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFAgreementViewController.h"

// View
#import "FFAgreementView.h"
#import "FFNavigationBar.h"

// ViewController
#import "FFNavigationViewController.h"
#import "FFLoginViewController.h"
#import "FFJoinViewController.h"

// PopupViewController
#import "FFUserServiceViewController.h"
#import "FFPersonalInfoViewController.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"
#import "FFUtility.h"

// Library
#import <STPopup/STPopup.h>
#import <Masonry/Masonry.h>

@interface FFAgreementViewController ()

@property (strong, nonatomic) FFNavigationBar *naviBar;
@property (strong, nonatomic) FFLoginViewController *loginVC;
@property (strong, nonatomic) FFJoinViewController *joinVC;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) FFAgreementView *agreementView;

@end

@implementation FFAgreementViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"이용약관동의";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    self.ff_hasNavigationBar = YES;
    self.ff_navigationBar.leftButtonHandler = ^() {
        _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleBack];
        [weakSelf backHome];
    };
    self.ff_navigationBar.title = self.title;
    
    self.view.backgroundColor = [UIColor ff_c5Color];
    
    _loginVC = [[FFLoginViewController alloc] init];
    
    _joinVC = [[FFJoinViewController alloc] init];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    
    _agreementView = [[FFAgreementView alloc] init];
    _agreementView.goAgreePopup1Handler = ^() {
        [weakSelf risePopup1];
    };
    _agreementView.goAgreePopup2Handler = ^() {
        [weakSelf risePopup2];
    };
    _agreementView.goJoinHandler = ^() {
        [weakSelf goJoinView];
    };
    
    [_contentView addSubview:_agreementView];
    [_scrollView addSubview:_contentView];
    [_contentContainer addSubview:_scrollView];
    
    [self.view addSubview:_naviBar];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = _contentView.frame.size;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
//    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@.0f);
//        make.left.and.right.equalTo(self.view);
//        make.height.equalTo(@80.f);
//    }];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12.5f);
        make.right.equalTo((@-12.5f));
        make.top.equalTo(@80.f);
        make.bottom.equalTo((@-12.5f));
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(.0f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(.0f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(.0f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(.0f);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(.0f);
        make.left.equalTo(_scrollView.mas_left);
        make.right.equalTo(_scrollView.mas_right);
        make.width.equalTo(_contentContainer.mas_width).with.offset(.0f);
        make.height.equalTo(@800.0f);
    }];
    
    [_agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.left.equalTo(_contentView.mas_left);
        make.right.equalTo(_contentView.mas_right);
        make.bottom.equalTo(_contentView.mas_bottom);
    }];
}

- (void) backHome
{
    [FFUtility changeRootViewController:_loginVC];
}

- (void) risePopup1
{
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFUserServiceViewController new]];
    [popupController presentInViewController:self];
}

- (void) risePopup2
{
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFPersonalInfoViewController new]];
    [popupController presentInViewController:self];
}

- (void) goJoinView
{
    [FFUtility changeRootViewController:_joinVC];
}

@end
