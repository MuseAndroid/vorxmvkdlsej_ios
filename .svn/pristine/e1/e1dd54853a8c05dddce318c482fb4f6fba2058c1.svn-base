//
//  FFUtility.h
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import <Foundation/Foundation.h>

// ViewController
#import "FFLoginViewController.h"
#import "FFMainWebViewController.h"
//#import "FFWkViewController.h"

@interface FFUtility : NSObject

/**
 로그인 페이지 이동 함수

 @param lVc 로그인 페이지 클래스객체
 */
+ (void)goHome : (FFLoginViewController *)lVc;

/**
 로그인 후 메인화면으로 이동하는 함수

 @param parameters 로그인한 값을 서버로 보낼 파라미터 모음
 @param mVc 메인 웹뷰 페이지 클래스 객체
 */
+ (void)goMain : (NSDictionary *)parameters :(FFMainWebViewController *)mVc;

//+ (void)goMain1 : (NSDictionary *)parameters :(FFWkViewController *)mWVc;

/**
 크롤링 후 상세페이지로 이동시키는 함수

 @param url 상세페이지 URL
 @param mDc 메인 웹뷰 페이지 클래스 객체
 */
+ (void)goDetail : (NSString *)url :(FFMainWebViewController *)mDc;

/**
 기본적인 화면 전환을 도와주는 함수

 @param rootViewController 해당 ViewController 객체
 */
+ (void)changeRootViewController:(id)rootViewController;
+ (void) loadNextVCFromRight : (FFViewController*) newVC : (FFViewController*) myVC;

/**
 아이폰에서 지원하지 않는 Toast 기능을 구현해주는 메서드
 
 cocoaPod를 이용해 Toast를 다운받아 사용 가능

 @param msg Toast에 표현할 내용
 @param vc Toast를 띄울 ViewController객체
 */
+ (void)showToastCompleteHandler:(NSString *)msg :(FFViewController *)vc;

@end
