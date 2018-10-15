//
//  FFJoinView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 21.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@interface FFJoinView : FFView

/**
 회원가입 버튼 이벤트 Handler
 */
@property (copy) void(^joinUserHandler)(void);

@property (strong, nonatomic) UIButton *joinBtn;

- (instancetype) init;

/**
 회원가입 페이지에서 입력한 고객정보를 반환하는 메서드
 
 각 값은 Dictionary에 넣어 전달함

 @return 이메일, 이름, 전화번호, 비밀번호1, 비밀번호2 값을 넣은 Dictionary
 */
- (NSDictionary *)getUserData;

@end
