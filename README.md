zip
===

Can get the Image in the zip file which generated from TexturePacker.
从zip压缩过的TexturePacker生成的文件取出图片。

Usage:
用法:

1.Generated image file by TextPacker, and compressed into a zip.
  通过TextPacker生成图片文件，并压缩成zip。

2.Project put into the minizip folder, zipArchive.h, zipArchive.mm, TexureManager.h, TexureManager.m.
  项目中导入minizip文件夹, zipArchive.h, zipArchive.mm, TexureManager.h, TexureManager.m。

3.The program enters the first viewController joined the zipfile function (which the project file),The function is as follows (the which demo.zip you compress the file).
  在程序进入的第一个viewController里加入zipFile函数(项目文件当中有),函数如下(其中demo.zip为你压缩过后的文件)：
- (void)zipFile
{
    NSString *resPath = [[NSBundle mainBundle] pathForResource:@"demo"
                                                        ofType:@"zip"];
    
    ZipArchive *za = [[ZipArchive alloc] init];
    
    if( [za UnzipOpenFile:resPath] ) //解压
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; //前两句为获取Documents在真机中的地址
        
        BOOL ret = [za UnzipFileTo:documentsDirectory overWrite:YES];
        if(YES == ret)
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:resPath error:nil];
        }
        [za UnzipCloseFile];
    }
    
    [za release];
}

And call it. [self zipFile];
并调用它。

4.Need to use the pictures ViewController use #import "TexureManager.h"
  在需要使用图片的ViewController里 #import "TexureManager.h"

5.Added in viewDidLoad (demo_texture for TexturePacker generated file name):
  在viewdidload中加入(demo_texture为TexturePacker生成文件名):
[[TexureManager shareInstance] addTextureFile:@"demo_texture"];
    
6.get Image function as follows:
  使用图片函数如下：
 UIImage * myImg = [[TexureManager shareInstance]getUIImageByName:@"UI_FacebookButton.png"];