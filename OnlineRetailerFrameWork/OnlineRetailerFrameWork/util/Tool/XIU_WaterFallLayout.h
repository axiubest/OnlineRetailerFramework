//
//  XIU_WaterFallLayout.h
//  OnlineRetailerFrameWork
//
//  Created by A-XIU on 2017/5/22.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XIU_WaterFallLayout;
@protocol XIU_FlowLayoutDelegate <NSObject>
/**
 *  这个代理方法用于在viewcontroller中通过Width来计算高度
 *
 *  @param Flow      flowlayout
 *  @param width     图片的宽
 *  @param indexPath indexPath
 *
 *  @return 图片的高
 */
-(CGFloat)Flow:(XIU_WaterFallLayout *)Flow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end
@interface XIU_WaterFallLayout : UICollectionViewFlowLayout
@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMagrin;//行间距
@property(nonatomic,assign)CGFloat colMagrin;//列间距
@property(nonatomic,assign)CGFloat colCount;//多少列
@property(nonatomic,weak)id<XIU_FlowLayoutDelegate>degelate;
@end
