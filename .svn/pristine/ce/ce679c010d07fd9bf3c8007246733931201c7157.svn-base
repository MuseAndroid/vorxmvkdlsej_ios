//
//  AppDelegate.m
//  factFinder
//
//  Created by Hong Junho on . 10. 12.2017.
//  Copyright © 2017년 Hong Junho. All rights reserved.
//

#import "AppDelegate.h"

// ViewController
#import "ViewController/FFIntroViewController.h"

// Library
#import <IQKeyboardManager/IQKeyboardManager.h>

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
@import FirebaseMessaging;
#endif

// Implement UNUserNotificationCenterDelegate to receive display notification via APNS for devices
// running iOS 10 and above.
#if defined(__IPHONE_10_0) && __IHPONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end
#endif

// Copied from  Apple's header in case it is missing in some cases (e.g. pre-Xcode 8 builds).
#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

/**
 앱이 실행될 때 기본적으로 실행되는 동작이 작성되어있는 메서드
 
 이 곳에 앱이 실행되고 처음 나오는 화면을 설정할 수 있음
 
 firebase 및 다른 외부 프로그램(ex. branch)을 백그라운드로 실행시킬 경우에도 이 곳에 작성하면 됨

 @param application factfinder
 @param launchOptions launch
 @return app Start
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect screendBounds = [UIScreen mainScreen].bounds;
    
    _window = [[UIWindow alloc] initWithFrame:screendBounds];
    _window.rootViewController = [[FFIntroViewController alloc] init];
    [_window makeKeyAndVisible];
    
    IQKeyboardManager.sharedManager.enable = true;
    
    // [START configure_firebase]
    [FIRApp configure];
    // [END configure_firebase]
    
    // [START set_messaging_delegate]
    [FIRMessaging messaging].delegate = self;
    // [END set_messging_delegate]
    
    // Register for remote notifications. This shows a permission dialog on first run, to
    // show the dialog at a more appropriate time move this registration accordingly.
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        // iOS 7.1 or earlier. diable the deprecation warnings.
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType allNotificationTypes = (UIRemoteNotificationTypeSound |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeBadge);
        [application registerForRemoteNotificationTypes:allNotificationTypes];
        #pragma clang diagnostic pop
    } else {
        // iOS 8 or later
        // [START register_for_notifications]
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound |
                                                           UIUserNotificationTypeAlert |
                                                           UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [application registerUserNotificationSettings:settings];
        } else {
            // iOS 10 or later
            #if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            // For iOS 10 display notification (sent via APNS)
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
            }];
            #endif
        }
        
        [application registerForRemoteNotifications];
        // [END register_for_notifications]
    }
    
    return YES;
}

// [START receive_message]
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID : %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
    fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID : %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}
// [END receive_message]

// [START iOS_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification message while app is in the foreground.
/**
 Notification 동작에 필요한 정보들을 firebase 서버에서 받아오는 부분

 @param center center
 @param notification notification
 @param completionHandler nil
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
     whilePresentNotification:(UNNotification *)notification
        withCompletionHandler:(void(^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[FIRMEssaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message
    NSLog(@"%@", userInfo);
    
    // change this to your preferred presentation option
    completionHandler(UNNotificationActionOptionNone);
}

// Handle notification message after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
#if defined(__IPHONE_11_0)
         withCompletionHandler:(void(^)(void))completionHandler {
#else
         withCompletionHandler:(void(^)())completionHandler {
#endif
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
     NSLog(@"Message ID : %@", userInfo[kGCMMessageIDKey]);
    }

    // Print full Message
    NSLog(@"%@", userInfo);

    completionHandler();
}
#endif
// [END ios_10_message_handling]

// [START refresh_token]
/**
 firebase가 실행될 때 처음으로 도달하는 메서드
 
 각 기기의 고유 값인 deviceToken이 이 메서드에서 생성됨

 @param messaging msg
 @param fcmToken deviceToken value
 */
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    NSLog(@"FCM registration token : %@", fcmToken);
    [[NSUserDefaults standardUserDefaults] setObject:fcmToken forKey:@"deviceToken"];
    
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
/**
 서버에서 원격으로 알림을 보낼 때 이 메서드를 통해 전달받음

 @param messaging sending msg
 @param remoteMessage remoteMsg
 */
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    NSLog(@"Received data message: %@", remoteMessage.appData);
}
// [END ios_10_data_message
    
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(nonnull NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}
    
// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is diabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    NSLog(@"APNs device Token retrieved: %@", deviceToken);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

    
/**
 웹에서 앱을 호출할 때 설치되어있을 경우 앱을 실행시키는 메서드
 추가적으로 파라미터를 포함하여 호출할 경우
 파라미터 값에 따라 실행시킬 화면을 선택하여 구현할 수 있음

 @param application factfinder
 @param url customURL
 @param sourceApplication null
 @param annotation null
 @return app Launch
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"여기로 들어오니???");
    if (!url) {
        return NO;
    } else {
        NSLog(@"url정보 = %@", url);
        return YES;
    }
}

@end
