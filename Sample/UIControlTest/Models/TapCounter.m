//
//  SampleData.m
//  UIControlTest
//
//  Created by Joseph Fabisevich on 2/17/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import "TapCounter.h"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros

#define kNotificationName @"someButtonTapped"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface TapCounter ()

@property int taps;

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation TapCounter

- (id)init
{
    if (self = [super init])
    {
        _taps = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incrementTapCount:) name:kNotificationName object:nil];
    }
    
    return self;
}

- (void)incrementTapCount: (NSNotification *)note
{
    _taps++;
    NSLog(@"Taps: %i", _taps);
}

@end
