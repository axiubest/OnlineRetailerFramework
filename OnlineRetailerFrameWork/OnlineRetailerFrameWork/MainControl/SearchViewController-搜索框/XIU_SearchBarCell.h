//
//  XIU_SearchBarCell.h
//  XIU_SearchBarDemo
//
//  Created by XIUDeveloper on 2017/1/19.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBarModel.h"

@protocol SearchBarCellDelegate <NSObject>

- (void)searchBarCell:(SearchBarModel *)model;

@end

@interface XIU_SearchBarCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndDataArray:(NSArray <SearchBarModel *>*)array;
@property (nonatomic, assign) id<SearchBarCellDelegate> XIUDelegate;

@end



@interface XIU_ButtonItem :UIView


-(instancetype)initWithFrame:(CGRect)frame WithModel:(SearchBarModel *)model;

@end


@interface XIU_HistorySearch : UIView

-(instancetype)initWithFrame:(CGRect)frame WithTitleName:(NSString *)titleName;

@end
