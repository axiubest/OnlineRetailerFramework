//
//  PullDownMenu.h
//  PullDownMenu
//
//  Created by 離去之原 on 18/2/2017.
//  Copyright © 2017年 離去之原. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullDownMenu : UIView
@property (nonatomic) void (^handleSelectDataBlock) (NSString *selectTitle, NSUInteger selectIndex ,NSUInteger selectButtonTag);

@property (nonatomic) UIButton  *tempButton;
@property (assign, nonatomic) NSInteger hiddenBlock;
/*!@brief 二维数组，存放每个Button对应下的TableView数据。。 */
@property (nonatomic) NSMutableArray *menuDataArray;

- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray;

- (void)setNormalSelected:(NSString*)title;

- (void)setSecSelected:(NSString *)title;

- (void)resetCount:(NSMutableArray *)countArray;
/*!@brief 数据源如果改变的话需调用此方法刷新数据。 */
-(void)setDefauldSelectedCell;
@end

@interface downMenuCell : UITableViewCell

@property (strong, nonatomic) UIImageView *selectImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *countLabel;
@property (nonatomic) BOOL isSelected;
@end

@interface ButtonCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *titleLabel;
@property (nonatomic) BOOL isSelected;

@end
