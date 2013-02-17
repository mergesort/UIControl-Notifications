UIControl-Notifications
=======================

Make your UIControls respond to notifications and blocks instead of the old fashioned target+selector approach

The blocks portion of the code is based off of the work found here:
http://ioscodesnippet.com/post/22440533385/adding-block-support-for-uicontrols-target-action

The QT framework approaches the UI by decoupling the action and the response. They use signals and slots, in accomplishing this. A class emits a signal, and any slot that is waiting for the signal responds to it. (You can read more about it here: http://doc.qt.digia.com/4.7-snapshot/signalsandslots.html)

NSNotificationCenter is a great parallel to this, and I figured it would be great to have the Cocoa work in such a way, in a standardized fashion. Using this category, you can in one line have a UIControlEvent post a notification (or take in a block to execute), and have any class that's observing these notifications react accordingly.

<br />
It's as easy as:
    
    [someButton addNotificationNamed:kNotificationName parameters:@{kNotificationEvent_key : kNotificationEvent_value} forControlEvents:UIControlEventTouchUpInside];

And now you have it emitting a notification for anyone to observe.

You can also use:

    [someButton addBlock:^(id sender, UIEvent *event) {
        NSLog(@"I've been tapped");
    } forControlEvent:UIControlEventTouchUpInside];
If you want to use blocks instead of notifications.