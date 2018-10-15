//
//  FFUserAgreeView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 19.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@interface FFUserAgreeView : FFView

/**
 고객정보활용동의 동의문자 요청 버튼 이벤트 Handler
 */
@property (copy) void(^sendSMSHandler)(void);

/**
 고객정보활용동이 사인동의 요청 버튼 이벤트 Handler
 */
@property (copy) void(^sendSignHandler)(void);

/**
 팝업 하단 취소 버튼 이벤트 Handler
 */
@property (copy) void(^cancelWindowHandler)(void);

- (instancetype) init;

@end
