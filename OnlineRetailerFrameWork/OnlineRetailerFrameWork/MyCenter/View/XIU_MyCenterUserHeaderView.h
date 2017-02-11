//
//  XIU_MyCenterUserHeaderView.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/9.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XIU_MyCenterUserHeaderViewDelegate <NSObject>

@required
- (void)pushToLogin;
- (void)pushToUserInformation;

@end

@interface XIU_MyCenterUserHeaderView : UIView

@property (nonatomic, assign) id<XIU_MyCenterUserHeaderViewDelegate> XIUDelegate;
@end
