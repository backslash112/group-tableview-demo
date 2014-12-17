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
    UserInfo *userInfoA = [[UserInfo alloc] initWith:@"Carl_A"];
    UserInfo *userInfoB = [[UserInfo alloc] initWith:@"B_Carl_B"];
    UserInfo *userInfoC = [[UserInfo alloc] initWith:@"C_Carl_A"];
    UserInfo *userInfoD = [[UserInfo alloc] initWith:@"D_Carl_A"];
    UserInfo *userInfoE = [[UserInfo alloc] initWith:@"Carl_E"];
    UserInfo *userInfoF = [[UserInfo alloc] initWith:@"Carl_F"];
    UserInfo *userInfoG = [[UserInfo alloc] initWith:@"G_Carl_A"];
    dataArray = [NSMutableArray arrayWithObjects:userInfoA, userInfoB, userInfoC, userInfoD, userInfoE, userInfoF, userInfoG, nil];
    
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
        //[_titleArray addObject:@"#"];
        [_groupDictionary setObject:specialArray forKey:@"#"];
    }
   // [specialArray release];
}

@end
