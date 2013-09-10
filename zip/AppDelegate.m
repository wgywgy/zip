//
//  AppDelegate.m
//  zip
//
//  Created by D on 13-4-16.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "TexureManager.h"

#import "ZipArchive.h"

#import "UIImage+zipArchiveAndTexure.h"

#import "JRSwizzle.h"

static NSOperationQueue *queue;

@implementation AppDelegate

- (void)dealloc {
	[_window release];
	[_viewController release];
	[super dealloc];
}

- (void)zipFile {
	static dispatch_once_t once;
    
	dispatch_once(&once, ^{
	    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"demo"
	                                                        ofType:@"zip"];
        
	    ZipArchive *za = [[ZipArchive alloc] init];
        
	    if ([za UnzipOpenFile:resPath]) { //解压
	        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	        NSString *documentsDirectory = paths[0]; //前两句为获取Documents在真机中的地址
            
	        BOOL ret = [za UnzipFileTo:documentsDirectory overWrite:YES];
	        if (YES == ret) {
//	            NSDate *tmpStartData = [NSDate date];
	            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
	                           ^{
                                   NSFileManager *fileManager = [NSFileManager defaultManager];
                                   [fileManager removeItemAtPath:resPath error:nil];
                               });
//	            double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
//	            NSLog(@"cost time = %f", deltaTime);
			}
	        [za UnzipCloseFile];
		}
        
	    [za release];
	    [[TexureManager shareInstance] addTextureFile:@"demo_texture"];
	    [self.viewController performSelectorOnMainThread:@selector(zip_Completed)
	                                          withObject:nil
	                                       waitUntilDone:NO];
	});
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];

	return YES;
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	queue = [[NSOperationQueue alloc] init];
	NSInvocationOperation *op = [[[NSInvocationOperation alloc] initWithTarget:self
	                                                                  selector:@selector(zipFile)
	                                                                    object:nil] autorelease];
	[queue addOperation:op];
    
    [UIImage jr_swizzleClassMethod:@selector(imageNamed:)
                   withClassMethod:@selector(getImageByName:)
                             error:nil];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
