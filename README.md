zip
===
[![Build Status](https://travis-ci.org/wgywgy/zip.png?branch=master)](https://travis-ci.org/wgywgy/zip)

**Can get the Image in the zip file which generated from TexturePacker.**<br />

### Usage :
**1.** 
Generated image file by TextPacker, and compressed into a zip.<br />

**2.** Project put into the zipAndTexure group.And import libz.dylib class library.<br />

**3.** In the AppDelegate.m import `` "TexureManager.h", "ZipArchive.h", "UIImage+zipArchiveAndTexure.h", "JRSwizzle.h" ``.And joined the zipfile function (you can see in the project file),The function is as follows (the which demo.zip you compress the file,demo_texture is the TexturePacker generated file name).<br />

	static dispatch_once_t once;
    
	dispatch_once(&once, ^{
	    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"demo"
	                                                        ofType:@"zip"];
        
	    ZipArchive *za = [[ZipArchive alloc] init];
        
	    if ([za UnzipOpenFile:resPath]) { //zip file
	        NSArray *paths = 
	        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	        NSString *documentsDirectory = paths[0]; //get Documents address
            
	        BOOL ret = [za UnzipFileTo:documentsDirectory overWrite:YES];
	        if (YES == ret) {
	            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
	                           ^{
                                   NSFileManager *fileManager = [NSFileManager defaultManager];
                                   [fileManager removeItemAtPath:resPath error:nil];
                               });
			}
	        [za UnzipCloseFile];
		}
        
	    [za release];
	    [[TexureManager shareInstance] addTextureFile:@"demo_texture"];
	    [self.viewController performSelectorOnMainThread:@selector(zip_Completed)
	                                          withObject:nil
	                                       waitUntilDone:NO];
	});

And then in method

	- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

add follows: <br />

	queue = [[NSOperationQueue alloc] init];
	NSInvocationOperation *op = [[[NSInvocationOperation alloc] initWithTarget:self
	                                                                  selector:@selector(zipFile)
	                                                                    object:nil] autorelease];
	[queue addOperation:op];
    
    [UIImage jr_swizzleClassMethod:@selector(imageNamed:)
                   withClassMethod:@selector(getImageByName:)
                             error:nil];
**4.**
  get Image function as follows:<br />
 
 	UIImage * myImg = [UIImage imageNamed:@"UI_FacebookButton.png"];
 
 
<br />**从zip压缩过的TexturePacker生成的文件取出图片。**
 
### 用法 :
 **1.** 
通过TextPacker生成图片文件，并压缩成zip。<br />
 **2.**
项目中导入zipAndTexure组（黄色文件夹）。并且导入libz.dylib类库。<br />
 **3.**
在程序的AppDelegate.m里引用`` "TexureManager.h", "ZipArchive.h", "UIImage+zipArchiveAndTexure.h", "JRSwizzle.h" ``。再加入zipFile函数(项目文件当中有),函数如下(其中demo.zip为你压缩过后的文件,demo_texture为TexturePacker生成文件名):<br />

	static dispatch_once_t once;
    
	dispatch_once(&once, ^{
	    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"demo"
	                                                        ofType:@"zip"];
        
	    ZipArchive *za = [[ZipArchive alloc] init];
        
	    if ([za UnzipOpenFile:resPath]) { //解压
	        NSArray *paths = 
	        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	        NSString *documentsDirectory = paths[0]; //前两句为获取Documents在真机中的地址
            
	        BOOL ret = [za UnzipFileTo:documentsDirectory overWrite:YES];
	        if (YES == ret) {
	            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),
	                           ^{
                                   NSFileManager *fileManager = [NSFileManager defaultManager];
                                   [fileManager removeItemAtPath:resPath error:nil];
                               });
			}
	        [za UnzipCloseFile];
		}
        
	    [za release];
	    [[TexureManager shareInstance] addTextureFile:@"demo_texture"];
	    [self.viewController performSelectorOnMainThread:@selector(zip_Completed)
	                                          withObject:nil
	                                       waitUntilDone:NO];
	});

然后在

	- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

方法中添加如下代码。 <br />

	queue = [[NSOperationQueue alloc] init];
	NSInvocationOperation *op = [[[NSInvocationOperation alloc] initWithTarget:self
	                                                                  selector:@selector(zipFile)
	                                                                    object:nil] autorelease];
	[queue addOperation:op];
    
    [UIImage jr_swizzleClassMethod:@selector(imageNamed:)
                   withClassMethod:@selector(getImageByName:)
                             error:nil];
**4.**
使用图片函数如下：<br />

	UIImage * myImg = [UIImage imageNamed:@"UI_FacebookButton.png"];
	