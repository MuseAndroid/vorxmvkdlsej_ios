#import <Foundation/Foundation.h>
@interface NSDictionary(InfoTech_JSONCategories)
/***..................
 NSDictionary* myInfo =
 [NSDictionary dictionaryWithContentsOfJSONURLString: @"http://www.yahoo.com/news.json"];
 ***/
+(NSDictionary*)jsonURL:(NSString*)urlAddress;
/***
 NSDictionary* information = [NSDictionary dictionaryWithObjectsAndKeys: @"orange",@"apple",@"banana",@"fig",nil];
 NSData* json = [information toJSON];
 ***/
-(NSData*)toJSON;
/***
 - Json -> String
 ***/
-(NSString*) jsonString;
@end

@interface NSArray (InfoTech_JSONCategories)
/***
 - JsonArray -> String
 ***/
- (NSString *)jsonStringArray;
@end