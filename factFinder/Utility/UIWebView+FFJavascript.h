//
//  UIWebView+FFJavascript.h
//  factFinder
//
//  Created by Hong Junho on . 2. 1.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface UIWebView (FFJavascript)

- (void)webView:(UIWebView *)sender runJavascriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id) frame;

@end
