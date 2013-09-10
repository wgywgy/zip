//
//  UIImage+zipArchiveAndTexure.m
//  zip
//
//  Created by D on 13-9-10.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import "UIImage+zipArchiveAndTexure.h"

@implementation UIImage (zipArchiveAndTexure)

+ (UIImage *)getImageByName:(NSString *)imageName
{
    return [[TexureManager shareInstance]getUIImageByName:imageName];
}

@end
