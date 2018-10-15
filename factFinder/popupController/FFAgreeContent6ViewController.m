//
//  FFAgreeContent6ViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFAgreeContent6ViewController.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <STPopup/STPopup.h>

@interface FFAgreeContent6ViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webContView;

@end

@implementation FFAgreeContent6ViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"서비스이용약관동의";
        self.contentSizeInPopup = CGSizeMake(300, 380);
        self.landscapeContentSizeInPopup = CGSizeMake(300, 380);
        [STPopupNavigationBar appearance].barTintColor = [UIColor ff_c1Color];
        [STPopupNavigationBar appearance].tintColor = [UIColor whiteColor];
        [STPopupNavigationBar appearance].titleTextAttributes= @{ NSFontAttributeName: [UIFont appleSDGothicNeoMediumWithSize:14.f],
                                                                  NSForegroundColorAttributeName: [UIColor ff_c5Color]};
        [STPopupNavigationBar appearance].barStyle = UIBarStyleDefault;
        
        [[UIBarButtonItem appearanceWhenContainedIn:[STPopupNavigationBar class], nil]
         setTitleTextAttributes:@{ NSFontAttributeName: [UIFont appleSDGothicNeoMediumWithSize:14.f],
                                   NSForegroundColorAttributeName: [UIColor ff_c5Color]} forState:UIControlStateNormal];
    }
    return self;
}

/**
 미리 구성되어있는 html파일을 웹뷰로 인덱싱하여 보여주는 과정 작성
 
 PathForResource에 www폴더에 있는 html파일의 이름을 작성하여 파일 세팅 후 webview로 보여주는 형식임
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *fullURL = [NSString stringWithFormat:@"%@%@", [NSString api_url], @"/policymng/getAccessTerm.ajax"];
//    NSLog(@"호출 URL = %@", fullURL);
//
//    [self downContentBody:fullURL];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _webContView = [[UIWebView alloc] init];
    _webContView.backgroundColor = [UIColor whiteColor];
    
    NSString *indexFile = [[NSBundle mainBundle] pathForResource:@"tel_serviceTxt" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:indexFile encoding:NSUTF8StringEncoding error:nil];
    
    [_webContView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    [_scrollView addSubview:_webContView];
    [_contentContainer addSubview:_scrollView];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

-(void)viewDidLayoutSubviews
{
    _scrollView.contentSize = _webContView.frame.size;
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0);
        make.left.equalTo(@.0f);
        make.right.equalTo(@.0f);
        make.bottom.equalTo(@.0f);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make){
        make.edges.equalTo(_contentContainer);
    }];
    
    [_webContView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@370.f);
    }];
    
}

- (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end

