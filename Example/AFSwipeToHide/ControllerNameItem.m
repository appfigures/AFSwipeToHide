//
//  ControllerNameItem.m
//  AFSwipeToHide
//
//  Created by dw_iOS iOS软件工程师 曾宪华 QQ：543413507 on 14-11-18.
//  Copyright (c) 2014年 Oz. All rights reserved.
//

#import "ControllerNameItem.h"

@implementation ControllerNameItem

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

+ (NSArray *)newDataSource {
    NSMutableArray *newDataSource = [[NSMutableArray alloc] init];
    
    ControllerNameItem *item = [[ControllerNameItem alloc] initWithTitle:@"No Navigation Bar"];
    [newDataSource addObject:item];
    
    item = [[ControllerNameItem alloc] initWithTitle:@"Has Navigation Bar"];
    item.hasNavigationBar = YES;
    [newDataSource addObject:item];
    
    return newDataSource;
}

@end
