//
//  FFComLoginView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 5.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

// View
#import "FFTextField.h"

@interface FFComLoginView : FFView <UITextFieldDelegate>

/**
 기업회원 로그인 버튼 이벤트 Handler
 */
@property (copy) void (^comLoginHandler)(void);

@property (strong, nonatomic) FFTextField *comCodeTxtField;
@property (strong, nonatomic) FFTextField *empCodeTxtField;
@property (strong, nonatomic) FFTextField *passwdTxtField;
@property (strong, nonatomic) UIButton *submitLogin;

- (instancetype) init;

/**
 각 TextField에 작성한 회사코드, 사원코드, 비밀번호를 포함하는 Dictionary를 반환하는 메서드

 @return com_code, consultant_id, password include Dictionary
 */
-(NSDictionary *) LoginResult;

-(void) setComCode:(NSString *)comCode;
-(void) setEmpCode:(NSString *)empCode;

@end
