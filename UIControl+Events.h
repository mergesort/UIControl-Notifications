//
//  UIControl+Events.h
//  UIControlTest
//
//  Created by Joseph Fabisevich on 2/16/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIControlEventHandler)(id sender, UIEvent *event);

@interface UIControl (Events)

/*
 Add a block to execute for a set of UIControlEvents
 */
- (void)addBlock:(UIControlEventHandler)handler forControlEvents:(UIControlEvents)controlEvent;

/*
 Remove a block to execute for a set of UIControlEvents
 */
- (void)removeBlocksForControlEvent:(UIControlEvents)controlEvent;


/*
 Add a notification name to fire for a set of UIControlEvents
 */
- (void)addNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents;

/*
 Add a notification to fire for a set of UIControlEvents, and a dictionary to pass along with that notification
 */
- (void)addNotificationNamed:(NSString *)notification parameters:(NSDictionary *)parameters forControlEvents:(UIControlEvents)controlEvents;

/*
 Remove a notification name to fire for a set of UIControlEvents
 */
- (void)removeNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents;

@end
