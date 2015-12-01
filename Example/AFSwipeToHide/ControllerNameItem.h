//
//  ControllerNameItem.h
//  AFSwipeToHide
//
//  Created by dw_iOS iOS软件工程师 曾宪华 QQ：543413507 on 14-11-18.
//  Copyright (c) 2014年 Oz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllerNameItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *className;

// Default is no
@property (nonatomic, assign) BOOL hasNavigationBar;

- (instancetype)initWithTitle:(NSString *)title;

+ (NSArray *)newDataSource;

@end
