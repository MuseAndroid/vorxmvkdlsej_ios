//
//  FFUtility.m
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFUtility.h"

// AppDelegate
#import "AppDelegate.h"

// ViewController
#import "FFViewController.h"
#import "FFLoginViewController.h"

UIAlertController *gToastVC;

FFLoginViewController *loginVC;
FFMainWebViewController *mainVC;
//FFWkViewController *mWkVC;

@implementation FFUtility

+(void) goHome:(FFLoginViewController *)lVc
{
    [self changeRootViewController:lVc];
}

+(void) goMain:(NSDictionary *)parameters :(FFMainWebViewController *)mVc
{
    mainVC = [mVc initWithParameter:parameters];
    [self changeRootViewController:mainVC];
}

//+(void) goMain1:(NSDictionary *)parameters :(FFWkViewController *)mWVc
//{
//    mWkVC = [mWVc initWithParameter:parameters];
//    [self changeRootViewController:mWkVC];
//}

+(void) goDetail:(NSString *)url :(FFMainWebViewController *)mDc
{
    mainVC = [mDc initWithURL:url];
}

+(void) changeRootViewController:(id)rootViewController
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = rootViewController;
}

+ (void) loadNextVCFromRight : (FFViewController*) newVC : (FFViewController*) myVC {
    CATransition *animation = [CATransition animation];
    //    animation.delegate = self;
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    [myVC.view.layer addAnimation:animation forKey:@"animation"];
    [myVC presentViewController:newVC animated:NO completion:nil];
}

+ (void) showToastCompleteHandler:(NSString *)msg :(FFViewController *)vc
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *toast = [[UIAlertController alloc] init];
        gToastVC = toast;
        toast.message = msg;
        toast.view.tintColor = [UIColor grayColor];
        
        [vc presentViewController:toast animated:true completion:nil];
        dispatch_time_t duration = dispatch_time(DISPATCH_TIME_NOW, (double)(2 * (double)(NSEC_PER_SEC)));
        
        dispatch_after(duration, dispatch_get_main_queue(), ^{
            [toast dismissViewControllerAnimated:YES completion:^{
                nil;
            }];
        });
    });
}

@end
