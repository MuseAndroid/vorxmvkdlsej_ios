//
//  FFAgreeContent1ViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFAgreeContent1ViewController.h"

// Utility
#import "UIFont+FFExtention.h"
#import "UIColor+FFExtention.h"

//Library
#import <STPopup/STPopup.h>
#import <Masonry/Masonry.h>

@interface FFAgreeContent1ViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentBody;
@property (strong, nonatomic) UILabel *contentText;

@end

@implementation FFAgreeContent1ViewController

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.title = @"  한국신용정보원 제공 정보 활용 시 참조사항";
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    NSString *contents = @"조회자 본인이 계약자 또는 피보험자 자격으로\r\n관련된 보험계약의 보장내역 및 관련 통계자료를\r\n제공합니다. 조회일 현재 기준, 한국신용정보원이\r\n신용정보 제공 ・ 이용자로부터 정상적으로 제공받는\r\n정보에 대해서만 조회됩니다. 계약 및 보장내역과\r\n관련된 세부정보 및 문의사항은 해당 보험회사에\r\n문의하시기 바랍니다. 내보험다보여 서비스는\r\n정액형보장 계약내용과 실손형 보장 계약내용으로\r\n구분하여 정보를 제공합니다.\r\n정액형 보장 계약내용은 2006년 이후\r\n'제 3자정보제공\'에 동의한 보험신용정보에 한하여\r\n제공됩니다.\r\n(공제 및 체신관서의 경우는 2009년 10월 이후이며,\r\n각 회사별로 시점의 차이가 있을 수 있습니다.)\r\n또한, 자동차보험, 화재 ・ 배상책임(대물)\r\n보험을 제외한 보장성 ・ 저축성 ・ 실손보험에\r\n대하여 제공됩니다.\r\n실손형보장 계약내용에서는 계약상태가 정상 및\r\n실효이며 조회일이 보장기간 내에 해당되는 계약만\r\n보여집니다.";
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    
    _scrollView = [[UIScrollView alloc] init];
    
    _contentBody = [[UIView alloc] init];
    _contentBody.backgroundColor = [UIColor whiteColor];
    _contentBody.layer.cornerRadius = 10.f;
    
    _contentText = [[UILabel alloc] init];
    _contentText.text = contents;
    _contentText.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _contentText.textColor = [UIColor blackColor];
    _contentText.numberOfLines = 25;
    
    [_contentBody addSubview:_contentText];
    [_scrollView addSubview:_contentBody];
    [_contentContainer addSubview:_scrollView];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
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
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentContainer);
    }];
    
    [_contentBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top).with.offset(5.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(5.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-5.f);
        make.height.equalTo(@370.f);
    }];
    
    [_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentBody.mas_top);
        make.left.equalTo(_contentBody.mas_left).with.offset(5.f);
        make.right.equalTo(_contentBody.mas_right).with.offset(-5.f);
        make.height.equalTo(_contentBody.mas_height);
    }];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrollView.contentSize = _contentBody.frame.size;
}

@end
