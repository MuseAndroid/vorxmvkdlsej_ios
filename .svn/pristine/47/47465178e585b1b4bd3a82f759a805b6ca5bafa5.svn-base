#import <UIKit/UIKit.h>
#import "JSWebView.h"
#import "iftCoreDelegate.h"
#import "iftCoreBridge.h"


@interface iftCoreEn : NSObject<UIWebViewDelegate, ProgressDelegate>
{
    id <iftCoreDelegate> delegate;
}

@property (nonatomic,assign)  id <iftCoreDelegate> delegate;
@property (nonatomic, retain) IBOutlet JSWebView* myWebView;
@property (nonatomic, retain) NSString* inputJson;

- (void) onRequestProgress:(NSString *)proJson;
- (void) startEngine:(NSDictionary *) inputJson;
- (NSString *) getCertType:(NSString *) oid;
- (NSString *) getIssuerName:(NSString *) IssuerO;

- (NSString *) iftEncrypt   : (NSString*) key : (NSString*) data ;
- (NSString *) iftDecrypt   : (NSString*) key : (NSString*) data : (NSString*) op ;
- (NSString *) iftDecryptEx : (NSString*) key : (NSString*) data : (NSString*) op ;

- (NSString *) cryptoGate : (NSString*) op : (NSString*) cert : (NSString*) key : (NSString*) pw : (NSString*) param1 : (NSString*) param2 : (NSString*) encoding;

- (NSString*) iftEncParam : (NSString*) data;
- (NSString*) iftDecParam : (NSString*) data;
- (void) setLicense  : (NSString*) data;


@end
