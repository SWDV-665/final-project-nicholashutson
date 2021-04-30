#import <Cordova/CDV.h>
#import "Screenshot.h"

@implementation Screenshot

- (NSImage*) getScreenshot
{
	CGImageRef screenShot = CGWindowListCreateImage(CGRectInfinite, kCGWindowListOptionOnScreenOnly, 	kCGNullWindowID, kCGWindowImageDefault);

	NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
	NSImage *image = [[NSImage alloc] init];
	[image addRepresentation:bitmapRep];
	return image;
}

- (void) saveScreenshot:(CDVInvokedUrlCommand*)command
{
    NSString *filename = command.arguments[2];
    NSNumber *quality = command.arguments[1];
    
    NSString *path = [NSString stringWithFormat:@"%@.jpg",filename];
    NSString *jpgPath = [NSTemporaryDirectory() stringByAppendingPathComponent:path];
    
    NSImage *image = [self getScreenshot];
    NSData *imageData = [image TIFFRepresentation];
    
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = @{NSImageCompressionFactor: quality};
    
    imageData = [imgRep representationUsingType: NSJPEGFileType properties: imageProps];
    [imageData writeToFile: jpgPath atomically: NO];
    
    CDVPluginResult* pluginResult = nil;
    NSDictionary *jsonObj = @{@"filePath": jpgPath, @"success": @"true"};
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    NSString* callbackId = command.callbackId;
    [self.commandDelegate sendPluginResult:pluginResult callbackId:callbackId];
}

- (void) getScreenshotAsURI:(CDVInvokedUrlCommand*)command
{
    NSNumber *quality = command.arguments[0];
    NSImage *image = [self getScreenshot];
    
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = @{NSImageCompressionFactor: quality};
    imageData = [imgRep representationUsingType: NSJPEGFileType properties: imageProps];
    
    NSString *base64Encoded = [imageData base64EncodedStringWithOptions:0];
    NSDictionary *jsonObj = @{@"URI" : [NSString stringWithFormat:@"data:image/jpeg;base64,%@", base64Encoded]};
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonObj];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:[command callbackId]];
}
@end
