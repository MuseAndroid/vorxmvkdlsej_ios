//
//  FFUserAgreePopupViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 19.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFUserAgreePopupViewController.h"

// View
#import "FFUserAgreeView.h"

// ViewController
#import "FFCrawlingViewController.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

// Manager
#import "FFNetworkManager.h"

// Library
#import <STPopup/STPopup.h>
#import <Toast/UIView+Toast.h>

@interface FFUserAgreePopupViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FFUserAgreeView *userAgreeView;
@property (strong, nonatomic) FFCrawlingViewController *crawlingVC;
@property (nonatomic) NSString *const_id;
@property (nonatomic) NSString *const_nm;
@property (nonatomic) NSString *custHP;
@property (nonatomic) NSString *mb_id;
@property (nonatomic) NSString *mobile_co;
@property (nonatomic) NSString *cust_nm;

@end

@implementation FFUserAgreePopupViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"  고객정보활용동의";
        self.contentSizeInPopup = CGSizeMake(320, 500);
        self.landscapeContentSizeInPopup = CGSizeMake(320, 330);
        [STPopupNavigationBar appearance].barTintColor = [UIColor ff_c1Color];
        [STPopupNavigationBar appearance].tintColor = [UIColor clearColor];
        [STPopupNavigationBar appearance].titleTextAttributes= @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:14.f],
                                                                  NSForegroundColorAttributeName: [UIColor ff_c5Color]};
        [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
        
        [[UIBarButtonItem appearanceWhenContainedIn:[STPopupNavigationBar class], nil]
         setTitleTextAttributes:@{ NSFontAttributeName: [UIFont appleSDGothicNeoMediumWithSize:14.f],
                                   NSForegroundColorAttributeName: [UIColor ff_c5Color]} forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _userAgreeView = [[FFUserAgreeView alloc] init];
    
    __weak typeof(self) weakSelf = self;
    _userAgreeView.sendSMSHandler = ^() {
        [weakSelf sendSMS];
    };
    
    _userAgreeView.sendSignHandler = ^() {
        [weakSelf openSignPage];
    };
    
    _userAgreeView.cancelWindowHandler = ^() {
        [weakSelf closePage];
    };
    
    [_scrollView addSubview:_userAgreeView];
    [_contentContainer addSubview:_scrollView];
    
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = _userAgreeView.frame.size;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_userAgreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).with.offset(5.f);
        make.centerX.equalTo(_contentContainer.mas_centerX);
        make.height.equalTo(@495.f);
    }];
}


/**
 Sign 버튼 누를 때 접근되는 메서드
 
 버튼을 누르면 미리 저장된 고객의 데이터를 파라미터로 ajax호출 후 seq, idx를 리턴 받음
 
 seq, idx값을 url 뒤에 파라미터로 넣어 새 웹페이지(Safari) 호출
 
 사인패드가 있는 고객정보활용동의 페이지가 safari를 통해 보여지게 됨
 */
- (void) openSignPage
{
//    [self showAlertWithMessage:@"사인 웹 페이지 준비 중"];
    NSDictionary *giveData2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"popupUserData2"];
    NSLog(@"전달받은 데이터 - %@", giveData2);
    _mb_id = [giveData2 objectForKey:@"MB_ID"];
    _const_id = [giveData2 objectForKey:@"CONSULTANT_ID"];
    _const_nm = [giveData2 objectForKey:@"CONSULTANT_NAME"];
    _cust_nm = [giveData2 objectForKey:@"CUSTOMER_NAME"];
    _custHP = [giveData2 objectForKey:@"CUST_HP"];
    _mobile_co = [giveData2 objectForKey:@"MOBILE_CO"];
    
    NSString *sendURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/sendCustInfoAgreeSMS01.ajax"];
    NSLog(@"URL확인 : %@", sendURL);
    [FFNetworkManager url:sendURL parameter:giveData2 success:^(NSDictionary *data) {
        NSString *resultData = [data valueForKey:@"result"];
        NSLog(@"결과 값 : %@", resultData);
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[resultData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSString *status = [jsonObject valueForKey:@"status"];
        _rSeq = [jsonObject valueForKey:@"seq"];
        _rIdx = [jsonObject valueForKey:@"idx"];
        NSLog(@"받아온 값 : 상태 - %@, 시퀀스 - %@", status, _rSeq);
        [self saveSequence:_rSeq];
        [self saveIndex:_rIdx];
        if ([status isEqualToString:@"OK"]) {
            NSURL *signURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/personalInfoAgree.go?SEQ=%@&IDX=%@&PAGE_GUBUN=2", [NSString api_baseURL], _rSeq, _rIdx]];
            [[UIApplication sharedApplication] openURL:signURL];
            [self closePage];
        }
    } failure:^(NSError *error) {
        NSLog(@"에러내용 : %@", error);
        [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 고객동의 사인 인덱스 요청부, 에러내용 : %@", error] :_mb_id :_const_id :_cust_nm :_custHP :@"" :_mobile_co];
        [self.view makeToast:@"사인페이지 이동에 문제가 발생했습니다\n다시 시도해주세요" duration:1.5 position:CSToastPositionBottom];
    }];
}

/**
 SMS버튼 누를 때 접근하는 메서드
 
 미리 저장된 고객정보를 parameter로 ajax를 호출하여 seq와 전송상태를 리턴 받음
 
 서버에선 전달된 고객정보로 고객 핸드폰번호에 요청 문자를 보냄
 
 앱에선 전송상태에 따라 OK값이 떨어지면 고객에게 전송 완료 대기 시간 3분이라는 안내 팝업을 표현하며 3분동안 Spinner가 표현됨
 */
- (void) sendSMS
{
//    [self showAlertWithMessage:@"문자 전송 기능 준비 중"];
    NSDictionary *giveData1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"popupUserData1"];
    NSLog(@"전달받은 데이터 - %@", giveData1);
    
    _mb_id = [giveData1 objectForKey:@"MB_ID"];
    _const_id = [giveData1 objectForKey:@"CONSULTANT_ID"];
    _const_nm = [giveData1 objectForKey:@"CONSULTANT_NAME"];
    _cust_nm = [giveData1 objectForKey:@"CUSTOMER_NAME"];
    _custHP = [giveData1 objectForKey:@"CUST_HP"];
    _mobile_co = [giveData1 objectForKey:@"MOBILE_CO"];
    
    NSString *sendURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/sendCustInfoAgreeSMS01.ajax"];
    NSLog(@"URL확인 : %@", sendURL);
    [FFNetworkManager url:sendURL parameter:giveData1 success:^(NSDictionary *data) {
        NSString *resultData = [data valueForKey:@"result"];
        NSLog(@"결과 값 : %@", resultData);
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:[resultData dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSString *status = [jsonObject valueForKey:@"status"];
        _rSeq = [jsonObject valueForKey:@"seq"];
        NSLog(@"받아온 값 : 상태 - %@, 시퀀스 - %@", status, _rSeq);
        if ([status isEqualToString:@"OK"]) {
            [self saveSequence:_rSeq];
            UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            topWindow.rootViewController = [UIViewController new];
            topWindow.windowLevel = UIWindowLevelAlert + 1;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"문자를 전송했습니다." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self closePage];
                topWindow.hidden = YES;
            }];
            [alertController addAction:commitAction];
            [topWindow makeKeyAndVisible];
            [topWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
        } else {
            UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            topWindow.rootViewController = [UIViewController new];
            topWindow.windowLevel = UIWindowLevelAlert + 1;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"서버에 문제가 발생했습니다\n잠시 후 다시 시도해주세요" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                topWindow.hidden = YES;
            }];
            [alertController addAction:commitAction];
            [topWindow makeKeyAndVisible];
            [topWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
        }
    } failure:^(NSError *error) {
        NSLog(@"에러내용 : %@", error);
        [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 고객동의 문자 시퀀스 요청부, 에러내용 : %@", error] :_mb_id :_const_id :_cust_nm :_custHP :@"" :_mobile_co];
        [self.view makeToast:@"문자 전송에 문제가 발생했습니다\n다시 시도해주세요" duration:1.5 position:CSToastPositionBottom];
    }];
}

/**
 팝업 하단의 닫기 버튼을 눌렀을 때 팝업을 없애는 동작을 하는 메서드
 */
- (void) closePage
{
    NSLog(@"도착했니???");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSString *)returnSEQ
{
    return _rSeq;
}

@end
