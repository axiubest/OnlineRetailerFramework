//
//  XIU_MyCenterTitleValueMoreCell.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/16.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_TitleValueMore @"XIU_MyCenterTitleValueMoreCell"

@interface XIU_MyCenterTitleValueMoreCell : UITableViewCell

- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
+ (CGFloat)cellHeight;

@end
