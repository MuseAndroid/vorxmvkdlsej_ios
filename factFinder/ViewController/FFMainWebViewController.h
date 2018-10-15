//
//  FFMainWebViewController.h
//  factFinder
//
//  Created by Hong Junho on . 1. 9.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFViewController.h"

@interface FFMainWebViewController:FFViewController<UIWebViewDelegate>

- (instancetype) init;
- (instancetype) initWithParameter:(NSDictionary *)parameters;
- (instancetype) initWithURL:(NSString *)url;

@end
