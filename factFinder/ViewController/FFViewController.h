//
//  FFViewController.h
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import <UIKit/UIKit.h>

// View
#import "FFNavigationBar.h"

@interface FFViewController : UIViewController

@property (nonatomic) NSString *saveSEQ;
@property (nonatomic) NSString *saveIDX;
@property (nonatomic) BOOL ff_hasNavigationBar;
@property (strong, nonatomic) FFNavigationBar *ff_navigationBar;

/**
 Auto layout constraints 생성 method입니다.
 */
- (void) makeConstraints;

/**
 크롤링 엔진을 사용할 때 필요한 method.
 각 인자는 이름, 주민번호 앞자리, 주민번호 뒷자리임
 */
- (void) btn1Click:(NSString *)name :(NSString *)ssnFront :(NSString *)ssnBack :(NSString *)mobileNum :(NSString *)telComName :(NSString *)nationCD :(NSString *)viewGubun;
- (void) btn2Click:(NSString *)name :(NSString *)ssnFront :(NSString *)ssnBack :(NSString *)mobileNum :(NSString *)telComName :(NSString *)captcahNum :(NSString *)nationCD;
- (void) btn3Click:(NSString *)name :(NSString *)ssnFront :(NSString *)ssnBack :(NSString *)mobileNum :(NSString *)telComName :(NSString *)smsResult :(NSString *)nationCD;

/**
 기본 alert view controller를 띄움, 확인/취소 버튼 존재

 @param message 메시지에 표현할 내용
 */
- (void)showAlertWithMessage:(NSString *)message;

/**
 확인 버튼만 있는 alertViewController를 띄움

 @param message 메시지에 표현할 내용
 */
- (void)showAlertWithMessageOK:(NSString *)message;
- (UIStatusBarStyle)preferredStatusBarStyle;

/**
 자동 업데이트 기능 메서드
 */
- (void)requestCheckAppVersion;


/**
 시스템 에러 발생 시 서버에 에러 코드 보내는 ajax call method
 */
- (void)sendErrorMsg:(NSString *)errString :(NSString *)mb_id :(NSString *)const_id :(NSString *)cust_nm :(NSString *)mobileNo :(NSString *)err_gubun :(NSString *)mobileCo;

/**
 wifi에 연결되어있는지 확인하는 method
 */
- (void)isNetworkReachable;

/**
 고객 개인정보 활용동의 진행 시 발급되는 seq 임시 저장 method

 @param seq 문자/사인 동의 시 발급되는 sequence
 */
- (void) saveSequence:(NSString *) seq;

/**
 고객 개인정보 활용동의 진행 시 발급되는 idx 임시 저장메서드

 @param idx 사인 동의 시 발급되는 index
 */
- (void) saveIndex: (NSString *)idx;

/**
 서버에서 고객 주민번호를 받아오기 위해 필요한 seq get메서드

 @return 서버에서 발급한 sequence
 */
- (NSString *) getSequence;

/**
 서버에서 고객 주민번호를 받아오기 위해 필요한 idx get메서드

 @return 서버에서 발급한 index(서명동의 때만 발급됨)
 */
- (NSString *) getIndex;
- (void) showHUD1;
- (void) deleteHUD1;
- (void) setCaptchaViewCon:(FFViewController *) vc;

@end
