//
//  FFCrawlingViewController.h
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFViewController.h"

@interface FFCrawlingViewController : FFViewController <UITextFieldDelegate>

- (instancetype) init;

@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIActivityIndicatorView *spinner2;

/**
 메인 화면에서 접근(신규분석/재분석/내보험 찾아줌) 시 미리 데이터를 세팅하는 init부

 @param userName 계약자 이름
 @param userTelNum 계약자 핸드폰 번호
 @param userTelCom 계약자 핸드폰의 통신사
 @param customer_seq 고객 sequence
 @param parent 이전 ViewController
 @return 세팅된 설정 값이 화면에 표출됨
 */
- (instancetype) initWithData:(NSString *)userName :(NSString *)userTelNum :(NSString *)userTelCom :(NSString *)customer_seq :(FFViewController *) parent;

/**
 캡챠 이미지 재요청
 */
- (void) setDelayPopup;

- (void) riseCaptchaPop;

/**
 보안문자 팝업을 띄우는 메서드
 */
- (void) setCertPopup;

/**
 메인화면으로 돌아가기 위해 메서드 과정들이 엉키지 않기 위해 딜레이 타이머 설정
 */
- (void) returnWebMainTimer;

/**
 로딩 spinnder를 멈추는 메서드
 */
- (void) stopSpinner:(NSString *)err_str;

@end
