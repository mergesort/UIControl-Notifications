//
//  ViewController.m
//  UIControlTest
//
//  Created by Joseph Fabisevich on 2/16/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+Events.h"
#import "TapCounter.h"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Macros

#define kNotificationName @"someButtonTapped"
#define kNotificationEvent_key @"kNotificationEvent_key"
#define kNotificationEvent_value @"I was tapped!!"


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

@interface ViewController ()

@property (nonatomic, strong) UIButton *someButton;
@property (nonatomic, strong) TapCounter *counter;

@end


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Implementation

@implementation ViewController


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil  ])
    {
        // Just doing this here to be lazy, so we don't have to create another [non-view] controller
        _counter = [[TapCounter alloc] init];
    }
    
    return self;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    _someButton = [[UIButton alloc] initWithFrame:self.view.frame];
    [_someButton setTitle:@"Tap that :)" forState:UIControlStateNormal];
    [self.view addSubview:_someButton];

//    [_someButton addBlock:^(id sender, UIEvent *event) {
//        NSLog(@"I've been tapped");
//    } forControlEvent:UIControlEventTouchUpInside];

    [_someButton addNotificationNamed:kNotificationName parameters:@{kNotificationEvent_key : kNotificationEvent_value} forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapOccurred:) name:kNotificationName object:nil];
}

- (void)tapOccurred:(NSNotification *)note
{
    // If you only want things outside of this class to react to the notification,
    // just remove this code
    NSString *one = [note.userInfo objectForKey:kNotificationEvent_key];
    NSLog(@"%@", one);
    
    // If you want to remove the notification, it's as simple as this:
    // [someButton removeNotificationNamed:kNotificationName forControlEvents:UIControlEventTouchUpInside];
}

@end
