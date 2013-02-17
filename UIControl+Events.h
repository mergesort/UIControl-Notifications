//
//  UIControl+Input.h
//  UIControlTest
//
//  Created by Joseph Fabisevich on 2/16/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIControlEventHandler)(id sender, UIEvent *event);

@interface UIControl (Input)

- (void)addBlock:(UIControlEventHandler)handler forControlEvent:(UIControlEvents)controlEvent;
- (void)removeBlocksForControlEvent:(UIControlEvents)controlEvent;

- (void)addNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents;
- (void)addNotificationNamed:(NSString *)notification parameters:(NSDictionary *)parameters forControlEvents:(UIControlEvents)controlEvents;

- (void)removeNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents;

@end
