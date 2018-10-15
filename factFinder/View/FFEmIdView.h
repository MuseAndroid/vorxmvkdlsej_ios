//
//  FFEmIdView.h
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

// View
#import "FFTextField.h"

@interface FFEmIdView : FFView // 아이디 찾기 -> 이메일 인증

- (instancetype) init;

@property (copy) void (^reqNum2Handler)(void);

@property (copy) void (^reqEmIdHandler)(void);

@property (strong, nonatomic) FFTextField *tfInputName1;
@property (strong, nonatomic) FFTextField *tfInputEmail;
@property (strong, nonatomic) UIButton *btnReqNum1;
@property (strong, nonatomic) FFTextField *tfInputSecNum1;
@property (strong, nonatomic) UIButton *btnGoNext2;

@end
