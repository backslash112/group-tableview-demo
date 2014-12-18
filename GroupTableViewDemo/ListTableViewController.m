//
//  ListTableViewController.m
//  GroupTableViewDemo
//
//  Created by YangCun on 14/12/17.
//  Copyright (c) 2014年 backslash112. All rights reserved.
//

#import "ListTableViewController.h"
#import "ChineseToPinyin.h"

@implementation ListTableViewController
{
    NSMutableDictionary *_groupDictionary;
    NSMutableArray *_titleArray;
}

- (void)viewDidLoad
{
    UserInfo *userInfoA = [[UserInfo alloc] initWith:@"aCarl_A"];
    UserInfo *userInfoB = [[UserInfo alloc] initWith:@"B_Carl_B"];
    UserInfo *userInfoC = [[UserInfo alloc] initWith:@"C_Carl_A"];
    UserInfo *userInfoD = [[UserInfo alloc] initWith:@"D_Carl_A"];
    UserInfo *userInfoE = [[UserInfo alloc] initWith:@"dCarl_E"];
    UserInfo *userInfoF = [[UserInfo alloc] initWith:@"fCarl_F"];
    UserInfo *userInfoG = [[UserInfo alloc] initWith:@"G_Carl_A"];
    UserInfo *userInfoA1 = [[UserInfo alloc] initWith:@"vCarl_A"];
    UserInfo *userInfoB2 = [[UserInfo alloc] initWith:@"zB_Carl_B"];
    UserInfo *userInfoC3 = [[UserInfo alloc] initWith:@"zC_Carl_A"];
    UserInfo *userInfoD4 = [[UserInfo alloc] initWith:@"iD_Carl_A"];
    UserInfo *userInfoG6 = [[UserInfo alloc] initWith:@"iG_Carl_A"];
    UserInfo *userInfoA7 = [[UserInfo alloc] initWith:@"oCarl_A"];
    UserInfo *userInfoB8 = [[UserInfo alloc] initWith:@"pB_Carl_B"];
    UserInfo *userInfoC9 = [[UserInfo alloc] initWith:@"lC_Carl_A"];
    UserInfo *userInfoD0 = [[UserInfo alloc] initWith:@"kD_Carl_A"];
    UserInfo *userInfoE11 = [[UserInfo alloc] initWith:@"kCarl_E"];
    UserInfo *userInfoF12 = [[UserInfo alloc] initWith:@"eCarl_F"];
    UserInfo *userInfoG13 = [[UserInfo alloc] initWith:@"rG_Carl_A"];
    UserInfo *userInfoA14 = [[UserInfo alloc] initWith:@"wCarl_A"];
    UserInfo *userInfoB15 = [[UserInfo alloc] initWith:@"qB_Carl_B"];
    UserInfo *userInfoC16 = [[UserInfo alloc] initWith:@"tC_Carl_A"];
    UserInfo *userInfoD17 = [[UserInfo alloc] initWith:@"gD_Carl_A"];
    UserInfo *userInfoE18 = [[UserInfo alloc] initWith:@"dCarl_E"];
    UserInfo *userInfoF19 = [[UserInfo alloc] initWith:@"sCarl_F"];
    UserInfo *userInfoG20 = [[UserInfo alloc] initWith:@"_G_Carl_A"];
    dataArray = [NSMutableArray arrayWithObjects:userInfoA, userInfoB, userInfoC, userInfoD, userInfoE, userInfoF, userInfoG, userInfoA1, userInfoB2, userInfoC3, userInfoD4, userInfoG6, userInfoA7, userInfoB8, userInfoC9, userInfoD0, userInfoE11, userInfoF12, userInfoG13, userInfoA14, userInfoB15, userInfoC16, userInfoD17, userInfoE18, userInfoF19, userInfoG20, nil];
    
    [self doGroupWithArray];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *title = [_titleArray objectAtIndex:section];
    NSArray *items = [_groupDictionary objectForKey:title];
    return items.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_titleArray objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //cell.textLabel.text = ((UserInfo*)dataArray[indexPath.row]).nickname;
    
     NSString *title =  [_titleArray objectAtIndex:indexPath.section];
    NSArray *items = [_groupDictionary objectForKey:title];
    
    NSLog(@"%@",@(indexPath.row));
    cell.textLabel.text = ((UserInfo*)items[indexPath.row]).nickname;
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  _titleArray;
}

// group with array(*a-z#)
- (void)doGroupWithArray
{
    if (!_groupDictionary) {
        _groupDictionary = [[NSMutableDictionary alloc]init];
    }
    [_groupDictionary removeAllObjects];
    
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    [_titleArray removeAllObjects];
//    [_titleArray addObject:UITableViewIndexSearch];
    
    //add a-z to group
    NSInteger A = 65;//A
    char word[1];
    NSMutableArray *specialArray = [[NSMutableArray alloc]initWithArray:dataArray];
    for (NSInteger i = 0; i < 26; i++){
        word[0] = (char)(A + i);
        NSString *wordString=[NSString stringWithFormat:@"%c",word[0]];
        NSMutableArray *groupArray = [[NSMutableArray alloc]init];
        for (NSInteger i=0; i<dataArray.count; i++) {
            
            UserInfo *item = [dataArray objectAtIndex:i];
            NSString *name = item.nickname;
            NSString *pinyin = [ChineseToPinyin pinyinFromChineseString:name];
            if (!pinyin || pinyin.length == 0){
                pinyin = @"#";
            }
            item.pinyin = pinyin;
            if (pinyin&&wordString&&pinyin&&[wordString isEqualToString: [pinyin substringToIndex:1]] ) {
                [groupArray addObject:item];
                [specialArray removeObject:item];
            }
            
        }
        if (groupArray.count>0 && wordString) {
            [_titleArray addObject: wordString];
            [_groupDictionary setObject:groupArray forKey:wordString];
        }
        //[groupArray release];
    }
    //add special word to group
    if (specialArray.count>0) {
        [_titleArray addObject:@"#"];
        [_groupDictionary setObject:specialArray forKey:@"#"];
    }
   // [specialArray release];
}

@end
