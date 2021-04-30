#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Cordova/CDVPlugin.h>

@interface Screenshot : CDVPlugin {
}

//- (void)saveScreenshot:(NSArray*)arguments withDict:(NSDictionary*)options;
- (void)saveScreenshot:(CDVInvokedUrlCommand*)command;
- (void)getScreenshotAsURI:(CDVInvokedUrlCommand*)command;
@end
