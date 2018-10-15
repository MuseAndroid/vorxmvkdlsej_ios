//
//  FFAgreementView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 14.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@interface FFAgreementView : FFView

/**
 회원가입 시 고객정보 제공 동의 팝업 이벤트 Handler 1
 */
@property (copy) void(^goAgreePopup1Handler)(void);

/**
 회원가입 시 고객정보 제공 동의 팝업 이벤트 Handler 2
 */
@property (copy) void(^goAgreePopup2Handler)(void);

/**
 회원가입 이동 버튼 이벤트 Handler
 */
@property (copy) void(^goJoinHandler)(void);

- (instancetype) init;

@end
