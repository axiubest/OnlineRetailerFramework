//
//  XIU_SearchBarSimulationView.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/2/8.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_SearchBarSimulationView.h"

#define SIMULATION_ITEM_SIZE 20
@implementation XIU_SearchBarSimulationView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = 1;
        self.layer.cornerRadius = 3;
        self.backgroundColor = [UIColor redColor];
        UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_search_simulator"]];
        [self addSubview:searchImage];
        
        UILabel *KeyWordLabel = [[UILabel alloc] init];
        KeyWordLabel.text = @"搜索";
        KeyWordLabel.textColor = [UIColor whiteColor];
        KeyWordLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:KeyWordLabel];
        
      
        UIImageView *camera = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"照相机"]];
        [camera bk_whenTapped:^{
            //
        }];
        [self addSubview:camera];
        
        [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(SIMULATION_ITEM_SIZE, SIMULATION_ITEM_SIZE));
        }];
        
        [KeyWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(searchImage.mas_right).with.offset(5);
            make.top.and.bottom.equalTo(self).with.offset(0);
        }];
        
        [camera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(SIMULATION_ITEM_SIZE, SIMULATION_ITEM_SIZE));
        }];
    }
    return self;
}
@end
