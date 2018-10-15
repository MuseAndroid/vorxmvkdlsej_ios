//
//  FFCertCodeView.h
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@interface FFCertCodeView : FFView <UITextFieldDelegate>

@property (copy) void (^searchHandler)(void);

@property (copy) void (^stopHandler)(void);

@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) NSTimer *stopwatch;

- (instancetype) init;

- (NSString *) smsResult;

@end
