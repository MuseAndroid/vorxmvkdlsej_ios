#import <Foundation/Foundation.h>
#import "JSDataFunction.h"
#import <string>

using namespace std;

@protocol ProgressDelegate;    // protocol 선언

@interface iftCoreBridge : NSObject {
    id <ProgressDelegate> progressDelegate;   // 위에서 선언된 protocol로서 delegate를 선언하도록 한다.
}


@property (nonatomic, retain) NSString* outJson;
@property (nonatomic, assign) id <ProgressDelegate> progressDelegate;   // property로서 delegate 선언


- (NSString*) iftEncrypt : (NSString*) key : (NSString*) data ;
- (NSString*) iftDecrypt : (NSString*) key : (NSString*) data : (NSString*) op ;

- (NSString*) cryptoGate : (NSString*) op : (NSString*) cert : (NSString*) key : (NSString*) pw : (NSString*) param1 : (NSString*) param2 : (NSString*) encoding;
- (NSString*) httpRequest : (NSString*) url : (NSString*) meth : (NSString*) postData : (NSString*) setGubun : (NSString*) header;

- (void) onRequestComplete : (NSString*) jsonData;
- (void) onRequestProgress : (NSString*) jsonData;
- (void) LogToFile : (NSString*) data : (NSString*) filename;

- (NSString*) httpGetJs  : (NSString*) url : (NSString*) meth : (NSString*) fname;
- (NSString*) loadScript : (NSString*) fname;
- (NSString*) getSystemInfo : (NSString*) op;
- (NSString*) iftDecParam : (NSString*) data;
- (NSString*) checkHttps : (NSString*) httpsUrl;
@end

@protocol ProgressDelegate    // protocol을 정의하여 어떤 이벤트 함수를 Call 할 것인가를 선언한다.
- (void) onRequestProgress : (NSString*) proJson;
@end
