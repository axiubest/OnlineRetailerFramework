//
//  XIU_SearchBarCell.h
//  XIU_SearchBarDemo
//
//  Created by XIUDeveloper on 2017/1/19.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const XIU_SearchBarIdentifier = @"XIU_SearchBarCell";
@protocol SearchBarCellDelegate <NSObject>

- (void)searchBarCellWithKeyword:(NSString *)moKeyworddel;

@end

@interface XIU_SearchBarCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndDataArray:(NSMutableArray *)array;
@property (nonatomic, assign) id<SearchBarCellDelegate> XIUDelegate;

@end



@interface XIU_ButtonItem :UIView


-(instancetype)initWithFrame:(CGRect)frame WithString:(NSString *)string;

@end


@interface XIU_HistorySearch : UIView<UIAlertViewDelegate>

-(instancetype)initWithFrame:(CGRect)frame WithTitleName:(NSString *)titleName;

@end
