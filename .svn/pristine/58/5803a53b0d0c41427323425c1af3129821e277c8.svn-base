//
//  FFNavigationBar.h
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

/**
 네비게이션바 스타일 모은 enum

 - FFNavigationBarStyleNormal: 아무 버튼 없는 일반 네비게이션 바
 - FFNavigationBarStyleBack: 뒤로가기 버튼이 있는 네비게이션 바
 */
typedef NS_ENUM(NSInteger, FFNavigationBarStyle) {
    FFNavigationBarStyleNormal,
    FFNavigationBarStyleRight,
    FFNavigationBarStyleBack
};

@interface FFNavigationBar : FFView

/**
 뒤로가기 버튼이 눌릴 때 발생하는 이벤트 Handler
 */
@property (copy) void (^leftButtonHandler)(void);
@property (copy) void (^rightButtonHandler)(void);

@property (nonatomic) NSString *title;
@property (nonatomic) FFNavigationBarStyle style;

-(instancetype) init;

/**
 네비게이션 바 설정 시 스타일 지정하는 메서드

 @param style 일반, 뒤로버튼 유무
 @return 화면에 네비게이션 표현
 */
-(instancetype) initWithStyle:(FFNavigationBarStyle) style;

@end
