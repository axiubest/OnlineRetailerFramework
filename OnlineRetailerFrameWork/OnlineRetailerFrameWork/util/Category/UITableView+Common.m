//
//  UITableView+Common.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/13.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "UITableView+Common.h"
#import <objc/runtime.h>

@interface CellHeightCache ()

@property(nonatomic,strong) NSMutableDictionary<id<NSCopying>, NSNumber *> *mutableCellHeightCaches;

@end

@implementation CellHeightCache

- (void)setCellHeight:(CGFloat)cellHeight
{
    _cellHeight = cellHeight;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _mutableCellHeightCaches = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (BOOL)existsHeightForKey:(id<NSCopying>)key {
    NSNumber *number = self.mutableCellHeightCaches[key];
    return number && ![number isEqualToNumber:@-1];
}

- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key {
    self.mutableCellHeightCaches[key] = @(height);
}

- (CGFloat)heightForKey:(id<NSCopying>)key {
#if CGFLOAT_IS_DOUBLE
    return [self.mutableCellHeightCaches[key] doubleValue];
#else
    return [self.mutableCellHeightCaches[key] floatValue];
#endif
}


@end

@implementation UITableView (Common)


- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace{
    [self addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:leftSpace hasSectionLine:YES];
}

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace hasSectionLine:(BOOL)hasSectionLine{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    
    CGRect bounds = CGRectInset(cell.bounds, 0, 0);
    
    CGPathAddRect(pathRef, nil, bounds);
    
    layer.path = pathRef;
    
    CFRelease(pathRef);
    if (cell.backgroundColor) {
        layer.fillColor = cell.backgroundColor.CGColor;//layer的填充色用cell原本的颜色
    }else if (cell.backgroundView && cell.backgroundView.backgroundColor){
        layer.fillColor = cell.backgroundView.backgroundColor.CGColor;
    }else{
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    }
    
    CGColorRef lineColor = [UIColor grayColor].CGColor;
    CGColorRef sectionLineColor = lineColor;
    
    if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //只有一个cell。加上长线&下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else if (indexPath.row == 0) {
        //第一个cell。加上长线&下短线
        if (hasSectionLine) {
            [self layer:layer addLineUp:YES andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        //最后一个cell。加下长线
        if (hasSectionLine) {
            [self layer:layer addLineUp:NO andLong:YES andColor:sectionLineColor andBounds:bounds withLeftSpace:0];
        }
    } else {
        //中间的cell。只加下短线
        [self layer:layer addLineUp:NO andLong:NO andColor:lineColor andBounds:bounds withLeftSpace:leftSpace];
    }
    UIView *testView = [[UIView alloc] initWithFrame:bounds];
    [testView.layer insertSublayer:layer atIndex:0];
    cell.backgroundView = testView;
}

- (void)layer:(CALayer *)layer addLineUp:(BOOL)isUp andLong:(BOOL)isLong andColor:(CGColorRef)color andBounds:(CGRect)bounds withLeftSpace:(CGFloat)leftSpace{
    
    CALayer *lineLayer = [[CALayer alloc] init];
    CGFloat lineHeight = (1.0f / [UIScreen mainScreen].scale);
    CGFloat left, top;
    if (isUp) {
        top = 0;
    }else{
        top = bounds.size.height-lineHeight;
    }
    
    if (isLong) {
        left = 0;
    }else{
        left = leftSpace;
    }
    lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+left, top, bounds.size.width-left, lineHeight);
    lineLayer.backgroundColor = color;
    [layer addSublayer:lineLayer];
}




#pragma mark 动态计算行高
//如果缓存存在则返回，不则在则设置缓存
- (CellHeightCache *)cellHeightCache
{
    CellHeightCache *cache = objc_getAssociatedObject(self, _cmd);
    if (!cache) {
        cache = [CellHeightCache new];
        objc_setAssociatedObject(self, _cmd, cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cache;
}


- (CGFloat)getCellHeightCacheWithCacheKey:(NSString *)cacheKey
{
    if (!cacheKey) {
        return 0;
    }
    
    //如果已经存在cell height 则返回
    if ([self.cellHeightCache existsHeightForKey:cacheKey]) {
        CGFloat cachedHeight = [self.cellHeightCache heightForKey:cacheKey];
        return cachedHeight;
    } else {
        return 0;
    }
}

//缓存cell的高度
- (void)setCellHeightCacheWithCellHeight:(CGFloat)cellHeight CacheKey:(NSString *)cacheKey
{
    [self.cellHeightCache cacheHeight:cellHeight byKey:cacheKey];
}



@end
