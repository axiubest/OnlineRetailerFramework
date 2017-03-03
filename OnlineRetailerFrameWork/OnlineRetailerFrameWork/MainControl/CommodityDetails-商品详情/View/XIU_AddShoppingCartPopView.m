//
//  XIU_AddShoppingCartPopView.m
//  Demo
//
//  Created by XIUDeveloper on 2017/2/7.
//  Copyright © 2017年 XIUDeveloper. All rights reserved.
//

#import "XIU_AddShoppingCartPopView.h"


#define LEFT_MARGIN 10
#define image_bottom_line_padding 10
#define layerLine_width .5
#define surebutton_height 44
@interface XIU_AddShoppingCartPopView ()<UITableViewDelegate, UITableViewDataSource>
{
    
}

@end

@implementation XIU_AddShoppingCartPopView

- (instancetype)initWithFrame:(CGRect)frame WithDataModel:(NSObject*)model {
   self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  =[UIColor whiteColor];
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height - surebutton_height, [UIScreen mainScreen].bounds.size.width, surebutton_height)];

        sureBtn.backgroundColor = [UIColor redColor];
        [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(chcikedSureButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
        
        [self createStaticHeaderView:frame];
  
    }
    return self;
}

- (void)createStaticHeaderView:(CGRect)frame {
    UIImageView *picImage = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, 10, 100, 100)];
    [picImage setImage:[UIImage imageNamed:@"1"]];
    picImage.layer.borderWidth = .5f;
    picImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self setCornerRadius:5.f];
    [self addSubview:picImage];
    
 //line
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(LEFT_MARGIN, picImage.frame.size.height + picImage.frame.origin.y + image_bottom_line_padding, frame.size.width - 2 * LEFT_MARGIN, layerLine_width);
    line.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:line];
    
    //TableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(LEFT_MARGIN, line.frame.origin.y + line.frame.size.height + layerLine_width, frame.size.width - 2 * LEFT_MARGIN, frame.size.height - line.frame.origin.y - line.frame.size.height - layerLine_width - surebutton_height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    
    

}


#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"h"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"h"];
        cell.backgroundColor = [UIColor colorWithRed:arc4random() green:arc4random() blue:arc4random() alpha:.5];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    }
    return cell;
}


- (void)setUpLayerLineWithFrame:(CGRect)frame {
    CALayer *line = [CALayer layer];
    line.frame = frame;
    line.backgroundColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:line];

}
- (void)chcikedSureButton {
    
}
@end
