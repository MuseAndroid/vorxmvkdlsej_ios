//
//  FFSelectTelComViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFSelectTelComViewController.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

//Library
#import <STPopup/STPopup.h>
#import <Masonry/Masonry.h>

@interface FFSelectTelComViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIButton *skt_img;
@property (strong, nonatomic) UILabel *skt_title;
@property (strong, nonatomic) UIButton *kt_img;
@property (strong, nonatomic) UILabel *kt_title;
@property (strong, nonatomic) UIButton *lgt_img;
@property (strong, nonatomic) UILabel *lgt_title;
@property (strong, nonatomic) UIButton *skm_img;
@property (strong, nonatomic) UILabel *skm_title;
@property (strong, nonatomic) UIButton *ktm_img;
@property (strong, nonatomic) UILabel *ktm_title;
@property (strong, nonatomic) UIButton *lgm_img;
@property (strong, nonatomic) UILabel *lgm_title;

@end

@implementation FFSelectTelComViewController

/**
 화면이 시작되는 부분 모든 클래스를 사용할 때는 init을 선언해야 다른 클래스에서도 사용이 가능해짐
 
 popupController폴더에 있는 클래스들은 팝업 요소에 필요한 각 부분들을 초기화시키는 작업이 추가되어있음.

 @return 구성된 View
 */
- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"통신사를 선택해주세요";
        self.contentSizeInPopup = CGSizeMake(300, 300);
        self.landscapeContentSizeInPopup = CGSizeMake(300, 300);
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
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor ff_c5Color];
    
    _skt_img = [[UIButton alloc] init];  // SK텔레콤 버튼
    _skt_img.backgroundColor = [UIColor clearColor];
    [_skt_img setImage:[UIImage imageNamed:@"icon_sktbtn"] forState:UIControlStateNormal];
    [_skt_img addTarget:self action:@selector(setTelCom1:) forControlEvents:UIControlEventTouchUpInside];
    
    _skt_title = [[UILabel alloc] init]; // SK텔레콤 타이틀
    _skt_title.text = @"SKT";
    _skt_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _skt_title.textColor = [UIColor blackColor];
    _skt_title.textAlignment = NSTextAlignmentCenter;
    
    _kt_img = [[UIButton alloc] init]; // KT 버튼
    _kt_img.backgroundColor = [UIColor clearColor];
    [_kt_img setImage:[UIImage imageNamed:@"icon_ktbtn"] forState:UIControlStateNormal];
    [_kt_img addTarget:self action:@selector(setTelCom2:) forControlEvents:UIControlEventTouchUpInside];
    
    _kt_title = [[UILabel alloc] init]; // KT 타이틀
    _kt_title.text = @"KT";
    _kt_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _kt_title.textColor = [UIColor blackColor];
    _kt_title.textAlignment = NSTextAlignmentCenter;
    
    _lgt_img = [[UIButton alloc] init]; // LG U+ 버튼
    _lgt_img.backgroundColor = [UIColor clearColor];
    [_lgt_img setImage:[UIImage imageNamed:@"icon_lgtbtn"] forState:UIControlStateNormal];
    [_lgt_img addTarget:self action:@selector(setTelCom3:) forControlEvents:UIControlEventTouchUpInside];
    
    _lgt_title = [[UILabel alloc] init]; // LG U+ 타이틀
    _lgt_title.text = @"LGU+";
    _lgt_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _lgt_title.textColor = [UIColor blackColor];
    _lgt_title.textAlignment = NSTextAlignmentCenter;
    
    _skm_img = [[UIButton alloc] init]; // SK 알뜰폰 버튼
    _skm_img.backgroundColor = [UIColor clearColor];
    [_skm_img setImage:[UIImage imageNamed:@"icon_sktbtn"] forState:UIControlStateNormal];
    [_skm_img addTarget:self action:@selector(setTelCom4:) forControlEvents:UIControlEventTouchUpInside];
    
    _skm_title = [[UILabel alloc] init]; // SK 알뜰폰 타이틀
    _skm_title.text = @"SKT 알뜰폰";
    _skm_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _skm_title.textColor = [UIColor blackColor];
    _skm_title.textAlignment = NSTextAlignmentCenter;
    
    _ktm_img = [[UIButton alloc] init]; // KT 알뜰폰 버튼
    _ktm_img.backgroundColor = [UIColor clearColor];
    [_ktm_img setImage:[UIImage imageNamed:@"icon_ktbtn"] forState:UIControlStateNormal];
    [_ktm_img addTarget:self action:@selector(setTelCom5:) forControlEvents:UIControlEventTouchUpInside];
    
    _ktm_title = [[UILabel alloc] init]; // KT 알뜰폰 타이틀
    _ktm_title.text = @"KT 알뜰폰";
    _ktm_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _ktm_title.textColor = [UIColor blackColor];
    _ktm_title.textAlignment = NSTextAlignmentCenter;
    
    _lgm_img = [[UIButton alloc] init]; // LG U+ 알뜰폰 버튼
    _lgm_img.backgroundColor = [UIColor clearColor];
    [_lgm_img setImage:[UIImage imageNamed:@"icon_lgtbtn"] forState:UIControlStateNormal];
    [_lgm_img addTarget:self action:@selector(setTelCom6:) forControlEvents:UIControlEventTouchUpInside];
    
    _lgm_title = [[UILabel alloc] init]; // LG U+ 알뜰폰 타이틀
    _lgm_title.text = @"LGU+ 알뜰폰";
    _lgm_title.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _lgm_title.textColor = [UIColor blackColor];
    _lgm_title.textAlignment = NSTextAlignmentCenter;
    
    [_contentContainer addSubview:_skt_img];
    [_contentContainer addSubview:_skt_title];
    [_contentContainer addSubview:_kt_img];
    [_contentContainer addSubview:_kt_title];
    [_contentContainer addSubview:_lgt_img];
    [_contentContainer addSubview:_lgt_title];
    [_contentContainer addSubview:_skm_img];
    [_contentContainer addSubview:_skm_title];
    [_contentContainer addSubview:_ktm_img];
    [_contentContainer addSubview:_ktm_title];
    [_contentContainer addSubview:_lgm_img];
    [_contentContainer addSubview:_lgm_title];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@.0f);
        make.left.and.right.equalTo(@.0f);
        make.height.equalTo(@300.f);
    }];
    
    [_skt_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(@150.f);
        make.height.equalTo(@100.f);
    }];
    
    [_skt_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skt_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(_skt_img.mas_width);
        make.height.equalTo(@15.f);
    }];
    
    [_kt_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top);
        make.left.equalTo(_skt_img.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_img.mas_height);
    }];
    
    [_kt_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_kt_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_skt_title.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_title.mas_height);
    }];
    
    [_lgt_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skt_title.mas_bottom);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(_skt_img.mas_width);
        make.height.equalTo(_skt_img.mas_height);
    }];
    
    [_lgt_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lgt_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(_lgt_img.mas_width);
        make.height.equalTo(_skt_title.mas_height);
    }];
    
    [_skm_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_kt_title.mas_bottom);
        make.left.equalTo(_lgt_img.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_img.mas_height);
    }];
    
    [_skm_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skm_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_lgt_title.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_title.mas_height);
    }];
    
    [_ktm_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lgt_title.mas_bottom);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(_skt_img.mas_width);
        make.height.equalTo(_skt_img.mas_height);
    }];
    
    [_ktm_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ktm_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_contentContainer.mas_left);
        make.width.equalTo(_ktm_img.mas_width);
        make.height.equalTo(_skt_title.mas_height);
    }];
    
    [_lgm_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_skm_title.mas_bottom);
        make.left.equalTo(_ktm_img.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_img.mas_height);
    }];
    
    [_lgm_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lgm_img.mas_bottom).with.offset(-15.f);
        make.left.equalTo(_ktm_title.mas_right);
        make.right.equalTo(_contentContainer.mas_right);
        make.height.equalTo(_skt_title.mas_height);
    }];
}

/**
 SKT 버튼 누를 때 진입하는 메서드

 @param btn SKT버튼 객체
 */
- (void) setTelCom1: (id)btn
{
    NSLog(@"SKT버튼 눌렸다!");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"SKT" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

/**
 KT 버튼 누를 때 진입하는 메서드

 @param btn KT버튼 객체
 */
- (void) setTelCom2: (id)btn
{
    NSLog(@"KT버튼 눌렸다!");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"KTF" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

/**
 LGU+ 버튼 누를 때 진입하는 메서드

 @param btn LGU+ 버튼 객체
 */
- (void) setTelCom3: (id)btn
{
    NSLog(@"LGT버튼 눌렸다");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"LGT" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

/**
 SK알뜰폰 버튼 누를 때 진입하는 메서드

 @param btn SK알뜰폰 버튼 객체
 */
- (void) setTelCom4: (id)btn
{
    NSLog(@"SK 알뜰폰 눌렸다");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"SKM" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

/**
 KT알뜰폰 버튼 누를 때 진입하는 메서드

 @param btn KT알뜰폰 버튼 객체
 */
- (void) setTelCom5: (id)btn
{
    NSLog(@"KT 알뜰폰 눌렸다");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"KTM" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

/**
 LG알뜰폰 버튼 누를 때 진입하는 메서드

 @param btn LG알뜰폰 버튼 객체
 */
- (void) setTelCom6: (id)btn
{
    NSLog(@"LG U+ 알뜰폰 눌렸다.");
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:@"LGM" forKey:@"TELCOM_RESULT"];
    [self.popupController dismiss];
}

@end
