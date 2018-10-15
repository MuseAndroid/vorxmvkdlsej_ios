//
//  FFCrawlingViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 4.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFCrawlingViewController.h"

// AppDelegate
#import "AppDelegate.h"

// View
#import "FFNavigationBar.h"
#import "FFTextField.h"
#import "FFCaptcahView.h"
#import "FFCertCodeView.h"

// ViewController
#import "FFMainWebViewController.h"
#import "FFLoginViewController.h"
#import "FFSelectTelComViewController.h"
#import "FFAgreeContent1ViewController.h"
#import "FFFirstInfoPopipViewController.h"
#import "FFUserAgreePopupViewController.h"
#import "FFPickerViewController.h"
#import "FFCaptcahViewController.h"
#import "FFCertViewController.h"

// Network
#import "FFNetworkManager.h"

// Utility
#import "FFUtility.h"
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Masonry/Masonry.h>
#import <STPopup/STPopup.h>
#import <Toast/UIView+Toast.h>

@interface FFCrawlingViewController () <UITextFieldDelegate>
{
    MBProgressHUD *HUD;
    
    NSString *tnk_sr;
    NSString *captcah;
}

// 이름, 주민번호, 전화번호 입력 부
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIView *contentBody;
@property (strong, nonatomic) UIView *contentView1; // 동의1
@property (strong, nonatomic) UIButton *allCheck; // 전체동의
@property (strong, nonatomic) UILabel *agreeTitle; // 한국신용정보원 동의사항 title
@property (strong, nonatomic) UIButton *checkBtn1; // 확인체크버튼
@property (strong, nonatomic) UIButton *agreeConBtn1; // 내용 보기 버튼
@property (strong, nonatomic) UIButton *agreePopupBtn;
@property (strong, nonatomic) UIView *contentView4;
@property (strong, nonatomic) UILabel *c4Title; // 팩트파인더 정보제공 동의 영역 타이틀
@property (strong, nonatomic) UILabel *infoTxtLabel; // 팩트파인더 정보제공 동의 영역 타이틀
@property (strong, nonatomic) UIButton *checkBtn9; // 팩트파인더 정보제공 동의 체크버튼
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *nameTitle;
@property (strong, nonatomic) FFTextField *inputName;
@property (strong, nonatomic) UIButton *selectPeopleCD;
@property (strong, nonatomic) UILabel *ssNumTitle;
@property (strong, nonatomic) FFTextField *ssNumField1;
@property (strong, nonatomic) FFTextField *ssNumField2;
@property (strong, nonatomic) UILabel *ssNumStatus;
@property (strong, nonatomic) UILabel *slashStr;
@property (strong, nonatomic) UILabel *telComTitle;
@property (strong, nonatomic) UIButton *selectCompany;
@property (strong, nonatomic) UILabel *telNumTitle;
@property (strong, nonatomic) FFTextField *telNumField;
@property (strong, nonatomic) UIButton *allSearchBtn;
@property (strong, nonatomic) FFNavigationBar *naviBar;
@property (strong, nonatomic) FFMainWebViewController *mainwVc;
@property (strong, nonatomic) FFLoginViewController *loginVC;
@property (strong, nonatomic) FFUserAgreePopupViewController *agreePopView;
@property (strong, nonatomic) FFCaptcahView *captchaView;
@property (strong, nonatomic) FFCertCodeView *certView;
@property (strong, nonatomic) FFCaptcahViewController *captcahVC;
@property (strong, nonatomic) FFCertViewController *certVC;
@property (strong, nonatomic) FFPickerViewController *pickerViewController;
@property (nonatomic) NSString *orgCD;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimer *timer1;
@property (nonatomic) NSTimer *timer2;
@property (nonatomic) NSTimer *timer3;
@property (nonatomic) NSTimer *timer4;
@property (nonatomic) NSTimer *TimeOfActiveUser;
@property (nonatomic) NSTimer *captcahTimer;
@property (nonatomic) NSTimer *searchCaptTimer;
@property (nonatomic) NSTimer *certTimer;
@property (nonatomic) NSString *error_comment;
@property (nonatomic) NSString *Sequence;
@property (nonatomic) NSString *Index;
@property (nonatomic) NSString *customer_seq;
@property (nonatomic) NSString *rangeCD;
@property (nonatomic) NSString *rangeNM;
@property (nonatomic) int requestFlag;
@property (nonatomic) BOOL agreeAll;
@property (nonatomic) int switchNum;
@property (nonatomic) BOOL certFlag;
@property (nonatomic) NSString *uName; // 고객이름
@property (nonatomic) NSString *uPhone; // 고객 핸드폰
@property (nonatomic) NSString *uPCom; // 고객 핸드폰 통신사
@property (nonatomic) FFViewController *parentVC;
@property (strong, nonatomic) NSArray *resultCodes;

@end

@implementation FFCrawlingViewController

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.title = @"Fact Finder";
        [[NSUserDefaults standardUserDefaults] setValue:@"선택" forKey:@"TELECOM_RESULT"];
        [_spinner stopAnimating];
        
        _resultCodes = @[@"0",
                         @"1"];
    }
    return self;
}

- (instancetype) initWithData:(NSString *)userName :(NSString *)userTelNum :(NSString *)userTelCom :(NSString *)customer_seq :(FFViewController *) parent
{
    self = [super init];
    if (self) {
        _Sequence = @"";
        self.title = @"Fact Finder";
        _uName = userName;
        _uPhone = userTelNum;
        _uPCom = userTelCom;
        _customer_seq = customer_seq;
        _parentVC = parent;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"nationCode"];
        [_spinner stopAnimating];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _switchNum = 0;
    
    [NSUserDefaults.standardUserDefaults setObject:@"N" forKey:@"errYn"];
    
    self.view.backgroundColor = [UIColor ff_c5Color];
    
    self.ff_hasNavigationBar = YES;
    _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleBack];
    _naviBar.title = self.title;
    __weak typeof(self) weakSelf = self;
    _naviBar.leftButtonHandler = ^() {
        [weakSelf backPage];
    };
    
    _certView = [[FFCertCodeView alloc] init];
    
    [self preferredStatusBarStyle];
    
    [NSUserDefaults.standardUserDefaults setBool:false forKey:@"certFlag"];
    
    UIImage *checkImg = [UIImage imageNamed:@"icon_check_01"];
    UIImage *unchkImg = [UIImage imageNamed:@"icon_check_02"];
    
    /* Component setting start */
    
    _orgCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"orgCD"];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _spinner.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
    _spinner.layer.cornerRadius = 10.f;
    
    _spinner2 = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _spinner2.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _spinner2.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
    _spinner2.layer.cornerRadius = 10.f;
    
    _requestFlag = 0;
    
    _captchaView = [[FFCaptcahView alloc] init];
    
    _scrollView = [[UIScrollView alloc] init];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    _contentContainer.clipsToBounds = YES;
    
    _contentBody = [[UIView alloc] init];
    _contentBody.backgroundColor = [UIColor clearColor];
    
    _contentView1 = [[UIView alloc] init];
    _contentView1.backgroundColor = [UIColor ff_c5Color];
    _contentView1.layer.cornerRadius = 10.f;
    
    _allCheck = [[UIButton alloc] init];
    _allCheck.clipsToBounds = YES;
    _allCheck.selected = NO;
    _allCheck.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _allCheck.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    [_allCheck setTitle:@"  전체 동의 합니다." forState:UIControlStateNormal];
    [_allCheck setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_allCheck setImage:unchkImg forState:UIControlStateNormal];
    [_allCheck setImage:checkImg forState:UIControlStateSelected];
    [_allCheck addTarget:self action:@selector(allCheckBox:) forControlEvents:UIControlEventTouchUpInside];
    
    _agreeTitle = [[UILabel alloc] init];
    _agreeTitle.backgroundColor = [UIColor clearColor];
    _agreeTitle.text = @"한국신용정보원 제공 정보 활용 시 참조사항";
    _agreeTitle.textColor = [UIColor blackColor];
    _agreeTitle.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    
    _agreeConBtn1 = [[UIButton alloc] init];
    _agreeConBtn1.backgroundColor = [UIColor ff_c9Color];
    _agreeConBtn1.layer.cornerRadius = 5.f;
    _agreeConBtn1.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    [_agreeConBtn1 setTitle:@"보기" forState:UIControlStateNormal];
    [_agreeConBtn1 setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    [_agreeConBtn1 addTarget:self action:@selector(viewAgreeCon1:) forControlEvents:UIControlEventTouchUpInside];
    
    _checkBtn1 = [[UIButton alloc] init];
    _checkBtn1.layer.cornerRadius = 5.f;
    _checkBtn1.clipsToBounds = YES;
    _checkBtn1.selected = NO;
    _checkBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _checkBtn1.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    [_checkBtn1 setTitle:@"  위 내용에 대하여 확인하였습니다." forState:UIControlStateNormal];
    [_checkBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkBtn1 setImage:unchkImg forState:UIControlStateNormal];
    [_checkBtn1 setImage:checkImg forState:UIControlStateSelected];
    [_checkBtn1 addTarget:self action:@selector(selectCheck1:) forControlEvents:UIControlEventTouchUpInside];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor ff_c5Color];
    _contentView.layer.cornerRadius = 10.f;
    
    _nameTitle = [[UILabel alloc] init];
    _nameTitle.text = @"이름";
    _nameTitle.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _nameTitle.textColor = [UIColor blackColor];
    _nameTitle.textAlignment = NSTextAlignmentCenter;
    
    _inputName = [[FFTextField alloc] init];
    _inputName.delegate = self;
    _inputName.layer.cornerRadius = 5.f;
    if ([_uName length] == 0) {
        
    }else {
        _inputName.text = _uName;
        [_inputName setEnabled:NO];
    }
    _inputName.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _inputName.textColor = [UIColor blackColor];
    _inputName.layer.masksToBounds = YES;
    _inputName.returnKeyType = UIReturnKeyNext;
    
    _selectPeopleCD = [[UIButton alloc] init];
    _selectPeopleCD.backgroundColor = [UIColor ff_c1Color];
    _selectPeopleCD.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    _selectPeopleCD.layer.cornerRadius = 5.f;
    [_selectPeopleCD setTitle:@"내국인" forState:UIControlStateNormal]; // 기본 값 설정
    [_selectPeopleCD setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    [_selectPeopleCD addTarget:self action:@selector(peoplePicker:) forControlEvents:UIControlEventTouchUpInside];
    
    _telComTitle = [[UILabel alloc] init];
    _telComTitle.text = @"통신사";
    _telComTitle.textAlignment = NSTextAlignmentCenter;
    _telComTitle.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _telComTitle.textColor = [UIColor blackColor];
    
    _selectCompany = [[UIButton alloc] init];
    _selectCompany.layer.cornerRadius = 5.f;
    _selectCompany.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    _selectCompany.backgroundColor = [UIColor ff_c9Color];
    if ([_uPCom length] == 0) {
        [_selectCompany setTitle:@"선택" forState:UIControlStateNormal]; // 통신사 기본값을 SKT로 설정 (이후 선택값에 따라 변경)
    } else {
        if ([_uPCom isEqualToString:@"SKT"]) {
            _uPCom = @"SKT";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([_uPCom isEqualToString:@"KTF"]) {
            _uPCom = @"KT";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([_uPCom isEqualToString:@"LGT"]) {
            _uPCom = @"LGU+";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([_uPCom isEqualToString:@"SKM"]) {
            _uPCom = @"SK알뜰폰";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([_uPCom isEqualToString:@"KTM"]) {
            _uPCom = @"KT알뜰폰";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([_uPCom isEqualToString:@"LGM"]) {
            _uPCom = @"LG알뜰폰";
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        }
    }
    [_selectCompany setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    if ([_orgCD isEqualToString:@"credit4u"]) {
        [_selectCompany addTarget:self action:@selector(risePopup:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _telNumTitle = [[UILabel alloc] init];
    _telNumTitle.text = @"전화번호";
    _telNumTitle.textAlignment = NSTextAlignmentCenter;
    _telNumTitle.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _telNumTitle.textColor = [UIColor blackColor];
    
    _telNumField = [[FFTextField alloc] init];
    _telNumField.delegate = self;
    _telNumField.layer.cornerRadius = 5.f;
    if ([_uPhone length] == 0) {
        
    } else {
        _telNumField.text = _uPhone;
        [_telNumField setEnabled:NO];
    }
    _telNumField.keyboardType = UIKeyboardTypeNumberPad;
    _telNumField.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _telNumField.textColor = [UIColor blackColor];
    _telNumField.returnKeyType = UIReturnKeyDone;
    
    _ssNumTitle = [[UILabel alloc] init];
    _ssNumTitle.text = @"고객동의";
    _ssNumTitle.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _ssNumTitle.textAlignment = NSTextAlignmentCenter;
    _ssNumTitle.textColor = [UIColor blackColor];
    
    _ssNumStatus = [[UILabel alloc] init];
    if ([_orgCD isEqualToString:@"cont.insure"]){
        _ssNumStatus.text = [NSString stringWithFormat:@"%@님이 동의하셨습니다.", _inputName.text];
    } else {
        _ssNumStatus.text = @"고객동의 대기중입니다";
    }
    _ssNumStatus.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    _ssNumStatus.textAlignment = NSTextAlignmentLeft;
    _ssNumStatus.textColor = [UIColor blackColor];
    
    _contentView4 = [[UIView alloc] init];
    _contentView4.backgroundColor = [UIColor ff_c6Color];
    _contentView4.layer.cornerRadius = 10.f;
    
    _c4Title = [[UILabel alloc] init];
    _c4Title.backgroundColor = [UIColor clearColor];
    _c4Title.text = @"개인정보 활용동의";
    _c4Title.textColor = [UIColor blackColor];
    _c4Title.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    
    _infoTxtLabel = [[UILabel alloc] init];
    _infoTxtLabel.backgroundColor = [UIColor clearColor];
    _infoTxtLabel.text = @"고객이 받은 인증번호를 알려주는 것은, 보장분석을 위해\n고객의 개인정보 활용을 동의하는 것으로 간주합니다.";
    _infoTxtLabel.textColor = [UIColor blackColor];
    _infoTxtLabel.numberOfLines = 2;
    _infoTxtLabel.font = [UIFont appleSDGothicNeoMediumWithSize:13.f];
    
    _checkBtn9 = [[UIButton alloc] init];
    _checkBtn9.clipsToBounds = YES;
    _checkBtn9.selected = NO;
    _checkBtn9.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:12.f];
    [_checkBtn9 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_checkBtn9 setImage:unchkImg forState:UIControlStateNormal];
    [_checkBtn9 setImage:checkImg forState:UIControlStateSelected];
    [_checkBtn9 setTitle:@"  개인정보이용동의" forState:UIControlStateNormal];
    [_checkBtn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_checkBtn9 addTarget:self action:@selector(selectCheck9:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_orgCD isEqualToString:@"cont.insure"]){
        [_allCheck setSelected:YES];
        [_checkBtn1 setSelected:YES];
        [_checkBtn9 setSelected:YES];
        [_inputName setEnabled:NO];
        [_telNumField setEnabled:NO];
    } else {
        [self timeInterval];
        _agreePopupBtn = [[UIButton alloc] init];
        _agreePopupBtn.clipsToBounds = YES;
        _agreePopupBtn.backgroundColor = [UIColor ff_c1Color];
        _agreePopupBtn.selected = NO;
        _agreePopupBtn.layer.cornerRadius = 5.f;
        _agreePopupBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        [_agreePopupBtn setTitle:@"고객정보활용동의" forState:UIControlStateNormal];
        [_agreePopupBtn setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
        [_agreePopupBtn addTarget:self action:@selector(custInfoAgree:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _allSearchBtn = [[UIButton alloc] init];
    _allSearchBtn.layer.cornerRadius = 5.f;
    _allSearchBtn.backgroundColor = [UIColor ff_c9Color];
    _allSearchBtn.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:14.f];
    if ([_orgCD isEqualToString:@"credit4u"]) {
        [_allSearchBtn setTitle:@"전체조회" forState:UIControlStateNormal];
    } else {
        [_allSearchBtn setTitle:@"보험금 찾기" forState:UIControlStateNormal];
    }
    [_allSearchBtn setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    [_allSearchBtn addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    /* Component Setting end */
    /* View add start */
    [_contentView1 addSubview:_allCheck];
    [_contentView1 addSubview:_agreeTitle];
    [_contentView1 addSubview:_checkBtn1];
    [_contentView1 addSubview:_agreeConBtn1];
    
    [_contentView addSubview:_nameTitle];
    [_contentView addSubview:_inputName];
    [_contentView addSubview:_selectPeopleCD];
    [_contentView addSubview:_telComTitle];
    [_contentView addSubview:_selectCompany];
    [_contentView addSubview:_telNumTitle];
    [_contentView addSubview:_telNumField];
    [_contentView addSubview:_ssNumTitle];
    [_contentView addSubview:_ssNumStatus];
    if ([_orgCD isEqualToString:@"cont.insure"]){
        
    } else {
        [_contentView addSubview:_agreePopupBtn];
    }
    
    [_contentView4 addSubview:_c4Title];
    [_contentView4 addSubview:_infoTxtLabel];
    [_contentView4 addSubview:_checkBtn9];
    [_contentView4 addSubview:_allSearchBtn];
    
    
    [_contentBody addSubview:_contentView];
    [_contentBody addSubview:_contentView1];
    [_contentBody addSubview:_contentView4];
    
    [_scrollView addSubview:_contentBody];
    
    [_contentContainer addSubview:_scrollView];
    
    [self.view addSubview:_contentContainer];
    [self.view addSubview:_naviBar];
    
    /* View add end */
    
    [self makeConstraints];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrollView.contentSize = _contentBody.frame.size;
    
}

- (void) viewDidAppear:(BOOL)animated
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"CaptcahImg"];
    _certFlag = [NSUserDefaults.standardUserDefaults boolForKey:@"certFlag"];
    if (data != nil) {
//        [self setRisePopTimer];
    }
    
    if (_certFlag) {
        NSLog(@"문자보안인증 팝업 뙇");
        [self setCertPopup];
    }
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    /* Component Drawing start */
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(@.0f);
    }];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviBar.mas_bottom);
        make.left.and.right.and.bottom.equalTo(@.0f);
    }];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentContainer);
    }];
    
    [_contentBody mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView).with.offset(12.5f);
        make.left.and.right.and.equalTo(_contentContainer);
        make.height.equalTo(@600.f);
    }];
    
    [_contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentBody.mas_top);
        make.left.equalTo(@12.5f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@120.f);
    }];
    
    [_allCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_top).with.offset(5.f);
        make.left.equalTo(_contentView1.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentView1.mas_right).with.offset(-12.5f);
        make.height.equalTo(@35.f);
    }];
    
    [ _agreeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allCheck.mas_bottom);
        make.left.equalTo(_contentView1.mas_left).with.offset(12.5f);
        make.width.equalTo(@210.f);
        make.height.equalTo(@40.f);
    }];
    
    [_agreeConBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreeTitle.mas_top);
        make.right.equalTo(_contentView1.mas_right).with.offset(-12.5f);
        make.width.equalTo(@80.f);
        make.height.equalTo(_agreeTitle.mas_height);
    }];
    
    [_checkBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_agreeTitle.mas_bottom);
        make.left.equalTo(_contentView1.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentView1.mas_right).with.offset(-12.5f);
        make.bottom.equalTo(_contentView1.mas_bottom).with.offset(-5.f);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView1.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@240.f);
    }];
    
    [_nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(12.5f);
        make.left.equalTo(_contentView.mas_left).with.offset(12.5f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_inputName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(12.5f);
        make.left.equalTo(_nameTitle.mas_right).with.offset(20.f);
        make.right.equalTo(_contentView.mas_right).with.offset(-102.5f);
        make.height.equalTo(@30.f);
    }];
    
    [_selectPeopleCD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).with.offset(12.5f);
        make.left.equalTo(_inputName.mas_right).with.offset(10.f);
        make.right.equalTo(_contentView.mas_right).with.offset(-12.5f);
        make.height.equalTo(@30.f);
    }];
    
    [_telNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTitle.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentView.mas_left).with.offset(12.5f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_telNumField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_inputName.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_telNumTitle.mas_right).with.offset(20.f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@30.f);
    }];
    
    [_telComTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telNumTitle.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentView.mas_left).with.offset(12.5f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_selectCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telNumField.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_telComTitle.mas_right).with.offset(20.f);
        make.width.equalTo(@100.f);
        make.height.equalTo(@30.f);
    }];
    
    [_ssNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telComTitle.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentView.mas_left).with.offset(12.5f);
        make.width.equalTo(@70.f);
        make.height.equalTo(@30.f);
    }];
    
    [_ssNumStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_selectCompany.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_ssNumTitle.mas_right).with.offset(20.f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@30.f);
    }];
    
    if ([_orgCD isEqualToString:@"cont.insure"]){
        
    } else {
        [_agreePopupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_ssNumTitle.mas_bottom).with.offset(12.5f);
            make.left.equalTo(_contentView.mas_left).with.offset(12.5f);
            make.right.equalTo((@-12.5f));
            make.height.equalTo(@30.f);
        }];
    }
    
    [_contentView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_bottom).with.offset(12.5f);
        make.left.equalTo(@12.5f);
        make.right.equalTo((@-12.5f));
        make.height.equalTo(@160.f);
    }];
    
    [_c4Title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView4.mas_top).with.offset(10.f);
        make.left.equalTo(_contentView4.mas_left).with.offset(10.f);
        make.width.equalTo(@250.f);
        make.height.equalTo(@15.f);
    }];
    
    [_infoTxtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_c4Title.mas_bottom).with.offset(5.f);
        make.left.equalTo(_contentView4.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentView4.mas_right).with.offset(-12.5f);
        make.height.equalTo(@35.f);
    }];
    
    [_checkBtn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoTxtLabel.mas_bottom).with.offset(10.f);
        make.left.equalTo(_contentView4.mas_left).with.offset(12.5f);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@30.f);
    }];
    
    [_allSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_checkBtn9.mas_bottom).with.offset(12.5f);
        make.left.equalTo(_contentView4.mas_left).with.offset(12.5f);
        make.right.equalTo((@-12.5f));
        make.bottom.equalTo((@-12.5f));
    }];
    /* Component Drawing end */
}

/**
 1. 통신사 선택 후 다시 crawling화면으로 진입 시 선택한 통신사 값으로 버튼 title 설정
 
 2. seq/idx 유무에 따라 주민번호 내려받는 메서드 실행
 
 3. 크롤링 데이터 서버에 전달 후 다시 메인화면으로 이동하기 위해 딜레이 타이머 실행
 
 @param animated 화면 변경 여부
 */
- (void) viewWillAppear:(BOOL)animated
{
    NSString *telCom = [[NSUserDefaults standardUserDefaults] valueForKey:@"TELCOM_RESULT"];
    if ([_uPCom length] != 0 || [telCom length] != 0) {
        if ([_uPCom length] != 0) {
            [_selectCompany setTitle:_uPCom forState:UIControlStateNormal];
        } else if ([telCom length] != 0) {
            if ([telCom isEqualToString:@"SKT"]) {
                telCom = @"SKT";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"KTF"]) {
                telCom = @"KT";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"LGT"]) {
                telCom = @"LGU+";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"SKM"]) {
                telCom = @"SK알뜰폰";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"KTM"]) {
                telCom = @"KT알뜰폰";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"LGM"]) {
                telCom = @"LG알뜰폰";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            } else if ([telCom isEqualToString:@"null"]) {
                telCom = @"선택";
                [_selectCompany setTitle:telCom forState:UIControlStateNormal];
            }
        }
    } else {
        [_selectCompany setTitle:@"선택" forState:UIControlStateNormal];
    }
    
    if ([_error_comment length] != 0 || [[[NSUserDefaults standardUserDefaults] objectForKey:@"goListURL"] length] != 0) {
        [self deleteHUD1];
    }
    
    _Sequence = [self getSequence];
    _Index = [self getIndex];
    
    NSLog(@"전달받은 seq = %@", _Sequence);
    NSLog(@"전달받은 idx = %@", _Index);
    
    if ([_Sequence length] != 0 && [_Index length] == 0 && _requestFlag == 0)
    {
        _requestFlag = _requestFlag+1;
        NSLog(@"SMS 시퀀스 = %@", _Sequence);
        NSLog(@"현재 플래그 값 = %d", _requestFlag);
        [self showAlertWithMessageOK:[NSString stringWithFormat:@"%@님이 동의절차를 진행하고 있습니다\n잠시만 기다려주세요", _inputName.text]];
        [_spinner startAnimating];
        [self makeSpinner];
        _TimeOfActiveUser = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(receiveJumin) userInfo:nil repeats:YES];
        _timer1 = [NSTimer scheduledTimerWithTimeInterval:180.0 target:self selector:@selector(getJuminDataTime) userInfo:nil repeats:NO];
    } else if ([_Sequence length] != 0 && [_Index length] != 0 && _requestFlag == 0) {
        _requestFlag = _requestFlag+1;
        NSLog(@"Sign 시퀀스 = %@", _Sequence);
        NSLog(@"Sign 인덱스 = %@",  _Index);
        NSLog(@"현재 플래그 값 = %d", _requestFlag);
        [_spinner startAnimating];
        [self makeSpinner];
        _TimeOfActiveUser = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(receiveJumin) userInfo:nil repeats:YES];
        _timer1 = [NSTimer scheduledTimerWithTimeInterval:180.0 target:self selector:@selector(getJuminDataTime) userInfo:nil repeats:NO];
    }
    
    NSString *returnURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"goListURL"];
    if ([returnURL length] != 0) {
        [self returnWebMainTimer];
    }
    
    if ([_spinner isAnimating] == NO) {
        [_spinner stopAnimating];
    }
    
}

/**
 고객정보 동의 요청 대기시간인 3분이 넘으면 진입함
 
 아래의 문구를 팝업으로 보여준 후 동의 대기중으로 동의여부 상태 문구 변경
 */
- (void) getJuminDataTime
{
    if ([_spinner isAnimating]) {
        [self showAlertWithMessageOK:@"요청시간이 만료되었습니다. 동의절차를 다시 진행해주세요"];
        _ssNumStatus.text = @"고객동의 대기중입니다";
        [self stopTimer];
        [_spinner stopAnimating];
    } else {
        
    }
}

/**
 크롤링 화면 처음 진입 시 나오는 고객정보조회 팝업이 자동으로 띄워지도록 타이머 설정 후 이벤트 연결
 */
- (void) timeInterval
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:.5f target:self selector:@selector(viewInfoFirst) userInfo:nil repeats:NO];
}

/**
 통신사 팝업 띄우는 메서드

 @param sender 이벤트가 일어난 객체
 */
- (void) risePopup:(id)sender
{
    NSLog(@"통신사 선택!!!");
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFSelectTelComViewController new]];
    [popupController presentInViewController:self];
    
}

/**
 전체 조회 버튼을 눌렀을 때 동작되는 메서드

 @param sender 전체조회 버튼 객체
 */
- (void) selectAll:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"errorFlag"];
    NSLog(@"조회버튼 클릭됐다!!!");
    if (_inputName.hasText == NO) {
        [self showAlertWithMessageOK:@"고객 이름을 입력해주세요"];
    }
    else if (_telNumField.hasText == NO) {
        [self showAlertWithMessageOK:@"고객 핸드폰번호를 입력해주세요"];
    } else if (_allCheck.selected == NO) {
        [self showAlertWithMessageOK:@"동의사항에 체크를 해주세요"];
    } else {
        
        // 이름 저장
        [[NSUserDefaults standardUserDefaults] setObject:_inputName.text forKey:@"userName"];
        
        // 핸드폰 번호 저장
        [[NSUserDefaults standardUserDefaults] setObject:_telNumField.text forKey:@"userHpNum"];
        
        // 핸드폰 통신사 저장
        if ([_orgCD isEqualToString:@"credit4u"]) {
            NSString *telComKind = [[NSUserDefaults standardUserDefaults] valueForKey:@"TELCOM_RESULT"];
            if ([_uPCom length] != 0) {
                [[NSUserDefaults standardUserDefaults] setObject:_uPCom forKey:@"telComName"];
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:telComKind forKey:@"telComName"];
            }
        }
        
        [self makeCapchaView];
    }
}

/**
 체크버튼의 동작을 구성하는 메서드
 
 누를 때 마다 활성화/비활성화 동작을 함
 
 전체 동의 시 한번 더 누를 때 전체 동의 버튼도 비활성화 되도록 selected 값 변경

 @param btn 신정원 정보활용 동의 확인 체크버튼
 */
- (void) selectCheck1:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected == _checkBtn9.selected)
    {
        _allCheck.selected = btn.selected;
    } else {
        _allCheck.selected = NO;
    }
}

/**
 체크버튼의 동작을 구성하는 메서드
 
 누를 때 마다 활성화/비활성화 동작을 함
 
 전체 동의 시 한번 더 누를 때 전체 동의 버튼도 비활성화 되도록 selected 값 변경

 @param btn 팩트파인더 개인정보 활용동의 체크버튼
 */
- (void) selectCheck9:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
    if (btn.selected == _checkBtn1.selected)
    {
        _allCheck.selected = btn.selected;
    } else {
        _allCheck.selected = NO;
    }
}

- (void) peoplePicker:(UIButton *)btn
{
    NSArray *titles = [FFCrawlingViewController rangeTitles];
    NSArray *codes = [FFCrawlingViewController rangeCodes];
    __weak typeof(self) weakSelf = self;
    if (!_pickerViewController) {
        _pickerViewController = [[FFPickerViewController alloc] initWithTitles:titles];
        _pickerViewController.cancelHandler = ^{
            [weakSelf.pickerViewController dismissViewControllerAnimated:NO completion:nil];
        };
        _pickerViewController.selectHandler = ^(NSInteger row) {
            [weakSelf.selectPeopleCD setTitle:titles[row] forState:UIControlStateNormal];
            _rangeNM = titles[row];
            _rangeCD = codes[row];
            NSLog(@"선택된 항목, 코드 값 = %@, %@", _rangeNM, _rangeCD);
            // 내외국인 코드 저장
            [[NSUserDefaults standardUserDefaults] setObject:_rangeCD forKey:@"nationCode"];
            [weakSelf.pickerViewController dismissViewControllerAnimated:NO completion:nil];
        };
    }
    [self presentViewController:_pickerViewController animated:NO completion:nil];
}

/**
 전체 동의 버튼
 
 누를 때 마다 모든 체크버튼이 활성화/비활성화 되도록 이벤트 설정

 @param allBtn 전체동의 체크버튼
 */
- (void) allCheckBox: (UIButton *)allBtn
{
    allBtn.selected = !allBtn.selected;
    _agreeAll = allBtn.isSelected;
    NSLog(@"버튼 눌렸니? - %id", _agreeAll);
    _checkBtn1.selected = _agreeAll;
    _checkBtn9.selected = _agreeAll;
}

/**
 앱 시작 시 나오는 고객정보 조회 안내 팝업을 구성하는 메서드
 */
- (void) viewInfoFirst
{
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFFirstInfoPopipViewController new]];
    [popupController presentInViewController:self];
}

/**
 신정원 정보활용동의 안내 팝업을 구성하는 메서드

 @param btn 신정원 정보활용동의 항목 보기 버튼
 */
- (void) viewAgreeCon1:(UIButton *)btn
{
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFAgreeContent1ViewController new]];
    [popupController presentInViewController:self];
}

/**
 고객정보 활용동의 버튼을 누를 때 팝업 구성 메서드
 
 고객 이름, 전화번호, 통신사 선택여부를 체크하여 팝업의 내용을 구성할 수 있도록 validation 처리

 @param btn 고객정보활용동의 버튼 객체
 */
- (void) custInfoAgree:(UIButton *)btn
{
    NSString *comID = @"";
    NSString *savedScreen = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginScreen"];
    if ([savedScreen isEqualToString:@"기업고객"]) {
        comID = [[NSUserDefaults standardUserDefaults] objectForKey:@"comCode"];
    } else {
        comID = @"NO_MB_ID";
    }
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
    if ([comID isEqualToString:@"NO_MB_ID"]) {
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    }
    
    _requestFlag = 0;
    if ([_inputName.text length] != 0) {
        if ([_telNumField.text length] != 0) {
            if ([self checkMobileNum:_telNumField.text]) {
                if (![_selectCompany.titleLabel.text isEqualToString:@"선택"]) {
                    NSString *consultant_nm = [[NSUserDefaults standardUserDefaults] objectForKey:@"consultantNM"];
                    NSDictionary *pData = @{
                                            @"CUSTOMER_NAME":_inputName.text,
                                            @"CUST_HP":_telNumField.text,
                                            @"CONSULTANT_NAME":consultant_nm
                                            };
                    [[NSUserDefaults standardUserDefaults] setObject:pData forKey:@"popupUserData"];
                    NSDictionary *pData1 = @{
                                             @"CUSTOMER_NAME":_inputName.text,
                                             @"CUST_HP":_telNumField.text,
                                             @"CONSULTANT_NAME":consultant_nm,
                                             @"MOBILE_CO":_selectCompany.titleLabel.text,
                                             @"MB_ID":comID,
                                             @"CONSULTANT_ID":userID,
                                             @"PAGE_GUBUN":@"1"
                                             };
                    NSLog(@"전달되는 파라미터들 - %@", pData1);
                    [[NSUserDefaults standardUserDefaults] setObject:pData1 forKey:@"popupUserData1"]; //sms
                    NSDictionary *pData2 = @{
                                             @"CUSTOMER_NAME":_inputName.text,
                                             @"CUST_HP":_telNumField.text,
                                             @"CONSULTANT_NAME":consultant_nm,
                                             @"MOBILE_CO":_selectCompany.titleLabel.text,
                                             @"MB_ID":comID,
                                             @"CONSULTANT_ID":userID,
                                             @"PAGE_GUBUN":@"2"
                                             };
                    NSLog(@"전달되는 파라미터들 - %@", pData2);
                    [[NSUserDefaults standardUserDefaults] setObject:pData2 forKey:@"popupUserData2"]; //sign
                    [self checkUserSearchHis:userID :comID];
                } else {
                    [self showAlertWithMessageOK:@"통신사를 선택해주세요"];
                }
            } else {
                [self showAlertWithMessageOK:@"고객 핸드폰번호를 정확히 입력해주세요"];
            }
        } else {
            [self showAlertWithMessageOK:@"고객 핸드폰번호를 입력해주세요"];
        }
    } else {
        [self showAlertWithMessageOK:@"고객 이름을 입력해주세요"];
    }
}

- (void) checkUserSearchHis:(NSString *)const_id :(NSString *)mb_id
{
    NSString *overlapDataURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/getOverlapAnalysis.ajax"];
    NSDictionary *params = @{
                             @"MOBILE_NO":_telNumField.text,
                             @"CUSTOMER_NAME":_inputName.text,
                             @"MB_ID":mb_id,
                             @"CONSULTANT_ID":const_id
                             };
    [FFNetworkManager url:overlapDataURL parameter:params success:^(NSDictionary *data) {
        NSLog(@"데이터 확인 = %@", data);
        BOOL search_overlap = [data objectForKey:@"OVERLAP"];
        NSString *overlayYN = [NSString stringWithFormat:@"%@", search_overlap ? @"true" : @"false"];
        NSString *msg_cust = [data objectForKey:@"MSG_CUST"];
        NSString *runTime = [data objectForKey:@"MSG_TIME"];
        NSDictionary *overlayParam = @{
                                       @"overlayYN":overlayYN,
                                       @"search_nm":msg_cust,
                                       @"search_time":runTime
                                       };
        [[NSUserDefaults standardUserDefaults] setObject:overlayParam forKey:@"overlayParam"];
        STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:[FFUserAgreePopupViewController new]];
        [popupController presentInViewController:self];
    } failure:^(NSError *error) {
        [self showAlertWithMessageOK:@"데이터 로드 중 문제가 발생했습니다.\n(분석 경과 시간 요청 에러)"];
        [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 분석 진행 경과시간 요청부, 에러내용 = %@", error] :mb_id :const_id :_inputName.text :_telNumField.text :@"" :@""];
    }];
}

/**
 부모클래스에 있는 btn1Click메서드를 호출하는 메서드
 
 엔진 구동에 필요한 데이터를 세팅 후 빈 데이터가 있는지 validation 체크
 
 모든 데이터가 존재 시 크롤링 작업 진행
 */
- (void) makeCapchaView
{
    NSLog(@"이름 = %@", _inputName.text);
    NSLog(@"핸드폰번호 = %@", _telNumField.text);
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *userSsn1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn1"];
    NSString *userSsn2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn2"];
    NSString *userHpNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHpNum"];
    NSString *telComName;
    if ([_orgCD isEqualToString:@"credit4u"]) {
        telComName = [[NSUserDefaults standardUserDefaults] valueForKey:@"telComName"];
    } else {
        telComName = [[NSUserDefaults standardUserDefaults] objectForKey:@"telComName"];
    }
    NSString *nationCD = @"";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"] length] != 0) {
        nationCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"];
    } else {
        nationCD = @"0";
    }
    
    NSLog(@"이름 : %@", userName);
    NSLog(@"주민번호 앞 : %@", userSsn1);
    NSLog(@"주민번호 뒤 : %@", userSsn2);
    NSLog(@"핸드폰번호 : %@", userHpNum);
    NSLog(@"통신사 : %@", telComName);
    NSLog(@"내.외국인 선택 = %@", _rangeNM);
    NSLog(@"내.외국인 코드 = %@", nationCD);
    
    if ([_inputName.text length] == 0){
        [self showAlertWithMessageOK:@"고객 이름을 입력해주세요"];
    } else if ([_telNumField.text length] == 0){
        [self showAlertWithMessageOK:@"고객 핸드폰번호를 입력해주세요"];
    } else if (![self checkMobileNum:_telNumField.text]) {
        [self showAlertWithMessageOK:@"고객 핸드폰번호를 정확히 입력해주세요"];
    } else if ([userSsn1 length] == 0) {
        [self showAlertWithMessageOK:@"고객정보활용동의를\n진행해주세요"];
    } else {
        if ([_ssNumStatus.text isEqualToString:@"고객동의 대기중입니다"]) {
            [self showAlertWithMessageOK:@"고객정보활용동의를\n진행해주세요"];
        } else {
//            [_spinner startAnimating];
//            [self makeSpinner];
            [self btn1Click:userName :userSsn1 :userSsn2 :userHpNum :telComName :nationCD :@"crawling"];
        }
    }
}

//- (void) requestReCaptchaImg
//{
//    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
//    NSString *userSsn1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn1"];
//    NSString *userSsn2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"userSsn2"];
//    NSString *userHpNum = [[NSUserDefaults standardUserDefaults] objectForKey:@"userHpNum"];
//    NSString *telComName1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"telComName"];
//    NSString *nationCD = @"";
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"] length] != 0) {
//        nationCD = [[NSUserDefaults standardUserDefaults] objectForKey:@"nationCode"];
//    } else {
//        nationCD = @"0";
//    }
//
//    [self btn1Click:userName :userSsn1 :userSsn2 :userHpNum :telComName1 :nationCD :@"refresh" :_captcahVC];
//}

//- (void) setDelayPopup
//{
//    _searchCaptTimer = [NSTimer scheduledTimerWithTimeInterval:.1f target:self selector:@selector(requestReCaptchaImg) userInfo:nil repeats:NO];
//}

- (void) riseCaptchaPop
{
    _captcahVC = [[FFCaptcahViewController alloc] init];
    [self presentViewController:_captcahVC animated:NO completion:nil];
}

/**
 네비게이션 바 좌상단에 있는 뒤로 버튼 누를 때 호출되는 메서드
 
 화면 이동 시 받은 이전 ViewController를 통해 뒤로가기 이벤트 구성
 */
- (void) backPage
{
    // 로그아웃 기능 시험
    [FFUtility changeRootViewController:_parentVC];
}

/**
 웹 페이지에서 고객에게 입력받은 주민번호를 가져오는 메서드
 
 문자/사인 동의 시 발급받은 시퀀스를 이용하여 해당 고객 주민번호를 받아옴
 */
- (void) receiveJumin
{
    // 서버에서 주민번호 받아오는 로직 구성
    NSLog(@"인터벌 시작!!!");
    NSString *catchDataURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/selectCustomerAgree.ajax"];
    NSString *smsSEQ = _Sequence;
    NSString *comID = @"";
    NSString *savedScreen = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginScreen"];
    if ([savedScreen isEqualToString:@"기업고객"]) {
        comID = [[NSUserDefaults standardUserDefaults] objectForKey:@"comCode"];
    } else {
        comID = @"NO_MB_ID";
    }
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"empCode"];
    if ([comID isEqualToString:@"NO_MB_ID"]) {
        userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    }
    NSString *telComName = [[NSUserDefaults standardUserDefaults] valueForKey:@"telComName"];
    NSDictionary *rParam = @{
                             @"SEQ":smsSEQ
                             };
    [FFNetworkManager url:catchDataURL parameter:rParam success:^(NSDictionary *data) {
        NSLog(@"데이터 왔다!!!");
        NSDictionary *getData = [data objectForKey:@"result"];
        NSString *userBirth = [getData valueForKey:@"PERNO1"];
        NSString *userIDN = [getData valueForKey:@"PERNO2"];
        NSLog(@"내려받은 주민번호 앞자리 : %@", userBirth);
        NSLog(@"내려받은 주민번호 뒷자리 : %@", userIDN);
        if ([userBirth length] != 0) {
            [[NSUserDefaults standardUserDefaults] setObject:userBirth forKey:@"userSsn1"];
            [[NSUserDefaults standardUserDefaults] setObject:userIDN forKey:@"userSsn2"];
            [self showAlertWithMessageOK:[NSString stringWithFormat:@"%@님이 동의하셨습니다", _inputName.text]];
            _ssNumStatus.text = [NSString stringWithFormat:@"%@님이 동의하셨습니다", _inputName.text];
            [self stopTimer];
        } else {
            
        }
        NSLog(@"뽑은 값 = %@, %@", userBirth, userIDN);
        if ([userBirth length] != 0) {
            [self stopTimer];
            _Sequence = @"";
            _Index = @"";
            [_spinner stopAnimating];
        } else {
            
        }
    } failure:^(NSError *error) {
//        [self showAlertWithMessageOK:@"데이터를 로드 중 문제가 발생했습니다.\n(주민번호 로드 에러)"];
        [self sendErrorMsg:[NSString stringWithFormat:@"에러위치 : 주민번호 호출부, 에러내용 = %@", error] :comID :userID :_inputName.text :_telNumField.text :@"" :telComName];
    }];
}

/**
 고객이 동의하여 주민번호가 서버에서 내려올 때 동작하는 메서드
 
 5초의 인터벌을 갖고있는 타이머를 종료하여 주민번호 검색 로직이 반복하지 못하도록 함
 */
- (void) stopTimer
{
    [_TimeOfActiveUser invalidate];
    _TimeOfActiveUser = nil;
}

- (void) setCertPopup
{
    _certTimer = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(riseCertPopup) userInfo:nil repeats:NO];
}

- (void) riseCertPopup
{
    NSString *errYn = [NSUserDefaults.standardUserDefaults objectForKey:@"errYn"];
    if ([errYn isEqualToString:@"Y"]) {
        
    } else {
        _certVC = [[FFCertViewController alloc] init];
        [self presentViewController:_certVC animated:YES completion:nil];
    }
//    [self returnWebMainTimer];
}

- (void) returnWebMainTimer
{
    _timer3 = [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(returnWebMain) userInfo:nil repeats:YES];
}

- (void) returnWebMain
{
    NSString *detailURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"goListURL"];
    NSLog(@"이동할 URL - %@", detailURL);
    
    if ([detailURL length] != 0) {
        [self stopTimer1];
        UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        topWindow.rootViewController = [UIViewController new];
        topWindow.windowLevel = UIWindowLevelAlert + 1;
        UIAlertController *warningAlert = [UIAlertController alertControllerWithTitle:@"" message:@"분석이 완료되었습니다.\n상세페이지로 이동합니다."
                                                                     preferredStyle:UIAlertControllerStyleAlert];

        [warningAlert addAction:[UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [_spinner stopAnimating];
//            NSDictionary *loginParameter = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginParam"];
//            _mainwVc = [[FFMainWebViewController alloc] initWithParameter:loginParameter];
            _mainwVc = [[FFMainWebViewController alloc] initWithURL:detailURL];
            [FFUtility changeRootViewController:_mainwVc];
          [warningAlert dismissViewControllerAnimated:NO completion:nil];
        }]];

        [topWindow makeKeyAndVisible];
        [topWindow.rootViewController presentViewController:warningAlert animated:NO completion:nil];
    }
}

- (void) stopTimer1
{
    [_spinner stopAnimating];
    [_timer3 invalidate];
    _timer3 = nil;
}

- (void) stopSpinner:(NSString *)err_str
{
    NSLog(@"로딩바 종료시작");
    _error_comment = err_str;
    [self stopTimer1];
    _timer4 = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(spinnerStop) userInfo:nil repeats:NO];
}

- (void) spinnerStop
{
    NSLog(@"로딩바 종료 끝!!!");
    [self stopTimer2];
    [_spinner stopAnimating];
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@""
                                                                          message:_error_comment
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *removeAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [errorAlert dismissViewControllerAnimated:NO completion:nil];
    }];
    [errorAlert addAction:removeAction];
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:errorAlert animated:NO completion:nil];
}

- (void) stopTimer2
{
    NSLog(@"에러 팝업 타이머 종료");
    [_spinner stopAnimating];
    
    [_timer4 invalidate];
    _timer4 = nil;
}

- (void) moveList
{
    [FFUtility loadNextVCFromRight:_mainwVc :self];
}

- (void) makeSpinner
{
    [self.view addSubview:_spinner];
    [_spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - Keyboard Effect
/**
 크롤링 시 키패드로 고객명 입력 후 키패드의 return(다음)버튼을 누르면 핸드폰 번호 입력 textField로 이동하게 하는 메서드

 @param textField 고객명, 전화번호 textfield
 @return 해당 항목 textField
 */
- (BOOL) textFieldShouldReturn:(FFTextField *)textField
{
    if ([textField isEqual:_inputName]) {
        [_telNumField becomeFirstResponder];
    } else {
        [_telNumField resignFirstResponder];
    }
    return YES;
}

-(BOOL)checkMobileNum:(NSString *)hp
{
    const char *tmp = [hp cStringUsingEncoding:NSUTF8StringEncoding];
    if (hp.length != strlen(tmp)) {
        return NO;
    }
    
    NSString *check = @"010([0-9]{7,8})";
    NSString *check1 = @"(011|016|017|018|019)([0-9]{7,8})";
    if ([hp length] == 11) {
        NSRange match = [hp rangeOfString:check options:NSRegularExpressionSearch];
        if (NSNotFound == match.location) {
            return NO;
        } else {
            return YES;
        }
    } else if ([hp length] == 11 || [hp length] == 10) {
        NSRange match1 = [hp rangeOfString:check1 options:NSRegularExpressionSearch];
        if (NSNotFound == match1.location) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

+ (NSArray *)rangeTitles
{
    return @[@"내국인",
             @"외국인"];
}

+ (NSArray *)rangeCodes
{
    return @[@"0",
             @"1"];
}

@end
