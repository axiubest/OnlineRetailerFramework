//
//  XIU_MyCenterUserHeaderView.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_MyCenterUserHeaderView.h"

@interface XIU_MyCenterUserHeaderView ()


@end

@implementation XIU_MyCenterUserHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if ([XIU_Login isLogin]) {
            [self setUpUIWithUserInfoFrame:frame];
        }else {
            [self setUpUIWithLogin:frame];
        }
    }
    return self;
}


- (void)setUpUIWithLogin:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:backView];
    
    UIImageView *headerImage = [[UIImageView alloc] init];

    [headerImage setImage:[UIImage imageNamed:@"first_normal"]];
    [backView addSubview:headerImage];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"点击登录";

    nameLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nameLab];
    
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).with.offset(40);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImage.mas_bottom).with.offset(0);
        make.left.and.right.equalTo(backView).with.offset(0);
    }];

}

- (void)setUpUIWithUserInfoFrame:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:backView];
    
    UIImageView *headerImage = [[UIImageView alloc] init];
    [headerImage setImage:[UIImage imageNamed:@"first_normal"]];
    [backView addSubview:headerImage];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = @"name";
    nameLab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:nameLab];
    
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).with.offset(40);
        make.centerX.equalTo(backView.mas_centerX);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImage.mas_bottom).with.offset(0);
        make.left.and.right.equalTo(backView).with.offset(0);
    }];
}

@end
