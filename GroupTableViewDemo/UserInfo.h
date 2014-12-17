//
//  UserInfo.h
//  GroupTableViewDemo
//
//  Created by YangCun on 14/12/17.
//  Copyright (c) 2014年 backslash112. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *pinyin;

- (instancetype)initWith:(NSString*)nickname;
@end
