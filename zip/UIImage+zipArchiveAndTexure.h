//
//  UIImage+zipArchiveAndTexure.h
//  zip
//
//  Created by D on 13-9-10.
//  Copyright (c) 2013年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TexureManager.h"

@interface UIImage (zipArchiveAndTexure)

/**
 *  得到图片 通过单例获取对象
 *
 *  @param imageName 照片名
 *
 *  @return UIImage对象
 */
+ (UIImage *)getImageByName:(NSString *)imageName;

@end
