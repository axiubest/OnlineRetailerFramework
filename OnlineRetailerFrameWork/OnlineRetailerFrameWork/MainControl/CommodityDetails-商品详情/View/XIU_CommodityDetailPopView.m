

#import "XIU_CommodityDetailPopView.h"

#define kViewWidth CGRectGetWidth(self.frame)
#define kViewHeight CGRectGetHeight(self.frame)
#define kScrollViewWidth kViewWidth * 0.75
#define kScale 0.8
#define kImageTag 888

@interface XIU_CommodityDetailPopView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, assign) NSInteger currIndex;

@property (nonatomic, assign) CGFloat beginOffX;

@end

@implementation XIU_CommodityDetailPopView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScrollViewWidth, kViewHeight)];
    self.scrollView.center = self.center;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
}
- (void)setItmeArray:(NSMutableArray *)itmeArray
{
    _itmeArray = itmeArray;
    for (NSInteger i = 0; i < _itmeArray.count; i ++) {
        
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScrollViewWidth * i, kViewHeight * .15, kScrollViewWidth * .65, kViewHeight * .8)];
        imageView.tag = kImageTag + i;
        
        [_scrollView addSubview:imageView];
        CALayer * layer = [CALayer layer];
        layer.frame = imageView.bounds;
        layer.contents = (__bridge id _Nullable)([self imageWithRoundedCornersSize:CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height) andCornerRadius:0 image:self.itmeArray[i]].CGImage);

        layer.shadowOffset = CGSizeMake(0, 0);
        layer.shadowOpacity = .8;
        [imageView.layer addSublayer:layer];
        
        
        if (0 == i) {
            continue;
        }
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, kScale);
        
    }
    self.scrollView.contentSize = CGSizeMake(kScrollViewWidth * _itmeArray.count, kViewHeight);
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer * panGes = (UIPanGestureRecognizer *)gestureRecognizer;
        
        CGPoint translation = [panGes translationInView:_scrollView];

        if (translation.y < 0) {
            return YES;
        }
    }
    return NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (_delegate && [_delegate respondsToSelector:@selector(scrolIndex:)]) {
        [self.delegate scrolIndex:index];
    }
    
    UIImageView * currImageView = [scrollView viewWithTag:kImageTag + index];
    
    UIImageView * beforeImageView = [scrollView viewWithTag:kImageTag + index - 1];
    
    UIImageView * afterImageView = [scrollView viewWithTag:kImageTag + index + 1];
    
    if (currImageView) {
        currImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    }
    
    if (beforeImageView) {
        beforeImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, kScale);
    }
    
    if (afterImageView) {
        afterImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, kScale);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.currIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.beginOffX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIImageView * currImageView = [scrollView viewWithTag:kImageTag + self.currIndex];
    
    UIImageView * beforeImageView = [scrollView viewWithTag:kImageTag + self.currIndex - 1];
    
    UIImageView * afterImageView = [scrollView viewWithTag:kImageTag + self.currIndex + 1];
    
    CGFloat off_X = scrollView.contentOffset.x - _beginOffX;// >0左滑
    
    CGFloat scale = 1 - fabs(off_X / scrollView.frame.size.width);
    
    CGFloat endScale = 1.0;
    if (scale > 1.0) {
        endScale = 1.0;
    }else if (scale > kScale)
    {
        endScale = scale;
    }else{
        endScale = kScale;
    }
//    NSLog(@"----endScale:%f----scale:%f",endScale,scale);
    if (currImageView) {
        currImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, endScale);
    }
    
    if (beforeImageView) {
        
        if (off_X < 0) {
            
            CGFloat beforeScale = 1 - scale + kScale;
            if (beforeScale > 1) {
                beforeScale = 1;
            }
//            NSLog(@"------beforescale:%f",beforeScale);
            beforeImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, beforeScale);
        }else{
            beforeImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, kScale);
        }
        
    }
    
    if (afterImageView) {
        
        if (off_X > 0) {
            CGFloat afterScale = 1 - scale + kScale;
            if (afterScale > 1) {
                afterScale = 1;
            }
//            NSLog(@"------afterscale:%f",afterScale);
            afterImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, afterScale);
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImage *)imageWithRoundedCornersSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius image:(UIImage *)image
{
    
    CGRect rect = (CGRect){0.f, 0.f, sizeToFit};
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, NO, UIScreen.mainScreen.scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [image drawInRect:rect];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return output;
}
@end
