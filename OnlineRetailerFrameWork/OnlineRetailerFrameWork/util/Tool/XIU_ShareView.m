//
//  XIU_ShareView.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//


#define kCodingShareView_NumPerLine 4
#define kCodingShareView_NumPerScroll (2 * kCodingShareView_NumPerLine)
#define kCodingShareView_TopHeight 60.0
#define kCodingShareView_BottomHeight 65.0
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (KWIDTH/320))


#import "XIU_ShareView.h"
#import "UIView+BlocksKit.h"
#import "SMPageControl.h"
#import "XIU_UMManager.h"
#import "XIU_ShareModel.h"

@interface XIU_ShareView ()

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *titleL;
@property (strong, nonatomic) UIButton *dismissBtn;
@property (strong, nonatomic) UIScrollView *itemsScrollView;
@property (strong, nonatomic) NSArray *shareSnsValues;
@property (strong, nonatomic) SMPageControl *myPageControl;
@property (strong, nonatomic) XIU_ShareModel *shareModel;


@end
static XIU_ShareView *shared_instance = nil;

@implementation XIU_ShareView

- (XIU_ShareModel *)shareModel {
    if (!_shareModel) {
        _shareModel  = [[XIU_ShareModel alloc] init];
        [_shareModel setTitle:@""];
        [_shareModel setDiscription:@""];
        [_shareModel setUrl:@""];
    }
    return _shareModel;
}



+ (instancetype)sharedInstance{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_instance = [[self alloc] init];
    });
    return shared_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        
        if (!_bgView) {
            _bgView = ({
                UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0;
                [view bk_whenTapped:^{
                    [self p_dismiss];
                }];
                view;
            });
            [self addSubview:_bgView];
        }
        if (!_contentView) {
            _contentView = [UIView new];
            _contentView.backgroundColor = [UIColor xiu_tableViewSectionBackgroundColor];
            if (!_titleL) {
                _titleL = ({
                    UILabel *label = [UILabel new];
                    label.textAlignment = NSTextAlignmentCenter;
                    label.font = [UIFont systemFontOfSize:14];
                    label.textColor = [UIColor xiu_666color];
                    label;
                });
                [_contentView addSubview:_titleL];
                [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_contentView);
                    make.top.equalTo(_contentView).offset(10);
                    make.height.mas_equalTo(20);
                }];
            }
            if (!_dismissBtn) {
                _dismissBtn = ({
                    UIButton *button = [UIButton new];
                    button.backgroundColor = [UIColor whiteColor];
                    button.layer.masksToBounds = YES;
                    button.layer.cornerRadius = 2.0;
                    button.titleLabel.font = [UIFont systemFontOfSize:15];
                    [button setTitle:@"取消" forState:UIControlStateNormal];
                    [button setTitleColor:[UIColor colorWithHexString:@"0x808080"] forState:UIControlStateNormal];
                    [button setTitleColor: [UIColor colorWithHexString:@"0x3BBD79"] forState:UIControlStateHighlighted];
                    [button addTarget:self action:@selector(p_dismiss) forControlEvents:UIControlEventTouchUpInside];
                    button;
                });
                [_contentView addSubview:_dismissBtn];
                [_dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_contentView).offset(kPaddingLeftWidth);
                    make.right.equalTo(_contentView).offset(-kPaddingLeftWidth);
                    make.bottom.equalTo(_contentView).offset(-kPaddingLeftWidth);
                    make.height.mas_equalTo(40);
                }];
            }
            if (!_itemsScrollView) {
                _itemsScrollView = ({
                    UIScrollView *scrollView = [UIScrollView new];
                    scrollView.pagingEnabled = YES;
                    scrollView.showsHorizontalScrollIndicator = NO;
                    scrollView.showsVerticalScrollIndicator = NO;
                    scrollView;
                });
                [_contentView addSubview:_itemsScrollView];
                [_itemsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_contentView);
                    make.top.equalTo(_contentView).offset(kCodingShareView_TopHeight);
                    make.bottom.equalTo(_contentView).offset(-kCodingShareView_BottomHeight);
                }];
            }
            [_contentView setY:KHEIGHT];
            [self addSubview:_contentView];
        }
    }
    return self;
}

+ (void)showShareView {
    [[self sharedInstance] StartShow];

}


- (void)StartShow{
    _titleL.text = @"分享到";
    [self p_checkShareSnsValues];
    
    [kKeyWindow addSubview:self];
    
    //animate to show
    CGPoint endCenter = self.contentView.center;
    endCenter.y -= CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.3;
        self.contentView.center = endCenter;
    } completion:nil];
}

- (void)p_checkShareSnsValues{
    self.shareSnsValues = [XIU_ShareView supportSnsValues];
}

+(NSArray *)supportSnsValues{
    NSMutableArray *resultSnsValues = [@[
                                         @"wxsession",
                                         @"wxtimeline",
                                         @"qq",
                                         @"qzone",
                                         @"sina",
                                         @"copylink",
                                         @"inform"
                                         ] mutableCopy];
    
    [XIU_UMManager removeObjOfUninstallProduct:resultSnsValues];


    
    return resultSnsValues;
}

+(BOOL)canOpen:(NSString*)url{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

- (void)p_dismiss{
    //animate to dismiss
    CGPoint endCenter = self.contentView.center;
    endCenter.y += CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (NSDictionary *)snsNameDict{
    
    
    static NSDictionary *snsNameDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        snsNameDict = @{
                        @"copylink": @"复制链接",
                        @"sina": @"新浪微博",
                        @"qzone": @"QQ空间",
                        @"qq": @"QQ好友",
                        @"wxtimeline": @"朋友圈",
                        @"wxsession": @"微信好友",
                        @"inform": @"举报"
                        };
    });
    return snsNameDict;
    
}


- (void)setShareSnsValues:(NSArray *)shareSnsValues{
    if (![_shareSnsValues isEqualToArray:shareSnsValues]) {
        _shareSnsValues = shareSnsValues;
        [[_itemsScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (int index = 0; index < _shareSnsValues.count; index++) {
            NSInteger scrollIndex = index/kCodingShareView_NumPerScroll;
            NSInteger itemIndex = index % kCodingShareView_NumPerScroll;
            CGPoint pointO = CGPointZero;
            pointO.x = [CodingShareView_Item itemWidth] * (itemIndex % kCodingShareView_NumPerLine) + KWIDTH * scrollIndex;
            pointO.y = [CodingShareView_Item itemHeight] * (itemIndex / kCodingShareView_NumPerLine);
            
            NSString *snsName = _shareSnsValues[index];
            CodingShareView_Item *item = [CodingShareView_Item itemWithSnsName:snsName];
            [item setOrigin:pointO];
            
            item.clickedBlock = ^(NSString *snsName){
                [self p_shareItemClickedWithSnsName:snsName];
            };
            [_itemsScrollView addSubview:item];
        }
        CGFloat scrollPageNum = 1 + (_shareSnsValues.count/kCodingShareView_NumPerScroll);
        [_itemsScrollView setContentSize:CGSizeMake(scrollPageNum * KWIDTH, 2* [CodingShareView_Item itemHeight])];
        _itemsScrollView.scrollEnabled = scrollPageNum > 1;
        
        if (scrollPageNum > 1) {
            self.myPageControl.numberOfPages = scrollPageNum;
            self.myPageControl.hidden = NO;
        }else{
            _myPageControl.hidden = YES;
        }
        CGFloat contentHeight = kCodingShareView_TopHeight + kCodingShareView_BottomHeight + 2* [CodingShareView_Item itemHeight];
        [self.contentView setSize:CGSizeMake(KWIDTH, contentHeight)];
    }
    [_itemsScrollView setContentOffset:CGPointZero];
}

- (void)p_shareItemClickedWithSnsName:(NSString *)snsName{
    void (^completion)() = ^(){
        [self p_doShareToSnsName:snsName];
    };
    [self p_dismissWithCompletionBlock:completion];
}

- (void)p_doShareToSnsName:(NSString *)snsName{
    NSLog(@"p_doShareToSnsName : %@", snsName);
    
    [XIU_UMManager shareObjectWithSnsName:snsName WithMessageValue:self.shareModel];
    

}




- (void)p_dismissWithCompletionBlock:(void (^)(void))completionBlock{
    //animate to dismiss
    CGPoint endCenter = self.contentView.center;
    endCenter.y += CGRectGetHeight(self.contentView.frame);
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completionBlock) {
            completionBlock();
        }
    }];
}
@end



@interface CodingShareView_Item ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *titleL;
@end

@implementation CodingShareView_Item

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [CodingShareView_Item itemWidth], [CodingShareView_Item itemHeight]);
        _button = [UIButton new];
        [self addSubview:_button];
        CGFloat padding_button = kScaleFrom_iPhone5_Desgin(kPaddingLeftWidth);
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(padding_button);
            make.right.equalTo(self).offset(-padding_button);
            make.height.mas_equalTo([CodingShareView_Item itemWidth] - 2*padding_button);
        }];
        _titleL = ({
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor xiu_666color];
            label;
        });
        [self addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(15);
            make.top.equalTo(self.button.mas_bottom).offset(kPaddingLeftWidth);
        }];
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttonClicked{
//    [MobClick event:kUmeng_Event_Request_ActionOfLocal label:[NSString stringWithFormat:@"umeng_social_%@", _snsName]];
    if (self.clickedBlock) {
        self.clickedBlock(_snsName);
    }
}

- (void)setSnsName:(NSString *)snsName{
    if (![_snsName isEqualToString:snsName]) {
        _snsName = snsName;
        NSString *imageName = [NSString stringWithFormat:@"share_btn_%@", snsName];
        NSString *title = [[XIU_ShareView snsNameDict] objectForKey:snsName];
        [_button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        _titleL.text = title;
    }
}

+ (instancetype)itemWithSnsName:(NSString *)snsName{
    CodingShareView_Item *item = [self new];
    item.snsName = snsName;
    return item;
}

+ (CGFloat)itemWidth{
    return KWIDTH/kCodingShareView_NumPerLine;
}

+ (CGFloat)itemHeight{
    return [self itemWidth] + 20;
}
@end

