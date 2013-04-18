//
//  TexureManager.h
//  TexurePackerForCocoa
//
//  Created by demon on 9/5/12.
//  Copyright (c) 2012 demon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TexureManager : NSObject {
    NSMutableDictionary * texureDic;
}

/**
 *	@brief	得到TexureManager的单实例对象
 *
 *	@return	TexureManager单实例
 */
+(TexureManager*)shareInstance;

/**
 *	@brief	通过纹理data.plist名添加纹理图像
 *
 *	@param 	fileName 	texture生成的.plist文件（不需要扩展名）
 */
-(void)addTextureFile:(NSString*)fileName;

/**
 *	@brief	通过图片名从TextureManager中得到UIImage对象
 *
 *	@param 	imageName 	在TexturePacker Publish之前的的原图片名
 *
 *	@return	UIImage对象，和之前[UIImage imageNamed:imageName]返回的对象一致
 */
-(UIImage*)getUIImageByName:(NSString*)imageName;

/**
 *	@brief	得到所有TexureManager中的UIImage对象
 *
 *	@return	UIImage的一个数组
 */
-(NSArray*)getAllImages;


@end
