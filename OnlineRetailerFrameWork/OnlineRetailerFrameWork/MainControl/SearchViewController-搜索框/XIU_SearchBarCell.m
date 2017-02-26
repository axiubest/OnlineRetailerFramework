//
//  XIU_SearchBarCell.m
//  XIU_SearchBarDemo
//
//  Created by XIUDeveloper on 2017/1/19.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SearchBarCell.h"
#import "Masonry.h"


#define SIZE_MAGRIN_ITEM 12


@implementation XIU_SearchBarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndDataArray:(NSMutableArray *)array {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        XIU_HistorySearch *search = [[XIU_HistorySearch alloc] initWithFrame:CGRectMake(0, 8, KWIDTH, 40) WithTitleName:@"最近搜索"];
        [self.contentView addSubview:search];
        
        
        CGFloat x = 0,  y = 50 , margin = 18,total=0;
        x = margin;
        for(int i=0;i<array.count;i++){
            
            NSString *str = array[i];
            
            NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:13.f]};
            CGSize size=[str sizeWithAttributes:attrs];
            size.width > [UIScreen mainScreen].bounds.size.width ? size.width = [UIScreen mainScreen].bounds.size.width - 2 * margin - 2 * SIZE_MAGRIN_ITEM : size.width;
            x = margin+total;
            total += size.width+16+margin;
            if (total>[UIScreen mainScreen].bounds.size.width) {
                total = 0;
                y+=40;
                x = margin+total;
                total += size.width + SIZE_MAGRIN_ITEM + margin;
            }
            XIU_ButtonItem *item = [[XIU_ButtonItem alloc] initWithFrame:CGRectMake(x, y, size.width + SIZE_MAGRIN_ITEM * 2, 23) WithString:array[i]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chickedButtonWithModel:)];
            [self addGestureRecognizer:tap];
            
            [self.contentView addSubview:item];

        }


        
    }
    return self;
}

- (void)chickedButtonWithModel:(NSString *)keyword {
    [_XIUDelegate searchBarCellWithKeyword:keyword];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}


@end



#pragma mark--------------------------------------------
@implementation XIU_ButtonItem

-(instancetype)initWithFrame:(CGRect)frame WithString:(NSString *)string {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setCornerRadius:3];
        self.backgroundColor = [UIColor xiu_tableViewSectionBackgroundColor];
        UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(SIZE_MAGRIN_ITEM, 0, frame.size.width - SIZE_MAGRIN_ITEM * 2, frame.size.height)];
        textLab.font = [UIFont systemFontOfSize:13.f];
        textLab.text = string;
        textLab.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:textLab];
    }
    return self;
}

@end









#pragma mark--------------------------------------------

@implementation XIU_HistorySearch

-(instancetype)initWithFrame:(CGRect)frame WithTitleName:(NSString *)titleName {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"放大镜"]];

        [self addSubview:img];
        
        UIImageView *trushImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"垃圾箱"]];
        [trushImageView setUserInteractionEnabled:YES];
        [trushImageView bk_whenTapped:^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要清除历史记录吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }];
        [self addSubview:trushImageView];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.text = titleName;
        titleLab.font = [UIFont systemFontOfSize:13];
        titleLab.textColor = [UIColor blackColor];
        [self addSubview:titleLab];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.centerY.equalTo(self);
        }];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(img.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.centerY.equalTo(img.mas_centerY);
        }];
        
        [trushImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(18, 18));
            make.centerY.equalTo(self);
        }];
        
        if ([titleName isEqualToString:@"最近搜索"]) {
            
        }
    }
    return self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:history_search];
        
        [[NSNotificationCenter defaultCenter]postNotification: [NSNotification notificationWithName:@"DeleteAllHistorySearchNotification" object:nil userInfo:nil]];
    }
}
@end


