//
//  XIU_ShoppingCartShopCell.m
//  OnlineRetailerFrameWork
//
//  Created by XIUDeveloper on 2017/2/11.
//  Copyright © 2017年 杨岫峰. All rights reserved.

#import "XIU_ShoppingCartCell.h"


#import "XIU_ShoppingCart_GoodsModel.h"
static NSInteger CartRowHeight = 100;
static NSString *Bottom_UnSelectButtonString = @"cart_unSelect_btn";
static NSString *Bottom_SelectButtonString = @"cart_selected_btn";
static CGFloat SelectButtonSize = 25;


@interface XIU_ShoppingCartCell ()
{
    NumberChangedBlock numberAddBlock;
    NumberChangedBlock numberCutBlock;
    CellSelectedBlock cellSelectedBlock;
}
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *ImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;
//数量
@property (nonatomic,retain)UILabel *numberLabel;

@end

@implementation XIU_ShoppingCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245 green:146 blue:248 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - public method
- (void)reloadDataWithModel:(XIU_ShoppingCart_GoodsModel*)model {
    
    self.ImageView.image = model.image;
    self.nameLabel.text = model.goodsName;
    self.priceLabel.text = model.price;
    self.dateLabel.text = model.price;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.count];
//    self.sizeLabel.text = model.sizeStr;
    self.selectBtn.selected = model.select;
    
}

- (void)numberAddWithBlock:(NumberChangedBlock)block {
    numberAddBlock = block;
}

- (void)numberCutWithBlock:(NumberChangedBlock)block {
    numberCutBlock = block;
}

- (void)cellSelectedWithBlock:(CellSelectedBlock)block {
    cellSelectedBlock = block;
}
#pragma mark - 重写setter方法
- (void)setLzNumber:(NSInteger)lzNumber {
    _lzNumber = lzNumber;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)lzNumber];
}


- (void)setisSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.selectBtn.selected = isSelected;
}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);
    }
}

- (void)addBtnClick:(UIButton*)button {
    
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    
    if (numberAddBlock) {
        numberAddBlock(count);
    }
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count <= 0){
        return ;
    }

    if (numberCutBlock) {
        numberCutBlock(count);
    }
}
-(void)setupMainView {
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 10, KWIDTH - 20, CartRowHeight - 10);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithHexString:@"88888"].CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.center = CGPointMake(20, bgView.height/2.0);
    selectBtn.bounds = CGRectMake(0, 0, 30, 30);
    [selectBtn setImage:[UIImage imageNamed:Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.backgroundColor = [UIColor xiu_666color];
    [bgView addSubview:imageBgView];
    
    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageBgView addSubview:imageView];
    self.ImageView = imageView;
    
    
    //价格
    UILabel* priceLabel = [[UILabel alloc]init];
    priceLabel.font = [UIFont boldSystemFontOfSize:16];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.tag = 888;
    nameLabel.numberOfLines = 0;
    nameLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //尺寸
    UILabel* sizeLabel = [[UILabel alloc]init];
    sizeLabel.textColor = [UIColor lightGrayColor];
    sizeLabel.font = [UIFont systemFontOfSize:12];
    sizeLabel.text = @"颜色分类：灰色；尺码：L";
    [bgView addSubview:sizeLabel];
    self.sizeLabel = sizeLabel;
    
    //时间
    UILabel* dateLabel = [[UILabel alloc]init];
    
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textColor = [UIColor blueColor];
    [bgView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(bgView.width - 35, bgView.height - 35, 25, 25);
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];
    
    //    数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(addBtn.x - 30, addBtn.y, 30, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    //    数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame = CGRectMake(numberLabel.x - 25, addBtn.y, 25, 25);
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cutBtn];
    
    
    
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView).with.offset(10);
        make.size.mas_offset(CGSizeMake(SelectButtonSize, SelectButtonSize));
    }];
    
    [imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectBtn.mas_right).with.offset(10);
        make.centerY.equalTo(bgView.mas_centerY);
        make.size.mas_offset(CGSizeMake(bgView.height - 8, bgView.height - 8));
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.bottom.and.right.equalTo(imageBgView).with.insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageBgView.mas_top);
        make.left.equalTo(imageBgView.mas_right).with.offset(10);
        make.right.equalTo(bgView).with.offset(10);
        make.height.offset(30);
    }];
    
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(3);
        make.left.equalTo(nameLabel.mas_left);
        make.right.equalTo(nameLabel.mas_right);
        make.height.offset(12);
    }];
    
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sizeLabel.mas_bottom).with.offset(3);
        make.left.equalTo(nameLabel.mas_left);
        make.right.equalTo(nameLabel.mas_right);
        make.height.offset(12);
        
    }];
}

@end
