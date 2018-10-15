//
//  FFJoinViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 11.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFJoinViewController.h"

// View
#import "FFNavigationBar.h"
#import "FFJoinView.h"

// ViewController
#import "FFNavigationViewController.h"
#import "FFAgreementViewController.h"
#import "FFLoginViewController.h"

// Manager
#import "FFNetworkManager.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"
#import "FFUtility.h"

// Library
#import <Toast/UIView+Toast.h>

@interface FFJoinViewController ()

@property (strong, nonatomic) FFNavigationBar *naviBar;
@property (strong, nonatomic) FFAgreementViewController *agreeVC;
@property (strong, nonatomic) FFJoinView *joinView;
@property (strong, nonatomic) FFLoginViewController *loginVC;

@end

@implementation FFJoinViewController

-(instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"회원가입";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ff_c5Color];
    
    __weak typeof(self) weakSelf = self;
    self.ff_hasNavigationBar = YES;
    self.ff_navigationBar.leftButtonHandler = ^() {
        _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleBack];
        [weakSelf backAgreePage];
    };
    self.ff_navigationBar.title = self.title;
    
    _joinView = [[FFJoinView alloc] init];
    _joinView.joinUserHandler = ^() {
        [weakSelf joinUser];
    };
    
    [self.view addSubview:_naviBar];
    [self.view addSubview:_joinView];
    
    [self makeConstraints];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_joinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@80.f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@500.f);
    }];
}

//NSDictionary *userDataSet = @{
//                              @"uEmail":_emailTF.text,
//                              @"uName":_nameTF.text,
//                              @"uPasswd":_passwdTF.text,
//                              @"uRePasswd":_rePasswdTF.text,
//                              @"uMobile":_mobileTF.text
//                              };

/**
 입력한 고객정보로 회원가입을 하는 메서드
 
 비밀번호 / 비밀번호 재확인 매칭 로직으로 일치여부 확인
 
 서버에 전송 후 각 메세지는 리턴되는 msg값을 이용하여 팝업으로 표현
 */
-(void) joinUser
{
    NSLog(@"도착!!!");
    NSDictionary *getParam = [_joinView getUserData];
    NSLog(@"전달받은 파라미터 = %@", getParam);
    NSString *passwd = [getParam valueForKey:@"uPasswd"];
    NSString *rePasswd = [getParam valueForKey:@"uRePasswd"];
    NSLog(@"비밀번호 값들 - 비밀번호 : %@, 재입력 비밀번호 : %@", passwd, rePasswd);
    if (![passwd isEqualToString:rePasswd]) {
        [self showAlertWithMessage:@"입력한 비밀번호가 일치하지 않습니다.\n다시 입력해주세요"];
    } else {
        NSLog(@"비밀번호 일치!");
        NSString *const_id = [getParam valueForKey:@"uEmail"];
        if (![self checkEmail:const_id]) {
            [self showAlertWithMessageOK:@"입력한 이메일이 형식에 맞지 않습니다\n 다시 입력해주세요"];
        } else {
            NSString *const_nm = [getParam valueForKey:@"uName"];
            NSString *passwd = [getParam valueForKey:@"uPasswd"];
            NSString *mobile = [getParam valueForKey:@"uMobile"];
            
            if (![self checkMobileNum:mobile]) {
                [self showAlertWithMessageOK:@"입력한 핸드폰번호가 올바르지 않습니다\n 다시 입력해주세요"];
            } else {
                NSString *joinURL = [NSString stringWithFormat:@"%@/joinSave.ajax", [NSString api_baseURL]];
                
                NSDictionary *param = @{
                                        @"CONSULTANT_ID":const_id,
                                        @"CONSULTANT_NAME":const_nm,
                                        @"PASSWORD":passwd,
                                        @"MOBILE_TEL":mobile
                                        };
                [FFNetworkManager url:joinURL parameter:param success:^(NSDictionary *data) {
                    NSLog(@"data정보 = %@", [self stringByReplacingUnicodePoint:data]);
                    NSString *resultTxt = [data objectForKey:@"successYN"];
                    if ([resultTxt isEqualToString:@"OK"]) {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"가입확인" message:@"가입확인 메일이 전송되었습니다\n로그인페이지로 이동합니다." preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            _loginVC = [[FFLoginViewController alloc] init];
                            [FFUtility goHome:_loginVC];
                            [alertController dismissViewControllerAnimated:YES completion:nil];
                        }];
                        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:commitAction];
                        [alertController addAction:closeAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    } else {
                        NSString *msg = [data objectForKey:@"msg"];
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"닫기" style:UIAlertActionStyleCancel handler:nil];
                        [alertController addAction:closeAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    
                } failure:^(NSError *error) {
                    [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 개인회원 회원가입, 에러내용 = %@", error] :@"NO_MB_ID" :const_id :const_nm :mobile :@"" :@""];
                    [self.view makeToast:@"회원정보 저장 중 문제가 발생했습니다\n다시 시도해 주시기 바랍니다" duration:1.5 position:CSToastPositionBottom];
                }];
            }
        }
    }
}

- (BOOL)checkEmail:(NSString *)email
{
    const char *tmp = [email cStringUsingEncoding:NSUTF8StringEncoding];
    if (email.length != strlen(tmp)) {
        return NO;
    }
    
    NSString *check = @"([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";
    NSRange match = [email rangeOfString:check options:NSRegularExpressionSearch];
    if (NSNotFound == match.location) {
        return NO;
    }
    return YES;
}

-(BOOL)checkMobileNum:(NSString *)hp
{
    const char *tmp = [hp cStringUsingEncoding:NSUTF8StringEncoding];
    if (hp.length != strlen(tmp)) {
        return NO;
    }
    
    NSString *check = @"010([0-9]{7,8})";
    NSString *check1 = @"(011|016|017|018|019)([0-9]{7,8})";
    if ([hp length] == 11) {
        NSRange match = [hp rangeOfString:check options:NSRegularExpressionSearch];
        if (NSNotFound == match.location) {
            return NO;
        } else {
            return YES;
        }
    } else if ([hp length] == 11 || [hp length] == 10) {
        NSRange match1 = [hp rangeOfString:check1 options:NSRegularExpressionSearch];
        if (NSNotFound == match1.location) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

/**
 로그인 정보창에서 뒤로 버튼 누를 때 고객동의 화면으로 이동하는 메서드
 
 화면 이동 시 받은 이전 화면을 이용하여 화면 이동
 */
- (void) backAgreePage
{
    _agreeVC = [[FFAgreementViewController alloc] init];
    [FFUtility changeRootViewController:_agreeVC];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
