//
//  XIU_MyCenterModifyAvatarCell.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#define ModifyAvatarCell_HeightIcon 50.0

#import "XIU_MyCenterModifyAvatarCell.h"

@interface XIU_MyCenterModifyAvatarCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *userIconView;

@end
@implementation XIU_MyCenterModifyAvatarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor xiu_tableViewBackgroundColor];
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPaddingLeftWidth, ([XIU_MyCenterModifyAvatarCell cellHeight] -30)/2, 100, 30)];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_titleLabel];
        }
        if (!_userIconView) {
            _userIconView = [[UIImageView alloc] initWithFrame:CGRectMake((KWIDTH- ModifyAvatarCell_HeightIcon)- kPaddingLeftWidth- 30, ([XIU_MyCenterModifyAvatarCell cellHeight] -ModifyAvatarCell_HeightIcon)/2, ModifyAvatarCell_HeightIcon, ModifyAvatarCell_HeightIcon)];
            [_userIconView doCircleFrame];
            [self.contentView addSubview:_userIconView];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!_curUser) {
        return;
    }
    self.titleLabel.text = @"头像";
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:_curUser.userImage] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
}

+ (CGFloat)cellHeight{
    return 70.0;
}

@end
