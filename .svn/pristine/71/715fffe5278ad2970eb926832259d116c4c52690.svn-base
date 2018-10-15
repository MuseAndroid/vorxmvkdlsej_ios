//
//  FFPickerViewController.h
//  factFinder
//
//  Created by Hong Junho on . 4. 11.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFViewController.h"

@interface FFPickerViewController : FFViewController <UIPickerViewDataSource, UIPickerViewDelegate>

/**
 *  `취소` 버튼 선택시 실행되는 block handler입니다.
 */
@property (copy) void (^cancelHandler)(void);

/**
 *  `선택` 버튼 선택시 실행되는 block handler입니다.
 */
@property (copy) void (^selectHandler)(NSInteger row);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTitles:(NSArray *)titles;

@end
