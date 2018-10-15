#import <Foundation/Foundation.h>
#import "JSWebView.h"

@interface JSDataFunction : NSObject

@property (nonatomic, retain) NSString* funcID;
@property (nonatomic, retain) JSWebView* webView;
@property (nonatomic, assign) BOOL removeAfterExecute;

- (id) initWithWebView: (JSWebView*) _webView;

- (NSString*) execute;
- (NSString*) executeWithParam: (NSString*) param;
- (NSString*) executeWithParams: (NSArray*) params;

@end