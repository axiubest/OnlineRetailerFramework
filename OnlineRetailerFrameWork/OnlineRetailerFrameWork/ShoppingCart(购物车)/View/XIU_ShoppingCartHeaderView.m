//
//  XIU_ShoppingCartHeaderView.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_ShoppingCartHeaderView.h"

@interface XIU_ShoppingCartHeaderView ()

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *button;
@end
@implementation XIU_ShoppingCartHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.button = button;
    
    UILabel *label = [[UILabel alloc]init];

    label.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label];
    self.titleLabel = label;
    
    
    UILabel *edit = [[UILabel alloc] init];
    edit.tag = 888;
    edit.font = [UIFont systemFontOfSize:11];
    [edit bk_whenTapped:^{
        
    }];
    edit.text = @"编辑";
    [self addSubview:edit];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    
    
    UILabel *ticket = [[UILabel alloc] init];
    [ticket bk_whenTapped:^{
        
    }];
    ticket.font = edit.font;
    ticket.text = @"领券";
    ticket.backgroundColor = edit.backgroundColor;
    [self addSubview:ticket];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(button.mas_right).with.offset(8);
        
    }];
    
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(edit.mas_left).with.offset(-10);
        make.top.mas_equalTo(6);
        make.bottom.mas_equalTo(-6);
        make.width.mas_equalTo(1);
    }];

    [ticket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line.mas_right).with.offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];

}
- (void)buttonClick:(UIButton*)button {
    button.selected = !button.selected;
    
    if (self.ClickBlock) {
        self.ClickBlock(button.selected);
    }
}

- (void)setSelect:(BOOL)select {
    
    self.button.selected = select;
    _select = select;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}

@end
