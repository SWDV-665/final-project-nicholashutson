#import <Cordova/CDVPlugin.h>

@interface Screenshot : CDVPlugin {
}

- (void) saveScreenshot: (CDVInvokedUrlCommand*)command;
- (void) getScreenshotAsURI: (CDVInvokedUrlCommand*)command;
@end
