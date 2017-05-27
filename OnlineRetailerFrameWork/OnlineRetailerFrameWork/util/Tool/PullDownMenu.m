//
//  PullDownMenu.m
//  PullDownMenu
//
//  Created by 離去之原 on 18/2/2017.
//  Copyright © 2017年 離去之原. All rights reserved.
//

#import "PullDownMenu.h"
#import <objc/runtime.h>

#define Kscreen_width  [UIScreen mainScreen].bounds.size.width
#define Kscreen_height [UIScreen mainScreen].bounds.size.height
#define KTitleButtonHeight 40

// 格式 0xff3737
#define RGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define KDefaultColor [UIColor whiteColor]

#define kCellBgColor [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:.7]

#define KTableViewCellHeight 40

#define KDisplayMaxCellOfNumber  7

#define KTitleButtonTag 1000

#define KOBJCSetObject(object,value)  objc_setAssociatedObject(object,@"title" , value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

#define KOBJCGetObject(object) objc_getAssociatedObject(object, @"title")

@interface PullDownMenu ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) NSArray *titleArray ;

@property (nonatomic)UITableView *tableView;
@property (nonatomic)NSMutableArray *tableDataArray;

@property (nonatomic) CGFloat selfOriginalHeight ;
@property (nonatomic) CGFloat tableViewMaxHeight ;

@property (nonatomic) NSMutableArray *buttonArray;

@property (nonatomic) UIButton  *maskBackGroundView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *countArray;
@property (assign, nonatomic) BOOL hideView;
@end
static NSString *titleString;
@implementation PullDownMenu

- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.countArray = [NSMutableArray new];
        self.tableViewMaxHeight = KTableViewCellHeight * KDisplayMaxCellOfNumber;
        self.selfOriginalHeight =frame.size.height;
        self.titleArray =titleArray;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.maskBackGroundView];
        [self addSubview:self.tableView];
        [self loadCollectionView];
        [self configBaseInfo];
    }
    return self;
}

-(void)configBaseInfo
{
    
    //    self.backgroundColor=KmaskBackGroundViewColor;
    
    //用于遮盖self.backgroundColor 。
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Kscreen_width, KTitleButtonHeight)];
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];
    CGFloat width = Kscreen_width /self.titleArray.count;
    for (int index=0; index<self.titleArray.count; index++) {
       
     
        UIButton *titleButton=[UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame= CGRectMake((width+0.5) * index, 0, width-0.5, KTitleButtonHeight);
        titleButton.backgroundColor =KDefaultColor;
        [titleButton setTitle:self.titleArray[index] forState:UIControlStateNormal];
        titleButton.tag =KTitleButtonTag + index ;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setImage:[UIImage imageNamed:@"矩形-1"] forState:UIControlStateNormal];
        titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0);
        if (width > KWIDTH/2.5) {
            titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
            titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 150, 0, 0);
        }
        [self addSubview:titleButton];
        if (index>0 && index< _titleArray.count) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake((width+0.5) * index -1, 10, 1, KTitleButtonHeight - 20)];
            line.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
            [self addSubview:line];
        }
        [self.buttonArray addObject:titleButton];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, KTitleButtonHeight - 1, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"e5e5e5"];
    [self addSubview:lineView];
}

- (void)setNormalSelected:(NSString *)title {
    
    titleString = title;
    UIButton *button = (UIButton *)[self viewWithTag:KTitleButtonTag];
    [button setTitle:titleString forState:UIControlStateNormal];
}
- (void)setSecSelected:(NSString *)title {
//    titleString = title;
//    UIButton *button = [(UIButton *)self viewWithTag:KTitleButtonTag + 1];
//    [button setTitle:title forState:UIControlStateNormal];
    [self.tempButton setTitle:titleString forState:UIControlStateNormal];
//    [button setTitle:titleString forState:UIControlStateNormal];
}


- (void)resetCount:(NSMutableArray *)countArray {
    [self.countArray removeAllObjects];
    self.countArray = countArray;
    
    [self.tableView reloadData];
    
}

-(UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, Kscreen_width, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.tableView.rowHeight= KTableViewCellHeight;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return self.tableView;
}

#pragma mark  --  <代理方法>
#pragma mark  --  <UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    downMenuCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell =[[downMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLabel.text = self.tableDataArray[indexPath.row];
    if (self.countArray.count > 0) {
        if (indexPath.row < _countArray.count) {
        cell.countLabel.text = [NSString stringWithFormat:@"%@",_countArray[indexPath.row]];
        }
    }
    if (_hideView) {
        cell.countLabel.hidden = YES;
    } else {
        cell.countLabel.hidden = NO;
    }
    NSString *objcTitle = KOBJCGetObject(self.tempButton);
    if ([cell.titleLabel.text isEqualToString:objcTitle]) {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected=NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    downMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isSelected = YES;
    
    [self.tempButton setTitle:cell.titleLabel.text forState:UIControlStateNormal];
    
    KOBJCSetObject(self.tempButton, cell.titleLabel.text);
    
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.titleLabel.text,indexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    [self takeBackTableViewWithNum:2];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(105, 30);
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Kscreen_width,0) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //代理设置
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    layout.minimumLineSpacing = 15;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15);
    //注册item类型 这里使用系统的类型
    [_collectionView registerClass:[ButtonCell class] forCellWithReuseIdentifier:@"ccell"];
    [self addSubview:self.collectionView];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _tableDataArray.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ButtonCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"ccell" forIndexPath:indexPath];
    cell.titleLabel.text = _tableDataArray[indexPath.row];
    NSString *objcTitle = KOBJCGetObject(self.tempButton);
    
    if ([cell.titleLabel.text isEqualToString:objcTitle]) {
        cell.isSelected = YES;
    }
    else
    {
        cell.isSelected=NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ButtonCell *cell = (ButtonCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    [self.tempButton setTitle:cell.titleLabel.text forState:UIControlStateNormal];
    
    KOBJCSetObject(self.tempButton, cell.titleLabel.text);
    
    if (self.handleSelectDataBlock) {
        self.handleSelectDataBlock(cell.titleLabel.text,indexPath.row,self.tempButton.tag - KTitleButtonTag);
    }
    [self takeBackTableViewWithNum:1];
}

-(void)setDefauldSelectedCell
{
    for (int index=0; index<self.buttonArray.count; index++) {
        
        self.tableDataArray =self.menuDataArray[index];
        
        UIButton *button =self.buttonArray[index];
        
        NSString *title = self.tableDataArray.firstObject;
        
        KOBJCSetObject(button, title);
        
        [button setTitle:title forState:UIControlStateNormal];
    }
    [self takeBackTableViewWithNum:2];
}
- (UIButton *)maskBackGroundView {
    if (!_maskBackGroundView) {
        _maskBackGroundView= [UIButton buttonWithType:UIButtonTypeCustom];
        _maskBackGroundView.frame = CGRectMake(0, 0, Kscreen_width, Kscreen_height);
        _maskBackGroundView.backgroundColor= [UIColor blackColor];
        _maskBackGroundView.hidden=YES;
        _maskBackGroundView.alpha = 0.3;
        [_maskBackGroundView addTarget:self action:@selector(maskBackGroundViewTapClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskBackGroundView;
}

-(void)titleButtonClick:(UIButton *)titleButton
{

    NSUInteger index =  titleButton.tag - KTitleButtonTag;
    if (index == 0) {
        NSArray *array = _menuDataArray[0];
        if (array.count < 2) {
            return;
        }
    }
   
    for (UIButton *button in self.buttonArray) {
        if (button == titleButton) {
            button.selected=!button.selected;
            self.tempButton =button;
            [self changeButtonObject:button TransformAngle:M_PI];
        }else
        {
            button.selected=NO;
            [self changeButtonObject:button TransformAngle:0];
        }
    }
    if (titleButton.selected) {
        [self changeButtonObject:titleButton TransformAngle:M_PI];
        self.tableDataArray = self.menuDataArray[index];
        //设置默认选中第一项。
//        if ([KOBJCGetObject(self.tempButton) length]<1) {
////            if (titleString) {
////                KOBJCSetObject(self.tempButton, titleString);
////            } else {
//            NSString *title = self.tableDataArray.firstObject;
//            KOBJCSetObject(self.tempButton, title);
////            }
//        } else {
            KOBJCSetObject(self.tempButton, _tempButton.titleLabel.text);
//        }
        if (index == 0) {
                if (titleString) {
                    KOBJCSetObject(self.tempButton, titleString);
                    titleString = nil;
                }
            [self.collectionView reloadData];
            if (_tableView.frame.size.height >0) {
                 self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
            }
            CGFloat tableViewHeight =  (self.tableDataArray.count/3 + 1) * KTableViewCellHeight +20< self.tableViewMaxHeight ?
            (self.tableDataArray.count/3 + 1) * KTableViewCellHeight +20 : self.tableViewMaxHeight;
            [self expandWithTableViewHeight:tableViewHeight Num:1];
            return;
        }
        [self.tableView reloadData];
        if (self.collectionView.frame.size.height >0) {
             self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
        }
        CGFloat tableViewHeight =  self.tableDataArray.count * KTableViewCellHeight < self.tableViewMaxHeight ?
        self.tableDataArray.count * KTableViewCellHeight : self.tableViewMaxHeight;
        [self expandWithTableViewHeight:tableViewHeight Num:2];
    }else
    {
            [self takeBackTableViewWithNum:1];
            [self takeBackTableViewWithNum:2];
    }
    if (index == _hiddenBlock) {
        _hideView = YES;
    } else {
        _hideView = NO;
    }
}

//展开。
-(void)expandWithTableViewHeight:(CGFloat )tableViewHeight Num:(NSInteger)number
{
    self.maskBackGroundView.hidden=NO;
    CGRect rect = self.frame;
    rect.size.height = Kscreen_height - self.frame.origin.y;
    self.frame= rect;
    if (number == 1) {
        [self showSpringAnimationWithDuration:0.3 animations:^{
            if (_tableDataArray.count < 2) {
                   self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, 0, 0);
            } else {
            self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width, tableViewHeight);
            }
        } completion:^{
        }];
    } else {
    [self showSpringAnimationWithDuration:0.3 animations:^{
        
        self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width, tableViewHeight);
    } completion:^{
    }];
}
}
//收起。
-(void)takeBackTableViewWithNum:(NSInteger)number
{
    for (UIButton *button in self.buttonArray) {
        button.selected=NO;
        [self changeButtonObject:button TransformAngle:0];
    }
    CGRect rect = self.frame;
    rect.size.height = self.selfOriginalHeight;
    self.frame = rect;
    if (number == 1) {
        [self showSpringAnimationWithDuration:.3 animations:^{
            
            self.collectionView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
            
        } completion:^{
            self.maskBackGroundView.hidden = YES;
        }];
    } else{
        [self showSpringAnimationWithDuration:.3 animations:^{
            
            self.tableView.frame = CGRectMake(0, self.selfOriginalHeight, Kscreen_width,0);
            
        } completion:^{
            self.maskBackGroundView.hidden = YES;
        }];
    }
}

-(void)changeButtonObject:(UIButton *)button TransformAngle:(CGFloat)angle
{
    [UIView animateWithDuration:0.5 animations:^{
        button.imageView.transform =CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
    }];
    
}
-(void)showSpringAnimationWithDuration:(CGFloat)duration
                            animations:(void (^)())animations
                            completion:(void (^)())completion
{
    
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}



-(void)maskBackGroundViewTapClick
{
    [self takeBackTableViewWithNum:1];
    [self takeBackTableViewWithNum:2];
}


-(NSMutableArray *)menuDataArray
{
    if (_menuDataArray) {
        return _menuDataArray;
    }
    self.menuDataArray =[[NSMutableArray alloc]init];
    
    return self.menuDataArray;
}


-(NSMutableArray *)tableDataArray
{
    if (_tableDataArray) {
        return _tableDataArray;
    }
    self.tableDataArray = [[NSMutableArray alloc]init];
    
    return self.tableDataArray;
}

-(NSMutableArray *)buttonArray
{
    if (_buttonArray) {
        return _buttonArray;
    }
    self.buttonArray =[[NSMutableArray alloc]init];
    
    return self.buttonArray;
}

@end

@implementation downMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.selectImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.countLabel];
    }
    
    return self;
}

-(UIImageView *)selectImageView
{
    if (_selectImageView) {
        return _selectImageView;
    }
    UIImage *image = [UIImage imageNamed:@"gou"];
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image=image;
    self.selectImageView.hidden=YES;
    self.selectImageView.frame = CGRectMake(0,0,14,10);
    
    return self.selectImageView;
}

- (void)layoutSubviews {
    [_selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_selectImageView.mas_right).with.offset(10);
        make.centerY.mas_equalTo(self);
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.centerY.mas_equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = NB_FONT(13);
    }
    return _titleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
        _countLabel.font = NB_FONT(13);
    }
    return _countLabel;
}


- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor =[UIColor colorWithHexString:@"FF8A00"];
        self.countLabel.textColor =[UIColor colorWithHexString:@"FF8A00"];
        self.selectImageView.hidden = NO;
    }else{
        self.titleLabel.textColor = [UIColor colorWithHexString:@"6B6B6B"];
        self.countLabel.textColor = [UIColor colorWithHexString:@"6B6B6B"];
        self.selectImageView.hidden = YES;
    }
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect);
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#E5E5E5"].CGColor); CGContextStrokeRect(context, CGRectMake(15, rect.size.height, rect.size.width , 1));
}
@end
@implementation ButtonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.masksToBounds = YES;
        [self addSubview:self.titleLabel];
            self.layer.borderColor = [UIColor grayColor].CGColor;

    }
    return self;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor =[UIColor colorWithHexString:@"6B6B6B"];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_lessThanOrEqualTo(100);
    }];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"FF8A00"];
        self.layer.borderColor = [UIColor colorWithHexString:@"FF8A00"].CGColor;
    }else
    {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"6B6B6B"];
        self.layer.borderColor =[UIColor colorWithHexString:@"C9C9C9"].CGColor;

    }
}

@end
