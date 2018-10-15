//
//  FFView.m
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFView.h"

@implementation FFView

-(void) makeConstraints
{
    
}

/**
 view에서 viewController에 표현하기 전에 미리 요소들을 배치하는 메서드

 @param views 해당 화면 구성하는 view
 */
-(void) addSubviews:(NSArray *)views
{
    for (UIView *view in views) {
        if (![view isKindOfClass:[UIView class]]) {
            continue;
        }
        [self addSubview:view];
    }
}

@end
