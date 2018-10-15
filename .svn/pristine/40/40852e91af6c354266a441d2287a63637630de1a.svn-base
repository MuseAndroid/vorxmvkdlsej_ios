//
//  FFNetworkManager.h
//  factFinder
//
//  Created by Hong Junho on . 1. 3.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PWNetworkSuccessHandler) (NSDictionary *data);
typedef void (^PWNetworkFailureHandler) (NSError *error);

@interface FFNetworkManager : NSObject

+ (void)url:(NSString *)api_url
  parameter:(NSDictionary *)param
    success:(PWNetworkSuccessHandler)success
    failure:(PWNetworkFailureHandler)failure;

+ (NSString *)stringByReplacingUnicodePoint:(id)jsonObj;

@end

@interface NSString (API)

+ (NSString *)api_baseURL;
//+ (NSString *)api_url;

@end
