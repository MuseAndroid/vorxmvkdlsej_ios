//
//  FFPersonalLoginView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 5.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

// View
#import "FFTextField.h"

@interface FFPersonalLoginView : FFView <UITextFieldDelegate>

/**
 개인회원 로그인 이벤트 Handler
 */
@property (copy) void (^userLoginHandler)(void);

/**
 아이디 찾기 버튼 이벤트 Handler
 */
@property (copy) void (^findIdHandler)(void);

/**
 비밀번호 찾기 버튼 이벤트 Handler
 */
@property (copy) void (^findPwHandler)(void);

/**
 회원가입 버튼 이벤트 Handler
 */
@property (copy) void (^joinFfHandler)(void);

@property (strong, nonatomic) FFTextField *userIdTxtField;
@property (strong, nonatomic) FFTextField *userPwTxtField;
@property (strong, nonatomic) UIButton *submitUserLogin;

- (instancetype) init;

/**
 입력된 개인고객 로그인 정보를 LoginViewController로 전달하는 메서드
 
 각 데이터는 Dictionary로 넣어 보냄

 @return 이메일, 비밀번호 들어있는 Dictionary
 */
-(NSDictionary *) userLoginResult;

- (void) setUserCode:(NSString *) userID;
- (void) setUserID:(NSString *) userID;

@end
