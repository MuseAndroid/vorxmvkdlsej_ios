//
//  FFInfoFirstView.m
//  factFinder
//
//  Created by Hong Junho on . 1. 19.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFInfoFirstView.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFInfoFirstView()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webContView;

@end

@implementation FFInfoFirstView

- (instancetype) init
{
    self = [super init];
    if (self) {
        NSString *indexFile = [[NSBundle mainBundle] pathForResource:@"firstInfo" ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:indexFile encoding:NSUTF8StringEncoding error:nil];
        
        self.backgroundColor = [UIColor clearColor];
        
        _contentContainer = [[UIView alloc] init];
        _contentContainer.backgroundColor = [UIColor ff_c5Color];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor ff_c5Color];
        _scrollView.clipsToBounds = YES;
        
        _webContView = [[UIWebView alloc] init];
        _webContView.backgroundColor = [UIColor whiteColor];
        
        _okBtn = [[UIButton alloc] init];
        _okBtn.backgroundColor = [UIColor ff_c2Color];
        _okBtn.layer.cornerRadius = 5.f;
        _okBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
        [_okBtn setTitle:@"확인" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okClose:) forControlEvents:UIControlEventTouchUpInside];
        
        [_webContView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
        
        [_scrollView addSubview:_webContView];
        [_contentContainer addSubview:_okBtn];
        [_contentContainer addSubview:_scrollView];
        [self addSubview:_contentContainer];
        
        [self makeConstraints];
    }
    return self;
}

-(void)viewDidLayoutSubviews
{
    _scrollView.contentSize = _webContView.frame.size;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.equalTo(@.0f);
        make.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(-40.f);
    }];
    
    [_webContView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).with.offset(0.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@390.f);
    }];
    
    [_okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(-5.f);
    }];
    
}

/**
 확인 버튼 누를 때 팝업이 닫히도록 하는 메서드

 @param btn 팝업 하단 확인버튼 객체
 */
- (void) okClose:(UIButton *) btn
{
    if (_btnOKHandler) {
        NSLog(@"버튼 핸들러 도착!");
        _btnOKHandler();
    }
}

@end
