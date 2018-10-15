//
//  FFTextField.m
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFTextField.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

@implementation FFTextField

-(instancetype) init
{
    self = [super init];
    
    if (self) {
        self.font = [UIFont appleSDGothicNeoMediumWithSize:13.0f];
        self.textColor = [UIColor ff_c7Color];
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor ff_c5Color];
        self.layer.cornerRadius = 5.f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor ff_c4Color].CGColor;
    }
    return self;
}

#pragma mark - Layout

/**
 텍스트필드 힌트 색상을 지정하는 메서드
 */
-(void) reloadPlaceholderColor
{
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholder) {
        UIColor *placeholderColor = self.enabled ? [UIColor ff_c6Color] : [UIColor ff_c8Color];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    }
}

/**
 사용유무에 따른 배경색 지정 메서드
 */
-(void) reloadBackgroundColor
{
    if (self.enabled) {
        self.backgroundColor = [UIColor ff_c5Color];
    } else {
        self.backgroundColor = [UIColor ff_c4Color];
    }
}

#pragma mark - Setter

/**
 텍스트필드 사용유무 선택

 @param enabled YES / NO
 */
-(void) setEnabled:(BOOL) enabled
{
    [super setEnabled:enabled];
    [self reloadPlaceholderColor];
}

/**
 입력 전 사용자에게 어떤 값을 입력해야하는지 알려주는 힌트 작성 메서드

 @param placeholder 힌트 문구
 */
-(void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    [self reloadPlaceholderColor];
}

/**
 코드로 값을 입력할 때 사용하는 메서드

 @param text 텍스트필드에 넣을 문구
 */
-(void) setText:(NSString *)text
{
    [super setText:text];
}

#pragma mark - Getter

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect result = bounds;
    result.origin.x = 10.f;
    result.size.width -= 20.f;
    return result;
}

// textPosition
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}
@end
