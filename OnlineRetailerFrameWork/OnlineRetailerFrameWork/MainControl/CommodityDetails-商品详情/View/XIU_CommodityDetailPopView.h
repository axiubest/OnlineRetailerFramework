

#import <UIKit/UIKit.h>

@protocol XIUScrollViewDelegate <NSObject>

- (void)scrolIndex:(NSInteger)index;

@end

@interface XIU_CommodityDetailPopView : UIView

@property (nonatomic, weak) id <XIUScrollViewDelegate>delegate;

@property (nonatomic, strong) NSMutableArray * itmeArray;



@end
