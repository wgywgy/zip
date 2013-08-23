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
	            NSDate *tmpStartData = [NSDate date];
	            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
	                           ^{
                                   NSFileManager *fileManager = [NSFileManager defaultManager];
                                   [fileManager removeItemAtPath:resPath error:nil];
                               });
	            double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
	            NSLog(@"cost time = %f", deltaTime);
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
    
	queue = [[NSOperationQueue alloc] init];
	NSInvocationOperation *op = [[[NSInvocationOperation alloc] initWithTarget:self
	                                                                  selector:@selector(zipFile)
	                                                                    object:nil] autorelease];
	[queue addOperation:op];
    
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
