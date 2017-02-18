//
//  XIU_User.m
//  BASEPRODUCT
//
//  Created by XIUDeveloper on 2017/1/12.
//  Copyright © 2017年 杨岫峰. All rights reserved.
//

#import "XIU_User.h"

@implementation XIU_User


//*userName, *userImage, *userPass, *userPhone, *userEmail, *userSex, *userBirth, *userIntru, *channelId, *hobby;

-(id)copyWithZone:(NSZone*)zone {
    XIU_User *user = [[[self class] allocWithZone:zone] init];
    user.userId = [_userId copy];
    user.userName = [_userName copy];
    user.userImage = [_userImage copy];
    user.userPass = [_userPass copy];
    user.userWeight = [_userWeight copy];
    user.userHeigh = [_userHeigh copy];
    user.bmi = [_bmi copy];
    user.project = [_project copy];
    user.userPhone = [_userPhone copy];
    user.userSex = [_userSex copy];
    user.userEmail = [_userEmail copy];
    user.userBirth = [_userBirth copy];
    user.userIntru = [_userIntru copy];
    user.channelId = [_channelId copy];
    user.hobby = [_hobby copy];
    user.userMark = [_userMark copy];

    return user;
}


//choose XIU_User safe;
- (NSString *)description {
    return @"0x0";
}

- (NSString *)company{
    if (_userIntru && _userIntru.length > 0) {
        return _userIntru;
    }else{
        return @"未填写";
    }
}

- (NSString *)job_str{
    if (_hobby && _hobby.length > 0) {
        return _hobby;
    }else{
        return @"未填写";
    }
}
- (NSString *)location{
    if (_userName && _userName.length > 0) {
        return _userName;
    }else{
        return @"未填写";
    }
}


@end
