//
//  FFMainWebViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 9.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFMainWebViewController.h"

// ViewController
#import "FFLoginViewController.h"
#import "FFCrawlingViewController.h"

//Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"
//#import "UIWebView+Javascript.h"
#import "FFUtility.h"

// Manager
#import "FFNetworkManager.h"

// Library
#import <STPopup/STPopup.h>
#import <AFNetworking/AFNetworking.h>
#import <Toast/UIView+Toast.h>
#import <MessageUI/MessageUI.h>
#import <sys/utsname.h>
//#import <UIKit/UIKit.h>

@interface FFMainWebViewController() <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *mainFFView;
//@property (strong, nonatomic) WKWebView *mainFFView2;
@property (strong, nonatomic) UIImageView *splashImgView;
@property (strong, nonatomic) UIImageView *top_logo;
@property (strong, nonatomic) UIImageView *intro_logo;
@property (nonatomic) NSTimer *rmTimer;
@property (nonatomic) NSString *mb_id;
@property (strong, nonatomic) UIView *maskView;
@property (nonatomic) NSString *consultant_id;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *detailURL;
@property (nonatomic) NSDate *methodStart;
@property (nonatomic) NSTimeInterval executionTime;
@property (strong, nonatomic) FFCrawlingViewController *crawlingVC;
@property (strong, nonatomic) FFLoginViewController *loginVC;

@end

@implementation FFMainWebViewController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

/**
 로그인 후 계정에 해당하는 메인 페이지를 보여주기 위해 데이터 세팅하는 파라미터

 @param parameters 로그인 때 지정한 파라미터
 @return 세팅된 화면
 */
- (instancetype) initWithParameter:(NSDictionary *)parameters
{
    NSLog(@"넘어온 파라미터 값 : %@", parameters);
    self = [super init];
    if (self) {
        _mb_id = [parameters valueForKey:@"mb_id"];
        _consultant_id = [parameters valueForKey:@"consultant_id"];
        _password = [parameters valueForKey:@"password"];
        
        NSLog(@"각 저장된 값 : mb_id = %@, consultant_id = %@, password = %@", _mb_id, _consultant_id, _password);
    }
    return self;
}

/**
 크롤링 후 다시 메인으로 돌아올 때 상세화면으로 가기 위한 메서드

 @param url 상세화면 url
 @return 상세화면 url이 적용된 webview
 */
- (instancetype) initWithURL:(NSString *)url
{
    NSLog(@"url정보 : %@", url);
    self = [super init];
    if(self) {
        _detailURL = url;
        
        NSURL *firstUrl = [NSURL URLWithString:_detailURL];
        NSURLRequest *firstRequest = [NSURLRequest requestWithURL:firstUrl];
        
        [_mainFFView loadRequest:firstRequest];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor ff_c5Color]];
    
    [self preferredStatusBarStyle];
    
    _mainFFView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _mainFFView.delegate = self;
    _mainFFView.scrollView.bounces = NO;
    
    _maskView = [[UIView alloc] init];
    _maskView.backgroundColor = [UIColor ff_c17Color];
    
    NSString *serverURL = [NSString api_baseURL];
    
    NSLog(@"캐시 청소 시작!!!");
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSLog(@"캐시 청소 끝!!!");

    NSLog(@"쿠키 청소 시작!!!");
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([[cookie domain] isEqualToString:[NSString stringWithFormat:@"%@", [NSString api_baseURL]]]) {
            NSLog(@"지워져라 쿠키들!!!");
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    NSLog(@"쿠키 청소 끝!!!");

    self.automaticallyAdjustsScrollViewInsets = false;
    if (@available(iOS 11.0, *)) {
        [self.mainFFView.scrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
    }

//    NSString *device_gubun = @"ios";
//    NSString *device_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//    NSString *nPw = [_password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *loadUrl = [NSString stringWithFormat:@"%@/mobile/login.do?mb_id=%@&consultant_id=%@&password=%@&device_gubun=%@&device_id=%@", serverURL, _mb_id, _consultant_id, nPw, device_gubun, device_id];
////    NSString *loadUrl = @"http://m.factfinder.me/mobile/jquery_list.go?MB_ID=GNX&CONSULTANT_ID=guest";
////    NSString *loadUrl = @"https://m.naver.com/";
//    NSURL *firstUrl = [NSURL URLWithString:loadUrl];
//    NSURLRequest *firstRequest = [NSURLRequest requestWithURL:firstUrl];
//
//    [_mainFFView loadRequest:firstRequest];
    
    NSString *device_gubun = @"ios";
    NSString *device_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    //    NSString *loadUrl = [NSString stringWithFormat:@"%@/mobile/login.do?mb_id=%@&consultant_id=%@&password=%@&device_gubun=%@&device_id=%@", serverURL, _mb_id, _consultant_id, _password, device_gubun, device_id];
    //    NSString *loadUrl = @"http://m.factfinder.me/mobile/jquery_list.go?MB_ID=GNX&CONSULTANT_ID=guest";
    //    NSString *loadUrl = @"https://m.naver.com/";
    NSString *nPw = [_password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *firstUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/bridge.go", serverURL]];
    NSString *body = [NSString stringWithFormat:@"mb_id=%@&consultant_id=%@&password=%@&device_gubun=%@&device_id=%@&menu=login", _mb_id, _consultant_id, nPw, device_gubun, device_id];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:firstUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    [_mainFFView loadRequest:request];
    
    [self.view addSubview:_mainFFView];
    [self.view addSubview:_maskView];
    
    [self makeConstraints];
    
    [self screenHideView];
}

/**
 화면이 변경될 때 동작하는 메서드
 
 크롤링 화면에서 해당 VC로 접근한 경우 상세URL 값이 있을 때 웹뷰의 url을 상세URL로 변경
 
 크롤링 때 적용한 임시저장소를 접근 시 제거하여 예상되는 오류들이 동작하지 못하도록 설정

 @param animated 화면 변경 여부
 */
-(void) viewWillAppear:(BOOL)animated
{
//    [self requestCheckAppVersion];
    NSLog(@"설마,,, = %@", _detailURL);
    if ([_detailURL length] != 0) {
        NSURL *firstUrl = [NSURL URLWithString:_detailURL];
        NSURLRequest *firstRequest = [NSURLRequest requestWithURL:firstUrl];

        [_mainFFView loadRequest:firstRequest];
    }
    _detailURL = @"";
    
    [self removeSaveData];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    NSString *machineName = [self deviceName];
    NSLog(@"기기 모델명 = %@", machineName);

    if ([machineName isEqualToString:@"iPhone10,3"] || [machineName isEqualToString:@"iPhone10,6"] || [machineName isEqualToString:@"iPhone11,2"] || [machineName isEqualToString:@"iPhone11,4"] || [machineName isEqualToString:@"iPhone11,6"] || [machineName isEqualToString:@"iPhone11,8"] || [machineName isEqualToString:@"x86_64"]) {
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@.0f);
            make.left.and.right.equalTo(@.0f);
            make.height.equalTo(@30.f);
        }];
        
        [_mainFFView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(20.f);
            make.left.and.right.equalTo(@.0f);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-20.f);
        }];
    } else {
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@.0f);
            make.left.and.right.equalTo(@.0f);
            make.height.equalTo(@20.f);
        }];
        
        [_mainFFView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(20.f);
            make.left.and.right.equalTo(@.0f);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(0.f);
        }];
    }
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

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"나타나라");
    _methodStart = [NSDate date];
//    [self showAlertWithMessageOK:@"로드 시작"];
    
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"사라져라");
    NSDate *methodFinish = [NSDate date];
//    [self showAlertWithMessageOK:@"로드 끝"];
    _executionTime = [methodFinish timeIntervalSinceDate:_methodStart];
    NSLog(@"실행시간 = %f", _executionTime);
    [self timeRemoveView];
    [_splashImgView setHidden:YES];
}

- (void) timeRemoveView
{
    float runningTime = _executionTime + 0.5f;
    _rmTimer = [NSTimer scheduledTimerWithTimeInterval:runningTime / 2 target:self selector:@selector(removeDummyView) userInfo:nil repeats:NO];
}

- (void) removeDummyView
{
    [_splashImgView setHidden:YES];
}

#pragma mark - Call objectiveC from Javascript

/**
 자바스크립트와 웹뷰를 연결해주는 펑션

 @param webView 현재 화면의 웹뷰
 @param request 현재 웹뷰와 연결된 URL정보
 @param navigationType 화면 네비게이팅 정보
 @return 기능에 대한 정보를 실행할지에 대한 여부 리턴
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
    } else {
        NSString *destination = [request.URL absoluteString];
        NSArray *parts = [destination componentsSeparatedByString:@":"];
        for (int i = 0; i < parts.count; i++) {
            destination = [parts objectAtIndex:i];
            NSString *msgString = [destination stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
            NSLog(@"잡히니??? - %@", msgString);
            if ([msgString isEqualToString:@"sendUserData"]) {
                NSString *name = [(NSString *)[parts objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *juminFront = [[parts objectAtIndex:3] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *juminBack = [[parts objectAtIndex:4] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *hp = [[parts objectAtIndex:5] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *mobileco = [[parts objectAtIndex:6] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *orgCD = [[parts objectAtIndex:7] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *consultantNM = [[parts objectAtIndex:8] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *customer_seq = [[parts objectAtIndex:9] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                
                [[NSUserDefaults standardUserDefaults] setObject:juminFront forKey:@"userSsn1"];
                [[NSUserDefaults standardUserDefaults] setObject:juminBack forKey:@"userSsn2"];
                [[NSUserDefaults standardUserDefaults] setObject:orgCD forKey:@"orgCD"];
                [[NSUserDefaults standardUserDefaults] setObject:consultantNM forKey:@"consultantNM"];
                [[NSUserDefaults standardUserDefaults] setObject:customer_seq forKey:@"customer_seq"];
                [[NSUserDefaults standardUserDefaults] setObject:mobileco forKey:@"telComName"];
                
                NSLog(@"뽑힌 값들 = %@, %@, %@, %@, %@, %@, %@, %@", name, juminFront, juminBack, hp, mobileco, orgCD, consultantNM, customer_seq);
                [self moveCrawling:name :hp :mobileco :customer_seq :self];
            }
            if ([msgString isEqualToString:@"goLoginPage"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"로그아웃" message:@"로그아웃 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    _loginVC = [[FFLoginViewController alloc] init];
                    [FFUtility goHome:_loginVC];
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }];
                UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:commitAction];
                [alertController addAction:closeAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            if ([msgString isEqualToString:@"sendLoginPage"]) {
                _loginVC = [[FFLoginViewController alloc] init];
                [FFUtility goHome:_loginVC];
            }
            if ([msgString isEqualToString:@"sendSMS"]) {
                NSString *openURL1 = [(NSString *)[parts objectAtIndex:2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"URL 위치 = %@", openURL1);
                NSString *nOpenURL1 = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], openURL1];
                NSURL *openURL11 = [NSURL URLWithString:nOpenURL1];
                [[UIApplication sharedApplication] openURL:openURL11];
                return NO;
            }
            if ([msgString isEqualToString:@"sendEmail"]) {
                NSString *openURL2 = [(NSString *)[parts objectAtIndex:2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *nOpenURL2 = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], openURL2];
                NSURL *openURL21 = [NSURL URLWithString:nOpenURL2];
                [[UIApplication sharedApplication] openURL:openURL21];
                return NO;
            }
            if ([msgString isEqualToString:@"sendKakao"]) {
                NSString *openURL3 = [(NSString *)[parts objectAtIndex:2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *nOpenURL3 = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], openURL3];
                NSURL *openURL31 = [NSURL URLWithString:nOpenURL3];
                [[UIApplication sharedApplication] openURL:openURL31];
                return NO;
            }
            if ([msgString isEqualToString:@"callEvent"]) {
                NSString *hpNum = [[parts objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *pNumStr = [NSString stringWithFormat:@"tel://%@", hpNum];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pNumStr]];
            }
            if ([msgString isEqualToString:@"smsEvent"]) {
                NSString *hpNum = [[parts objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSString *pNumStr1 = [NSString stringWithFormat:@"sms://%@", hpNum];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:pNumStr1]];
            }
            if ([msgString isEqualToString:@"copyBankNum"]) {
                NSString *bankNum = [[parts objectAtIndex:2] stringByReplacingOccurrencesOfString:@"ffMobile" withString:@""];
                NSLog(@"저장된 통장번호 = %@", bankNum);
                [[UIPasteboard generalPasteboard] setString:bankNum];
                [self showAlertWithMessage:@"클립보드에 저장되었습니다."];
            }
            if ([msgString isEqualToString:@"webAlert"]) {
                NSString *alertString = [(NSString *)[parts objectAtIndex:2] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [self.view makeToast:alertString duration:1.5 position:CSToastPositionBottom];
            }
            
            if ([msgString isEqualToString:@"riseWindowOpen"]) {
                NSString *openURL2 = [(NSString *)[parts objectAtIndex:2] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *nOpenURL3 = @"";
                if ([openURL2 isEqualToString:@"http"]) {
                    NSString *openURL3 = [(NSString *)[parts objectAtIndex:3] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    nOpenURL3 = [NSString stringWithFormat:@"http:%@", openURL3];
                } else {
                    nOpenURL3 = [NSString stringWithFormat:@"%@://", openURL2];
                }
                NSURL *openURL31 = [NSURL URLWithString:nOpenURL3];
                NSLog(@"이동할 URL = %@", openURL31);
                [[UIApplication sharedApplication] openURL:openURL31];
            }
        }
    }
    return YES;
}

/**
 메인 리스트 화면에서 신규분석, 재분석, 내보험 찾아줌 기능을 사용할 때 접근되는 메서드
 
 웹뷰 브릿지 메서드에서 받은 데이터를 크롤링 VC의 initWithData에 값 매칭

 @param userName 고객 이름
 @param userTelNum 고객 핸드폰번호
 @param userTelCom 고객 핸드폰번호의 통신사
 @param customer_seq 고객 Sequence
 @param parent 현재 VC (FFMainWebViewController)
 */
- (void) moveCrawling:(NSString *) userName :(NSString *)userTelNum :(NSString *)userTelCom :(NSString *)customer_seq :(FFMainWebViewController *)parent
{
    _crawlingVC = [[FFCrawlingViewController alloc] initWithData:userName :userTelNum :userTelCom :customer_seq :parent];
    [FFUtility changeRootViewController:_crawlingVC];
}

+ (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

- (void) screenHideView
{
    NSString *machineName = [self deviceName];
    NSLog(@"기기 모델명 = %@", machineName);
    NSString *iPADYN = [machineName substringWithRange:NSMakeRange(0,4)];
    NSLog(@"아이패드니??? - %@", iPADYN);
    if ([iPADYN isEqualToString:@"iPad"] || [machineName isEqualToString:@"x86_64"]) {
        _splashImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_2"]];
    } else {
        _splashImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_1"]];
    }
    _top_logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_txt3"]];
    [_splashImgView addSubview:_top_logo];
    [self.view addSubview:_maskView];
    [self.view addSubview:_splashImgView];
    
    if ([machineName isEqualToString:@"iPhone10,3"] || [machineName isEqualToString:@"iPhone10,6"]) {
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@.0f);
            make.left.and.right.equalTo(@.0f);
            make.height.equalTo(@30.f);
        }];
        
        [_splashImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_maskView.mas_bottom);
            make.left.and.right.and.bottom.equalTo(@.0f);
        }];
        
        [_top_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_splashImgView.mas_top).with.offset(129.f);
            make.centerX.equalTo(self.view);
            make.width.equalTo(@230.f);
            make.height.equalTo(@214.f);
        }];
    } else {
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@.0f);
            make.left.and.right.equalTo(@.0f);
            make.height.equalTo(@20.f);
        }];
        
        [_splashImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_maskView.mas_bottom);
            make.left.and.right.and.bottom.equalTo(@.0f);
        }];
        
        [_top_logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_splashImgView.mas_top).with.offset(129.f);
            make.centerX.equalTo(self.view);
            make.width.equalTo(@230.f);
            make.height.equalTo(@214.f);
        }];
    }
}

- (void) removeSaveData
{
    NSLog(@"저장된 내용 지우기 시작!!!");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"smsSeq"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"signIdx"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userSsn1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"customer_seq"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"goListURL"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"signIdx"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"telComName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TELCOM_RESULT"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"popupUserData"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"popupUserData1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"popupUserData2"];
    NSLog(@"저장된 내용 지우기 끝!!!");
}


@end
