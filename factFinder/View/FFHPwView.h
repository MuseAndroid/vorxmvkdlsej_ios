//
//  FFHPwView.h
//  factFinder
//
//  Created by Hong Junho on . 3. 26.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

// View
#import "FFTextField.h"

@interface FFHPwView : FFView

- (instancetype) init;

@property (copy) void (^req_pwNumHandler)(void);

@property (copy) void (^reqHPwHandler)(void);

@property (strong, nonatomic) FFTextField *tfInputID;
@property (strong, nonatomic) FFTextField *tfInputHp_pw;
@property (strong, nonatomic) UIButton *btnReqNum_pw;
@property (strong, nonatomic) FFTextField *tfInputSecNum_pw;
@property (strong, nonatomic) UIButton *btn_pwGoNext;

@end
