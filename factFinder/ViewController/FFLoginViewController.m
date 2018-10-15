//
//  FFLoginViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFLoginViewController.h"

//View
#import "FFComLoginView.h"
#import "FFPersonalLoginView.h"

// ViewController
#import "FFMainWebViewController.h"
#import "FFAgreementViewController.h"
#import "FFCrawlingViewController.h"
//#import "FFWkViewController.h"
#import "FFFindUserDataViewController.h"
#import "FFFindUserData1ViewController.h"
#import "FFFindUserIDPWViewController.h"

// Utility
#import "FFUtility.h"
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

// Manager
#import "FFNetworkManager.h"

// Library
#import <AFNetworking/AFNetworking.h>
#import <Toast/UIView+Toast.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <Masonry/Masonry.h>
#import <sys/utsname.h>

@interface FFLoginViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *backImage;
@property (strong, nonatomic) UIView *contentBody;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *contentView1;
@property (strong, nonatomic) UIImageView *ffLogo;
@property (strong, nonatomic) UIImageView *ffCI;
@property (strong, nonatomic) UIView *line;
@property (strong, nonatomic) UIButton *companySel;
@property (strong, nonatomic) UIButton *personalSel;
@property (strong, nonatomic) UIButton *touchIDOnOff;
@property (strong, nonatomic) FFComLoginView *comLoginView;
@property (strong, nonatomic) FFPersonalLoginView *personalLoginView;
@property (strong, nonatomic) FFMainWebViewController *mainWebController;
// test
@property (strong, nonatomic) FFFindUserIDPWViewController *fuIpVC;
@property (strong, nonatomic) NSDictionary *saveParams;
// test
//@property (strong, nonatomic) FFWkViewController *wkWebViewController;
@property (strong, nonatomic) FFFindUserDataViewController *findUserVC;
@property (strong, nonatomic) FFFindUserData1ViewController *find1UserVC;
@property (strong, nonatomic) FFAgreementViewController *agreementController;
@property (strong, nonatomic) FFCrawlingViewController *crawlingVC;
@property (nonatomic) NSString *screenStatus;
@property (nonatomic) NSString *device_gubun;
@property (nonatomic) NSString *device_id;

@end

@implementation FFLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad 접근");
    
    [self preferredStatusBarStyle];
    
    _device_gubun = @"ios";
    _device_id=[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
    [self requestLoginInfo];
    
    _crawlingVC = [[FFCrawlingViewController alloc] init];
    
    NSString *machineName = [self deviceName];
    NSLog(@"기기 모델명 = %@", machineName);
    NSString *iPADYN = [machineName substringWithRange:NSMakeRange(0,4)];
    NSLog(@"아이패드니??? - %@", iPADYN);
    
    UIImage *checkImg = [UIImage imageNamed:@"login_radio_sel"];
    UIImage *unchkImg = [UIImage imageNamed:@"login_radio_nor"];
//    UIImage *switchOff = [UIImage imageNamed:@"off"];
//    UIImage *switchOn = [UIImage imageNamed:@"on"];
    UIGraphicsBeginImageContext(self.view.frame.size);
    if ([iPADYN isEqualToString:@"iPad"] || [machineName isEqualToString:@"x86_64"]) {
        [[UIImage imageNamed:@"intro_2"] drawInRect:self.view.bounds];
    } else {
        [[UIImage imageNamed:@"intro_1"] drawInRect:self.view.bounds];
    }
    UIImage *backImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _mainWebController = [[FFMainWebViewController alloc] init];
    
//    _wkWebViewController = [[FFWkViewController alloc] init];
    
    _agreementController = [[FFAgreementViewController alloc] init];
    
    _findUserVC = [[FFFindUserDataViewController alloc] init];
    
    _find1UserVC = [[FFFindUserData1ViewController alloc] init];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor colorWithPatternImage:backImage];
    
    
    _scrollView = [[UIScrollView alloc] init];
    
    _contentBody = [[UIView alloc] init];
    _contentBody.backgroundColor = [UIColor clearColor];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor clearColor];
    
    _contentView1 = [[UIView alloc] init];
    _contentView1.backgroundColor = [UIColor clearColor];
    
    _ffCI = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_ci"]];
    _ffLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    
//    _touchIDOnOff = [[UIButton alloc] init];
//    _touchIDOnOff.clipsToBounds = YES;
//    _touchIDOnOff.selected = NO;
//    _touchIDOnOff.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
//    [_touchIDOnOff setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [_touchIDOnOff setImage:switchOff forState:UIControlStateNormal];
//    [_touchIDOnOff setImage:switchOn forState:UIControlStateSelected];
//    [_touchIDOnOff setTitle:@"  지문으로 로그인" forState:UIControlStateNormal];
//    [_touchIDOnOff setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_touchIDOnOff addTarget:self action:@selector(switchAuth:) forControlEvents:UIControlEventTouchUpInside];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor ff_c13Color];
    
    _companySel = [[UIButton alloc] init];
    _companySel.clipsToBounds = YES;
    _companySel.selected = YES;
    _companySel.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    [_companySel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_companySel setImage:unchkImg forState:UIControlStateNormal];
    [_companySel setImage:checkImg forState:UIControlStateSelected];
    [_companySel setTitle:@"  기업회원" forState:UIControlStateNormal];
    [_companySel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_companySel addTarget:self action:@selector(selectBusiness:) forControlEvents:UIControlEventTouchUpInside];
    
    _personalSel = [[UIButton alloc] init];
    _personalSel.clipsToBounds = YES;
    _personalSel.selected = NO;
    _personalSel.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    [_personalSel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_personalSel setImage:unchkImg forState:UIControlStateNormal];
    [_personalSel setImage:checkImg forState:UIControlStateSelected];
    [_personalSel setTitle:@" 개인회원" forState:UIControlStateNormal];
    [_personalSel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_personalSel addTarget:self action:@selector(selectPersonal:) forControlEvents:UIControlEventTouchUpInside];
    
    _comLoginView = [[FFComLoginView alloc] init];
    _personalLoginView = [[FFPersonalLoginView alloc] init];
    
//    [self setKeyChainForTouchIdVerify];
    
    [_contentView addSubview:_ffCI];
    [_contentView addSubview:_ffLogo];
//    [_contentView addSubview:_touchIDOnOff];
    [_contentView1 addSubview:_companySel];
    [_contentView1 addSubview:_personalSel];
//    [_contentBody addSubview:_companySel];
//    [_contentBody addSubview:_personalSel];
    [_contentBody addSubview:_line];
    [_contentBody addSubview:_contentView1];
    [_contentBody addSubview:_contentView];
    [_scrollView addSubview:_contentBody];
    [_contentContainer addSubview:_scrollView];
    [self.view addSubview:_contentContainer];

    [self makeConstraints];
    
    [self makeComView];
}

/**
 스크롤뷰 이용 시 스크롤이 될 수 있도록 전체를 감싸고 있는
 contentBody의 사이즈를 스크롤뷰에 적용
 */
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrollView.contentSize = _contentBody.frame.size;
}

/**
 앱의 화면에 변화가 있을 때 들어오는 내부메서드
 화면을 이동할 때 유동적으로 변해야 하는 view들에 대해 업데이트 구문 추가

 @param animated animated
 */
- (void) viewWillAppear:(BOOL)animated
{
    [self requestCheckAppVersion];
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"fingerYN"] isEqualToString:@"FY"]) {
//        [self setKeyChainForTouchIdVerify];
//        _touchIDOnOff.selected = YES;
//    } else {
//        _touchIDOnOff.selected = NO;
//    }
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"loginScreen"]) {
        
    } else {
        _screenStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginScreen"];
        if ([_screenStatus isEqualToString:@"기업고객"]) {
            _companySel.selected = YES;
            _personalSel.selected = NO;
//            [_contentBody removeFromSuperview];
            [self makeComView];
        } else if ([_screenStatus isEqualToString:@"개인고객"]) {
            _personalSel.selected = YES;
            _companySel.selected = NO;
//            [_contentBody removeFromSuperview];
            [self makeUserView];
        }
    }
}

/**
 아이폰, 아이패드, 아이폰X를 구분하기 위해 각 기기의 device name을 체크하는 메서드

 @return 아이폰, 아이패드, 아이폰X의 기기명(ex. iPhone10,6)
 */
- (NSString *)deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

/**
 ViewDidLoad에서 준비한 각 아이템(구성요소)들을 그리는 메서드
 
 이 메서드는 모든 View의 부모클래스인 ViewController에 선언되어있음
 */
-(void) makeConstraints
{
    [super makeConstraints];
    
    NSLog(@"makeConstraints 접근");
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.and.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_contentBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView).with.offset(12.5f);
        make.left.and.right.and.equalTo(_contentContainer);
        make.height.equalTo(@800.f);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentBody.mas_top);
        make.left.equalTo(_contentBody.mas_left).with.offset(5.f);
        make.right.equalTo(_contentBody.mas_right).with.offset(-5.f);
        make.height.equalTo(@300.f);
    }];
    
    [_ffCI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentContainer);
        make.top.equalTo(_contentView.mas_top).with.offset(60.f);
    }];
    
    [_ffLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentContainer);
        make.top.equalTo(_ffCI.mas_bottom).with.offset(50.f);
    }];
    
//    [_touchIDOnOff mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_ffLogo.mas_bottom).with.offset(10.f);
//        make.centerX.equalTo(_contentContainer).with.offset(120.f);
//
//    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_bottom).with.offset(20.f);
        make.left.equalTo(_contentBody.mas_left).with.offset(5.f);
        make.right.equalTo(_contentBody.mas_right).with.offset(-5.f);
        make.height.equalTo(@1.f);
    }];
    
    [_contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line.mas_bottom).with.offset(10.f);
        make.left.equalTo(_contentBody.mas_left).with.offset(5.f);
        make.right.equalTo(_contentBody.mas_right).with.offset(-5.f);
        make.height.equalTo(@30.f);
    }];

    [_companySel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_top).with.offset(5.f);
        make.centerX.equalTo(_contentContainer).with.offset(-60.f);
    }];
    
    [_personalSel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_top).with.offset(5.f);
        make.centerX.equalTo(_contentContainer).with.offset(60.f);
    }];
    
}

- (void) requestLoginInfo {
    NSDictionary *param = @{
                            @"device_id":_device_id,
                            @"device_gubun":_device_gubun
                            };
    NSString *loginInfoURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/searchLoginInfo.ajax"];
    
    [FFNetworkManager url:loginInfoURL parameter:param success:^(NSDictionary *data) {
        NSLog(@"아이디 조회 결과값 = %@", data);
        NSString *lInfoResult = [data valueForKey:@"result"];
        NSString *lInfoStatus = [data valueForKey:@"status"];
        
        if ([lInfoResult isEqualToString:@"OK"] && [lInfoStatus isEqualToString:@"OK"]) {
            NSString *sComCd = [data objectForKey:@"comCd"];
            NSString *sID = [data objectForKey:@"userID"];
            if (![sComCd isEqual:[NSNull null]]) {
                if (![sComCd isEqualToString:@"NO_MB_ID"]) {
                    [_comLoginView setComCode:sComCd];
                    [_comLoginView setEmpCode:sID];
                    [[NSUserDefaults standardUserDefaults] setObject:sComCd forKey:@"comCode"];
                    [[NSUserDefaults standardUserDefaults] setObject:sID forKey:@"empCode"];
                } else {
                    [_personalLoginView setUserCode:sComCd];
                    [_personalLoginView setUserID:sID];
                    [[NSUserDefaults standardUserDefaults] setObject:sComCd forKey:@"userCode"];
                    [[NSUserDefaults standardUserDefaults] setObject:sID forKey:@"userID"];
                }
            }
        } else {
            
        }
    } failure:^(NSError *error) {
        NSLog(@"에러내용 : %@", error);
        [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 로그인(기업고객), 에러 DeviceID : %@", _device_id] :@"" :@"" :@"" :@"" :@"" :@""];
    }];
}

/**
 기업회원 라디오 버튼을 누를 때 동작하는 메서드
 comLoginView에 연결된 Handler를 통해 호출됨

 @param btn 기업회원 라디오 버튼
 */
- (void) selectBusiness:(UIButton *)btn
{
    NSLog(@"기업고객 선택");
    if (!btn.isSelected) {
        btn.selected = YES;
        _personalSel.selected = NO;
    }
    [self makeComView];
}

/**
 개인회원 라디오 버튼을 누를 때 동작하는 메서드
 personalLoginView에 연결된 Handler를 통해 호출됨
 
 @param btn 개인회원 라디오 버튼
 */
- (void) selectPersonal:(UIButton *)btn
{
    NSLog(@"개인고객 선택");
    if (!btn.isSelected) {
        btn.selected = YES;
        _companySel.selected = NO;
    }
    [self makeUserView];
}

/**
 TouchID를 이용한 로그인 체크

 @param btn TouchID 활성화 on/off버튼 (현재 숨김처리)
 */
- (void) switchAuth:(UIButton *)btn
{
    NSLog(@"지문 로그인 선택");
    if (!btn.isSelected) {
        btn.selected = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"FY" forKey:@"fingerYN"];
    } else {
        btn.selected = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"FN" forKey:@"fingerYN"];
    }
}

/**
 기업회원 라디오 버튼을 누를 때 화면에 그리기 위해 불리는 메서드
 
 그리기 전 개인회원 view가 그려져있을 수 있기에 removeFromSuperView를 통해 지우는 작업 선행
 
 화면에 이벤트를 발생하는 버튼들에 이벤트 연결(handler 등)
 */
- (void)makeComView
{
    [_personalLoginView removeFromSuperview];
    __weak typeof(self) weakSelf = self;
    _comLoginView.comLoginHandler = ^{
        [weakSelf doComLogin];
    };
    
    [_contentBody addSubview:_comLoginView];
    
    [_comLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_bottom).with.offset(20.f);
        make.left.equalTo(_contentBody.mas_left);
        make.right.equalTo(_contentBody.mas_right);
        make.bottom.equalTo(_contentBody.mas_bottom).with.offset(-20.f);
    }];
}

/**
 개인회원 라디오버튼을 누를 때 화면에 그리기 위해 불리는 메서드
 
 그리기 전 기업회원 view가 그려져있을 수 있기에 removeFromSuperView를 통해 지우는 작업 선행
 
 화면에 이벤트를 발생하는 버튼들에 이벤트 연결(handler 등)
 */
- (void)makeUserView
{
    [_comLoginView removeFromSuperview];
    __weak typeof(self) weakSelf = self;
    
    _personalLoginView.userLoginHandler = ^{
        [weakSelf doUserLogin];
    };
    
    _personalLoginView.findIdHandler = ^{
        [weakSelf doFindID];
    };
    
    _personalLoginView.findPwHandler = ^{
        [weakSelf doFindPW];
    };
    
    _personalLoginView.joinFfHandler = ^() {
        [weakSelf doJoinFF];
    };
    
    [_contentBody addSubview:_personalLoginView];
    
    [_personalLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_bottom).with.offset(20.f);
        make.left.equalTo(_contentBody.mas_left);
        make.right.equalTo(_contentBody.mas_right);
        make.bottom.equalTo(_contentBody.mas_bottom).with.offset(-20.f);
    }];
}

/**
 기업회원 화면에서 로그인 버튼을 누를 때 진입
 
 comLoginView에서 받아온 dictionary를 requestComLogin메서드로 전달
 */
- (void) doComLogin
{
    NSLog(@"로그인 버튼 눌렸다!!!");
    NSDictionary *getComLoginInfo = [_comLoginView LoginResult];
    
    [self requestComLogin:getComLoginInfo];
    NSLog(@"로그인 정보 = %@", getComLoginInfo);
}

/**
 개인회원 화면에서 로그인 버튼을 누를 때 진입
 
 personalLoginView에서 받아온 Dictionary를 requestUserLogin메서드에 전달
 
 개인회원의 아이디, 비밀번호는 임시저장 시킴(앱 종료 후 재시작 시 아이디 표현 및 자동 로그인 위해)
 */
- (void) doUserLogin
{
    NSLog(@"로그인 버튼 눌렸다!!!");
    NSDictionary *getUserLoginInfo = [_personalLoginView userLoginResult];
    NSLog(@"로그인 정보 = %@", getUserLoginInfo);
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"NO_MB_ID" forKey:@"comCode1"];
    
    [self requestUserLogin:getUserLoginInfo];
}

/**
 개인고객 화면에 있는 아이디 찾기 버튼에 연결되는 메서드
 
 현재 구현중인 기능이기에 서비스 준비 중 메시지 띄움
 */
- (void) doFindID {
//    [self showAlertWithMessageOK:@"서비스 준비중입니다."];
    // 추후 페이지 나올 시 연결
    
    [FFUtility changeRootViewController:_findUserVC];
}

/**
 개인고객 화면에 있는 비밀번호 찾기 버튼에 연결되는 메서드
 
 현재 구현중인 기능이기에 서비스 준비 중 메시지 띄움
 */
- (void) doFindPW {
//    [self showAlertWithMessageOK:@"서비스 준비중입니다."];
    // 추후 페이지 나올 시 연결
    
    [FFUtility changeRootViewController:_find1UserVC];
}

/**
 기업회원 선택 후 로그인 버튼을 눌렀을 때 도달하는 메서드

 @param getComLoginInfo comLoginView의 textField에서 받아온 회사코드, 사원코드, 비밀번호의 Dictionary
 
 회사코드, 사원코드, 비밀번호는 임시 저장시킴(앱 종료 후 재시작 시 입력한 값 저장목적 및 자동로그인 시 parameter값 이용 목적)
 
 로그인 후 종료 시 마지막 로그인 상태를 저장시키기 위해 현재 화면 임시 저장
 */
- (void) requestComLogin:(NSDictionary *)getComLoginInfo
{
    NSString *comCd = [getComLoginInfo valueForKey:@"comCode"];
    NSString *consultantId = [getComLoginInfo valueForKey:@"empCode"];
    NSString *comPasswd = [getComLoginInfo valueForKey:@"comPasswd"];
    [[NSUserDefaults standardUserDefaults] setObject:comCd forKey:@"secondaryComCD"];
    [[NSUserDefaults standardUserDefaults] setObject:consultantId forKey:@"secondaryConstID"];
    
    NSLog(@"로그인 정보 = %@, %@, %@", comCd, consultantId, comPasswd);
    NSDictionary *parameters = @{
                                        @"mb_id":comCd,
                                        @"consultant_id":consultantId,
                                        @"password":comPasswd
                                        };
    NSLog(@"파라미터 값 : %@", parameters);
    [[NSUserDefaults standardUserDefaults] setObject:parameters forKey:@"loginParam"];
    [FFNetworkManager url:[NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/loginCheck.ajax"]
        parameter:parameters
        success:^(NSDictionary *data) {
            NSLog(@"결과값 = %@", data);
            NSString *comLoginRst = [data valueForKey:@"result"];
            NSLog(@"result 값 = %@", comLoginRst);
            
            if ([comLoginRst isEqualToString:@"OK"] || [comLoginRst isEqualToString:@"API"]) {
                // 화면 이동 함수 작성
                [FFUtility goMain:parameters :_mainWebController];
//                [FFUtility goMain1:parameters :_wkWebViewController];
                [[NSUserDefaults standardUserDefaults] setObject:@"기업고객" forKey:@"loginScreen"];
//                [FFUtility changeRootViewController:_crawlingVC];
            } else {
                [self showAlertWithMessage:@"등록되지 않은 사용자이거나\n비밀번호가 맞지 않습니다."];
            }
        } failure:^(NSError *error) {
            NSLog(@"에러내용 : %@", error);
            [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 로그인(기업고객), 에러내용 : %@", error] :comCd :consultantId :@"" :@"" :@"" :@""];
            [self.view makeToast:@"로그인에 실패하였습니다\n다시 시도해주시기 바랍니다." duration:1.5 position:CSToastPositionBottom];
    }];
}

/**
 개인회원 선택 후 로그인 버튼을 눌렀을 때 도달하는 메서드
 
 @param param comLoginView의 textField에서 받아온 이메일, 비밀번호의 Dictionary
 
 이메일, 비밀번호는 임시 저장시킴(앱 종료 후 재시작 시 입력한 값 저장목적 및 자동로그인 시 parameter값 이용 목적)
 
 로그인 후 종료 시 마지막 로그인 상태를 저장시키기 위해 현재 화면 임시 저장
 */
- (void) requestUserLogin:(NSDictionary *)param
{
    NSLog(@"전달 받은 param = %@", param);
    NSString *userID = [param valueForKey:@"userId"];
    NSString *userPW = [param valueForKey:@"userPw"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO_MB_ID" forKey:@"secondaryUComCD"];
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"secondaryUserID"];
    NSDictionary *parameters = @{
                                 @"mb_id":@"NO_MB_ID",
                                 @"consultant_id":userID,
                                 @"password":userPW
                                 };
    [FFNetworkManager url:[NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/loginCheck.ajax"]
                parameter:parameters
                  success:^(NSDictionary *data) {
                      NSLog(@"결과값 = %@", data);
                      NSString *comLoginRst = [data valueForKey:@"result"];
                      NSLog(@"result 값 = %@", comLoginRst);
                      
                      if ([comLoginRst isEqualToString:@"OK"]) {
                          // 화면 이동 함수 작성
                          [[NSUserDefaults standardUserDefaults] setObject:@"개인고객" forKey:@"loginScreen"];
                          [FFUtility goMain:parameters :_mainWebController];
                          //                [FFUtility changeRootViewController:_crawlingVC];
                      } else {
                          [self showAlertWithMessage:@"등록되지 않은 사용자이거나\n비밀번호가 맞지 않습니다."];
                      }
                  } failure:^(NSError *error) {
                      NSLog(@"에러내용 : %@", error);
                      [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 로그인(개인고객), 에러내용 : %@", error] :@"NO_MB_ID" :userID :@"" :@"" :@"" :@""];
                      [self.view makeToast:@"로그인에 실패하였습니다\n다시 시도해주시기 바랍니다." duration:1.5 position:CSToastPositionBottom];
                  }];
}

/**
 개인고객 화면의 회원가입 버튼을 누를 때 도달하는 메서드
 
 회원가입 정보동의 페이지로 이동
 */
- (void) doJoinFF
{
    [FFUtility changeRootViewController:_agreementController];
}

/**
 TouchID 기능 활성화 메서드
 
 TouchID 존재여부 확인을 먼저 한 뒤
 
 있을 시 지문 요청 팝업이 뜨며, 지원하지 않는 경우 동작하지 않고 바로 로그인 화면으로 진입
 
 현재 기능 중단
 */
//- (void) setKeyChainForTouchIdVerify
//{
//    LAContext *context = [[LAContext alloc] init];
//    NSError *error = nil;
//
//    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"지문을 입력하여 로그인" reply:^(BOOL success, NSError *error) {
//            if (success) {
//                NSLog(@"성공!!!");
//                [self fingerLogin];
//            } else {
//                NSLog(@"실패 ㅜㅜ");
//            }
//        }];
//    } else {
//        NSLog(@"TouchID 지원 안함");
//    }
//}

/**
 TouchID를 이용한 로그인 이벤트 메서드
 
 처음 로그인 후 재 로그인 시 TouchID를 지원하는 아이폰에 한해 기능 지원
 
 저장된 화면에 따라 기업회원, 개인회원 로그인 로직 분기 동작 됨
 
 현재 기능 중지
 */
//- (void) fingerLogin
//{
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginScreen"] isEqualToString:@"기업고객"]) {
//        NSString *comCd = [[NSUserDefaults standardUserDefaults] objectForKey:@"comCode"];
//        NSString *consultantId = [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
//        NSString *comPasswd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//        NSLog(@"로그인 정보 = %@, %@, %@", comCd, consultantId, comPasswd);
//        NSDictionary *parameters = @{
//                                     @"mb_id":comCd,
//                                     @"consultant_id":consultantId,
//                                     @"password":comPasswd
//                                     };
//        NSLog(@"파라미터 값 : %@", parameters);
//        [[NSUserDefaults standardUserDefaults] setObject:parameters forKey:@"loginParam"];
//        [FFNetworkManager url:[NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/loginCheck.ajax"]
//                    parameter:parameters
//                      success:^(NSDictionary *data) {
//                          NSLog(@"결과값 = %@", data);
//                          NSString *comLoginRst = [data valueForKey:@"result"];
//                          NSLog(@"result 값 = %@", comLoginRst);
//
//                          if ([comLoginRst isEqualToString:@"OK"]) {
//                              // 화면 이동 함수 작성
//                              [FFUtility goMain:parameters :_mainWebController];
//                              [[NSUserDefaults standardUserDefaults] setObject:@"기업고객" forKey:@"loginScreen"];
//                              //                [FFUtility changeRootViewController:_crawlingVC];
//                          } else {
//                              [self showAlertWithMessage:@"등록되지 않은 사용자이거나\n비밀번호가 맞지 않습니다."];
//                          }
//                      } failure:^(NSError *error) {
//
//                      }];
//    } else {
//        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
//        NSString *userPW = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPW"];
//        NSDictionary *parameters = @{
//                                     @"mb_id":@"NO_MB_ID",
//                                     @"consultant_id":userID,
//                                     @"password":userPW
//                                     };
//        [FFNetworkManager url:[NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/loginCheck.ajax"]
//                    parameter:parameters
//                      success:^(NSDictionary *data) {
//                          NSLog(@"결과값 = %@", data);
//                          NSString *comLoginRst = [data valueForKey:@"result"];
//                          NSLog(@"result 값 = %@", comLoginRst);
//
//                          if ([comLoginRst isEqualToString:@"OK"]) {
//                              // 화면 이동 함수 작성
//                              [[NSUserDefaults standardUserDefaults] setObject:@"개인고객" forKey:@"loginScreen"];
//                              [FFUtility goMain:parameters :_mainWebController];
//                              //                [FFUtility changeRootViewController:_crawlingVC];
//                          } else {
//                              [self showAlertWithMessage:@"등록되지 않은 사용자이거나\n비밀번호가 맞지 않습니다."];
//                          }
//                      } failure:^(NSError *error) {
//
//                      }];
//    }
//}
@end
