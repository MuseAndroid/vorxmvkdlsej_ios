//
//  FFFindUserIDViewController.m
//  factFinder
//
//  Created by Hong Junho on . 4. 2.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFFindUserIDPWViewController.h"

// View
#import "FFResultIDView.h"
#import "FFNavigationBar.h"
#import "FFReBuildPasswordView.h"

// ViewController
#import "FFLoginViewController.h"

// Manager
#import "FFNetworkManager.h"

// Utility
#import "FFUtility.h"
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFFindUserIDPWViewController ()

@property (strong, nonatomic) UIView *contentContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) FFNavigationBar *naviBar;
@property (strong, nonatomic) FFLoginViewController *loginVC;
@property (strong, nonatomic) FFResultIDView *rIDView;
@property (strong, nonatomic) FFReBuildPasswordView *rbPasswordView;
@property (nonatomic) NSString *userIDStr;
@property (nonatomic) NSString *idpwYN;
@property (nonatomic) NSDictionary *findUserParams;

@end

@implementation FFFindUserIDPWViewController

- (instancetype) initWithIdData:(NSString *)idpw :(NSDictionary *)param
{
    self = [super init];
    if (self) {
        _idpwYN = idpw;
        _findUserParams = param;
        self.title = @"계정정보 확인/변경";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"넘어온 파라미터 값 = %@", [self stringByReplacingUnicodePoint:_findUserParams]);
    
    self.view.backgroundColor = [UIColor ff_c14Color];
    
    self.ff_hasNavigationBar = YES;
    _naviBar = [[FFNavigationBar alloc] initWithStyle:FFNavigationBarStyleBack];
    _naviBar.title = self.title;
    __weak typeof(self) weakSelf = self;
    _naviBar.leftButtonHandler = ^() {
        [weakSelf backPage];
    };
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor clearColor];
    
    _userIDStr = [_findUserParams objectForKey:@"CONSULTANT_ID"];
    NSLog(@"넘어온 설계사 ID = %@", _userIDStr);
    
    _rIDView = [[FFResultIDView alloc] init];
    [_rIDView.lbUserID setText:_userIDStr];
    
    _rbPasswordView = [[FFReBuildPasswordView alloc] init];
    [_rbPasswordView.userIDStr1 setText:_userIDStr];
    
    if ([_idpwYN isEqualToString:@"id"]) {
        [self showIdDisplay];
    } else {
        [self showPwDisplay];
    }
    
    [self.view addSubview:_contentContainer];
    [self.view addSubview:_naviBar];
    [self makeConstraints];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_naviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(@.0f);
    }];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_naviBar.mas_bottom);
        make.left.and.right.equalTo(@.0f);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _scrollView.contentSize = _rbPasswordView.frame.size;
}

- (void) viewWillAppear:(BOOL)animated
{
    
}

- (void) showIdDisplay
{
    [_rbPasswordView removeFromSuperview];
    __weak typeof(self) weakSelf = self;
    _rIDView.move_login1 = ^() {
        [weakSelf backPage];
    };
    
    _rIDView.move_FindPW = ^() {
        [weakSelf showPwDisplay];
    };
    
    [_contentContainer addSubview:_rIDView];
    
    [_rIDView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@180.f);
    }];
}

- (void) showPwDisplay
{
    [_rIDView removeFromSuperview];
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
    __weak typeof(self) weakSelf = self;
    _rbPasswordView.move_login2 = ^() {
        [weakSelf backPage];
    };
    
    _rbPasswordView.save_password = ^() {
        [weakSelf savePW];
    };
    
    [_scrollView addSubview:_rbPasswordView];
    [_contentContainer addSubview:_scrollView];
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentContainer);
    }];
    
    [_rbPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(12.5f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(12.5f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(-12.5f);
        make.height.equalTo(@300.f);
    }];
}

- (void) savePW
{
    // 서버에 데이터 보내는 로직 구현해야 함
    NSString *writePassword = _rbPasswordView.tfWritePw.text;
    NSString *reWritePassword = _rbPasswordView.tfWritePwRe.text;
    NSString *sPwURL = [NSString stringWithFormat:@"%@%@", [NSString api_baseURL], @"/pwModify.ajax"];
    
    if ([writePassword isEqualToString:reWritePassword]) {
        // 서버에 보내는 로직 작성
        NSString *mbID = @"NO_MB_ID";
        NSString *constID = _userIDStr;
        NSDictionary *savePasswordDic = @{
                                          @"MB_ID":mbID,
                                          @"CONSULTANT_ID":constID,
                                          @"PASSWORD":writePassword
                                          };
        [FFNetworkManager url:sPwURL parameter:savePasswordDic success:^(NSDictionary *data) {
            NSString *saveResult = [data objectForKey:@"result"];
            if ([saveResult isEqualToString:@"OK"]) {
                [self showCommitAlert];
            } else {
                [self showAlertWithMessageOK:@"비밀번호 변경 중 문제가 발생했습니다 다시 시도해주세요"];
            }
            
        } failure:^(NSError *error) {
            
        }];
    } else {
        [self showAlertWithMessageOK:@"비밀번호가 일치하지 않습니다"];
    }
}

- (void) backPage
{
    _loginVC = [[FFLoginViewController alloc] init];
    [FFUtility goHome:_loginVC];
}

- (void) showCommitAlert
{
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"비밀번호가 변경되었습니다 다시 로그인해주세요" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        topWindow.hidden = YES;
        [self backPage];
        
    }];
    [alertController addAction:commitAction];
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:alertController animated:NO completion:nil];
}

- (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

@end
