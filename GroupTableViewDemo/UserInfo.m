//
//  UserInfo.m
//  GroupTableViewDemo
//
//  Created by YangCun on 14/12/17.
//  Copyright (c) 2014年 backslash112. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(instancetype)initWith:(NSString *)theNickname
{
    self = [super init];
    if (self) {
        self.nickname = theNickname;
    }
    return self;
}
@end
