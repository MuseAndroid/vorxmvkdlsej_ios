//
//  FFCertViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFCertViewController.h"

// View
#import "FFCertCodeView.h"
#import "FFNavigationBar.h"

// viewController
#import "FFCrawlingViewController.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <STPopup/STPopup.h>

@interface FFCertViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) FFCertCodeView *certView;
@property (strong, nonatomic) FFCrawlingViewController *crawlingVC;
@property (strong, nonatomic) FFNavigationBar *naviBar;

@end

@implementation FFCertViewController
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.title = @"문자인증번호 확인";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ff_c5Color];
    
    self.ff_hasNavigationBar = YES;
    _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleRight];
    _naviBar.title = self.title;
    __weak typeof(self) weakSelf = self;
    _naviBar.rightButtonHandler = ^() {
        [weakSelf closePage2:0];
    };
    
    _crawlingVC = [[FFCrawlingViewController alloc] init];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    
    _certView = [[FFCertCodeView alloc] init];
    _certView.searchHandler = ^{
        [weakSelf searchBohum];
    };
    _certView.stopHandler = ^{
        [weakSelf closePage2:1];
    };
    
    [_contentContainer addSubview:_certView];
    [self.view addSubview:_naviBar];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(@.0f);
    }];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviBar.mas_bottom);
        make.left.equalTo(@.0f);
        make.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_certView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(-5.f);
    }];
}

- (void) searchBohum // 상용으로 돌릴 시 btn3Click 메서드와 연동시켜야 함.
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userSsn1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn1"];
    NSString *userSsn2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn2"];
    NSString *userHpNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHpNum"];
    NSString *telComName = [[NSUserDefaults standardUserDefaults] objectForKey:@"telComName"];
    NSString *nationCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"];
    NSString *smsResult = [_certView smsResult];
    if ([smsResult length] == 0) {
        [self showAlertWithMessageOK:@"인증번호를 입력해 주시기 바랍니다."];
    } else if ([smsResult length] != 6) {
        [self showAlertWithMessageOK:@"인증번호 6자리를 다시 확인바랍니다."];
    } else {
        [self closePage1];
        
        [self btn3Click:userName :userSsn1 :userSsn2 :userHpNum :telComName :smsResult :nationCD];
    }
}

- (void) closePage
{
    NSLog(@"도착했니???");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) closePage1
{
    NSLog(@"도착했니???");
    [NSUserDefaults.standardUserDefaults setBool:false forKey:@"certFlag"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) closePage2:(int) status
{
    NSLog(@"도착했니???");
    NSString *alertTitle = @"";
    switch (status) {
        case 0:
            alertTitle = @"분석을 취소하였습니다\n다시 분석을 진행해 주시기 바랍니다";
            break;
        case 1:
            alertTitle = @"인증문자 입력시간을 초과하였습니다\n다시 분석을 진행해 주시기 바랍니다";
            break;
    }
    [NSUserDefaults.standardUserDefaults setBool:false forKey:@"certFlag"];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    UIAlertController *warningAlert = [UIAlertController alertControllerWithTitle:@"" message:alertTitle
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    [warningAlert addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (status == 0) {
            [_certView.stopwatch invalidate];
        }
        [warningAlert dismissViewControllerAnimated:NO completion:nil];
    }]];
    
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:warningAlert animated:NO completion:nil];
}

@end
