//
//  FFFirstInfoPopipViewController.m
//  factFinder
//
//  Created by Hong Junho on . 1. 18.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFFirstInfoPopipViewController.h"

// View
#import "FFInfoFirstView.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

// Library
#import <STPopup/STPopup.h>

@interface FFFirstInfoPopipViewController ()

@property UIView *contentContainer;
@property FFInfoFirstView *firstView;

@end

@implementation FFFirstInfoPopipViewController

- (instancetype) init {
    self = [super init];
    if (self)
    {
        self.title = @"  안내사항";
        self.contentSizeInPopup = CGSizeMake(300, 430);
        self.landscapeContentSizeInPopup = CGSizeMake(300, 430);
        [STPopupNavigationBar appearance].barTintColor = [UIColor ff_c1Color];
        [STPopupNavigationBar appearance].tintColor = [UIColor clearColor];
        [STPopupNavigationBar appearance].titleTextAttributes= @{ NSFontAttributeName: [UIFont boldSystemFontOfSize:14.f],
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentContainer = [[UIView alloc] init];
    _firstView = [[FFInfoFirstView alloc] init];
    
    __weak typeof(self) weakSelf = self;
    _firstView.btnOKHandler = ^() {
        NSLog(@"닫히는 부분 도착!!!");
        [weakSelf closeView];
    };
    
    [_contentContainer addSubview:_firstView];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

- (void) makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentContainer.mas_top).with.offset(0.f);
        make.left.equalTo(_contentContainer.mas_left).with.offset(0.f);
        make.right.equalTo(_contentContainer.mas_right).with.offset(0.f);
        make.bottom.equalTo(_contentContainer.mas_bottom).with.offset(0.f);
    }];
}

- (NSString *)stringByReplacingUnicodePoint:(id)jsonObj
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonObj options:0 error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
}

/**
 팝업 닫기 버튼 누를 때 팝업 없애는 메서드
 */
- (void) closeView
{
    NSLog(@"도착했니???");
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
