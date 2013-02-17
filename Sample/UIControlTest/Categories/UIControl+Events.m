//
//  UIControl+Input.m
//  UIControlTest
//
//  Created by Joseph Fabisevich on 2/16/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import "UIControl+Events.h"
#import <objc/runtime.h>


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros

#define kNotificationName @"notificationName"
#define kNotificationInfo @"notificationDictionary"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIControlEventWrapper

@interface UIControlEventWrapper : NSObject

@property (nonatomic, assign) UIControlEvents controlEvent;
@property (nonatomic, copy) UIControlEventHandler handler;

@end

@implementation UIControlEventWrapper

- (void)sender:(id)sender forEvent:(UIEvent *)event
{
    if (self.handler)
    {
        self.handler(sender, event);
    }
}

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIControl

@implementation UIControl (Input)

static char *eventWrapperKey;


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Setup

- (NSMutableArray *)eventWrappers
{
    NSMutableArray *wrappers = objc_getAssociatedObject(self, &eventWrapperKey);
    if (!wrappers)
    {
        wrappers = [NSMutableArray array];
        objc_setAssociatedObject(self, &eventWrapperKey, wrappers, OBJC_ASSOCIATION_RETAIN);
    }
    
    return wrappers;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public methods

- (void)addBlock:(UIControlEventHandler)handler forControlEvent:(UIControlEvents)controlEvent
{
    UIControlEventWrapper *wrapper = [[UIControlEventWrapper alloc] init];
    wrapper.controlEvent = controlEvent;
    wrapper.handler = handler;
    
    [self addTarget:wrapper action:@selector(sender:forEvent:) forControlEvents:controlEvent];
    [[self eventWrappers] addObject:wrapper];
}

- (void)removeBlocksForControlEvent:(UIControlEvents)controlEvent
{
    __block __weak UIControl *weakSelf = self;
    [[self eventWrappers] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIControlEventWrapper *wrapper = obj;
        if (wrapper.controlEvent == controlEvent)
        {
            [weakSelf removeTarget:wrapper action:NULL forControlEvents:controlEvent];
        }
    }];
}

- (void)addNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents
{
    [self addNotificationNamed:notification parameters:@{} forControlEvents:controlEvents];
}

- (void)addNotificationNamed:(NSString *)notification parameters:(NSDictionary *)parameters forControlEvents:(UIControlEvents)controlEvents
{
    NSDictionary *payload = @{ kNotificationName : notification,
                               kNotificationInfo : parameters };
    
    [self addBlock:^(id sender, UIEvent *event) {
        [sender performSelector:@selector(postControlEvent:) withObject:payload];
    } forControlEvent:controlEvents];
}

- (void)removeNotificationNamed:(NSString *)notification forControlEvents:(UIControlEvents)controlEvents
{
    [self removeBlocksForControlEvent:controlEvents];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

- (void)postControlEvent:(NSDictionary *)notification
{
    NSString *name = [notification objectForKey:kNotificationName];
    NSDictionary *info = [notification objectForKey:kNotificationInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info];
}

@end
