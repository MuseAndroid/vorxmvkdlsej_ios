//
//  FFAgreeContent4ViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFAgreeContent4ViewController.h"

//Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

// Library
#import <STPopup/STPopup.h>

@interface FFAgreeContent4ViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIWebView *webContView;

@end

@implementation FFAgreeContent4ViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"내보험다보여 이용약관";
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
    
    NSString *indexFile = [[NSBundle mainBundle] pathForResource:@"agree3" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:indexFile encoding:NSUTF8StringEncoding error:nil];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor whiteColor];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    _webContView = [[UIWebView alloc] init];
    _webContView.backgroundColor = [UIColor whiteColor];
    
    [self.webContView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
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

- (void) downContentBody:(NSString *)call_url
{
//    NSMutableDictionary *parameter = @{@"CODE":@"CREDIT3"}.mutableCopy;
//    [CBNetworkManager url:call_url parameter:parameter success:^(NSDictionary *data) {
//        NSLog(@"갔다온 값 : %@", [self stringByReplacingUnicodePoint:data]);
//        NSString *contentHTML = [data valueForKey:@"CONTENT"];
//        NSLog(@"HTML내용 = %@", contentHTML);
//        [[NSUserDefaults standardUserDefaults] setObject:contentHTML forKey:@"agreeCon3"];
//        [_webContView loadHTMLString:[[NSUserDefaults standardUserDefaults] objectForKey:@"agreeCon3"] baseURL:nil];
//    } failure:^(NSError *error) {
//
//    }];
}


/**
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }

 */

- (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
