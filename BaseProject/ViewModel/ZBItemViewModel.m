//
//  ZBItemViewModel.m
//  BaseProject
//
//  Created by apple-jd26 on 15/11/16.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "ZBItemViewModel.h"

@implementation ZBItemViewModel

- (id)initWithTag:(NSString *)tag{
    if (self = [super init]) {
        self.tag = tag;
    }
    return self;
}

- (NSInteger)rowNumber{
    return self.dataArr.count;
}

- (void)getDataFromNetCompleteHandle:(CompletionHandle)completionHandle{
    self.dataTask = [MoreNetManager getZBItemListWithTag:_tag completionHandle:^(id model, NSError *error) {
        if (!error) {
            self.dataArr = model;
        }
        completionHandle(error);
    }];
}

- (ZBItemModel *)modelForRow:(NSInteger)row{
    return self.dataArr[row];
}



- (NSString *)itemNameForRow:(NSInteger)row{
    return [self modelForRow:row].text;
}

- (NSInteger)itemIdForRow:(NSInteger)row{
    return [self modelForRow:row].ID;
}

- (NSURL *)iconURLForRow:(NSInteger)row{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://img.lolbox.duowan.com/zb/%ld_64x64.png",[self modelForRow:row].ID]];
}

@end
