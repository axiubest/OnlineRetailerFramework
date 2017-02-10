//
//  XIU_User.h
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XIU_User : NSObject




@property (readwrite, nonatomic, strong)NSString *userName, *userImage, *userPass, *userPhone, *userEmail, *userSex, *userBirth, *userIntru, *channelId, *hobby;

@property (readwrite, nonatomic, strong)NSNumber *userId, *userWeight, *userHeigh, *bmi, *project, *userMark;


@end
