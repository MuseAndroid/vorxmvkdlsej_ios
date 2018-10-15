//
//  FFCaptcahViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFCaptcahViewController.h"

// View
#import "FFCaptcahView.h"
#import "FFNavigationBar.h"
#import "FFTextField.h"

// ViewController
#import "FFCrawlingViewController.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <STPopup/STPopup.h>

@interface FFCaptcahViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UIView *contentContainer;
//@property (strong, nonatomic) FFCaptcahView *captcahView;
@property (strong, nonatomic) FFTextField *secureTxtFld;
@property (atomic) UIImageView *captcahImage;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIButton *reCaptchaButton;
@property (strong, nonatomic) FFCrawlingViewController *crawlingVC;
@property (strong, nonatomic) FFNavigationBar *naviBar;
@property (nonatomic) NSData *captchaImg;
@property (nonatomic) NSTimer *refreshTimer;
@property (nonatomic) NSTimer *closeTimer;

@end

@implementation FFCaptcahViewController

- (instancetype) init;
{
    self = [super init];
    if (self) {
        self.title = @"보안문자확인";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeUIAsset];
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
    
    [_captcahImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(80.f);
        make.centerX.equalTo(_contentContainer).with.offset(-20.f);
        make.width.equalTo(@200.f);
        make.height.equalTo(@60.f);
    }];
    
    [_reCaptchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(80.f);
        make.left.equalTo(_captcahImage.mas_right).with.offset(12.5f);
        make.width.equalTo(@60.f);
        make.height.equalTo(@60.f);
    }];
    
    [_secureTxtFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_captcahImage.mas_bottom).with.offset(12.5f);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@240.f);
        make.height.equalTo(@40.f);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_secureTxtFld.mas_bottom).with.offset(20.f);
        make.left.equalTo(@12.5f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@40.f);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"==========================================");
    NSLog(@"새로고침!!!");
    NSLog(@"==========================================");
    NSData *cImg = [NSUserDefaults.standardUserDefaults objectForKey:@"CaptcahImg"];
    _captcahImage.image = [UIImage imageWithData:cImg];
}

- (void) certViewRise: (id) sender // 테스트 위해 임시로 팝업에 이벤트 연결  실제는 ViewController에 Btn2Click 메서드에 연결해야 함
{
    [self reqCertView];
}

- (void) reqCertView
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userSsn1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn1"];
    NSString *userSsn2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn2"];
    NSString *userHpNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHpNum"];
    NSString *telComName1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"telComName"];
    NSString *nationCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"];
    NSString *confirmTxt = _secureTxtFld.text;
    if ([confirmTxt length] == 0) {
        [self showAlertWithMessageOK:@"보안문자를 입력해주시기 바랍니다"];
    } else {
        NSLog(@"캡챠코드 값 = %@", confirmTxt);
        [self closePage1];
        [self btn2Click:userName :userSsn1 :userSsn2 :userHpNum :telComName1 :confirmTxt :nationCD];
    }
}

- (void) reReqCaptcha:(id) sender
{
//    [_captcahImage removeFromSuperview];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userSsn1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn1"];
    NSString *userSsn2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn2"];
    NSString *userHpNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHpNum"];
    NSString *telComName1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"telComName"];
    NSString *nationCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"];

    [self setCaptchaViewCon:self];
    [self btn1Click:userName :userSsn1 :userSsn2 :userHpNum :telComName1 :nationCD :@"captcha"];
////    [self closePage];
////    [self setCaptchaViewCon:self];
//    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:.55f target:self selector:@selector(closePage) userInfo:nil repeats:NO];
////    [self.contentContainer removeFromSuperview];
//    [_crawlingVC setDelayPopup];
}

- (void) closePage
{
    NSLog(@"도착했니???");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) closePage1
{
    NSLog(@"도착했니???");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CaptcahImg"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) closePage2
{
    NSLog(@"도착했니???");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CaptcahImg"];
    NSLog(@"%li",(long)self.accessibilityElementCount);
    [self dismissViewControllerAnimated:YES completion:nil];
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    UIAlertController *warningAlert = [UIAlertController alertControllerWithTitle:@"" message:@"분석을 취소하였습니다\n다시 분석을 진행해 주시기 바랍니다"
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    [warningAlert addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [warningAlert dismissViewControllerAnimated:NO completion:nil];
    }]];
    
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:warningAlert animated:NO completion:nil];
}

- (void) refreshCaptchaImg:(NSData *) cImg :(NSString *)viewGubun
{
//    _captcahImage.image = [UIImage imageWithData:cImg];
    [self viewWillAppear:YES];
}

- (void) makeUIAsset
{
    self.view.backgroundColor = [UIColor ff_c5Color];
    
    self.ff_hasNavigationBar = YES;
    _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleRight];
    _naviBar.title = self.title;
    __weak typeof(self) weakSelf = self;
    _naviBar.rightButtonHandler = ^() {
        [weakSelf closePage2];
    };
    
    _crawlingVC = [[FFCrawlingViewController alloc] init];
    
    NSData *captcah = [[NSUserDefaults standardUserDefaults] objectForKey:@"CaptcahImg"];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    
    _captcahImage = [[UIImageView alloc] init];
    _captcahImage.image = [UIImage imageWithData:captcah];
    
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
    [_reCaptchaButton addTarget:self action:@selector(reReqCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    
    _confirmButton = [[UIButton alloc] init];
    _confirmButton.backgroundColor = [UIColor ff_c2Color];
    _confirmButton.layer.cornerRadius = 5.f;
    _confirmButton.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:15.f];
    [_confirmButton setTitle:@"보안문자확인" forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(certViewRise:) forControlEvents:UIControlEventTouchUpInside];
    
    [_contentContainer addSubview:_captcahImage];
    [_contentContainer addSubview:_secureTxtFld];
    [_contentContainer addSubview:_reCaptchaButton];
    [_contentContainer addSubview:_confirmButton];
    
    [self.view addSubview:_naviBar];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_secureTxtFld]) {
        [self reqCertView];
    }
    return YES;
}

@end
