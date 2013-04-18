//
//  ViewController.m
//  zip
//
//  Created by D on 13-4-16.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "ViewController.h"
#import "TexureManager.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self zipFile];
    
    [[TexureManager shareInstance] addTextureFile:@"demo_texture"];
    
    UIImage * myImg = [[TexureManager shareInstance]getUIImageByName:@"UI_FacebookButton.png"];
    UIImageView * myImgView = [[UIImageView alloc]initWithImage:myImg];
    [self.view addSubview:myImgView];
    [myImgView release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
