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

- (void)zip_Completed
{
    UIImage * myImg = [[TexureManager shareInstance]getUIImageByName:@"UI_FacebookButton.png"];
    UIImageView * myImgView = [[UIImageView alloc]initWithImage:myImg];
    [self.view addSubview:myImgView];
    [myImgView release]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
