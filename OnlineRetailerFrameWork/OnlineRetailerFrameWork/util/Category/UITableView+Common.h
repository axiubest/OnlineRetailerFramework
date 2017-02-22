//
//  UITableView+Common.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellHeightCache : NSObject

@property(nonatomic,assign) CGFloat cellHeight;

- (BOOL)existsHeightForKey:(id<NSCopying>)key;
- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key;
- (CGFloat)heightForKey:(id<NSCopying>)key;

@end


@interface UITableView (Common)

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;


//行高缓存
@property(nonatomic,strong,readonly) CellHeightCache *cellHeightCache;

- (CGFloat)getCellHeightCacheWithCacheKey:(NSString *)cacheKey;

- (void)setCellHeightCacheWithCellHeight:(CGFloat)cellHeight CacheKey:(NSString *)cacheKey;
@end
