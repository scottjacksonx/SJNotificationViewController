# SJNotificationViewController #

SJNotificationViewController lets you put dead-simple notifications that slide up from the bottom or down from the top of a view into your iOS apps.

All you need to do is create a notification, give it a view to slide up from, and tell it to show itself. Like this:

	// Assume your view controller has an SJNotificationViewController* ivar called _notificationController.
	_notificationController = [[SJNotificationViewController alloc] initWithNibName:@"SJNotificationViewController" bundle:nil];
	[_notificationController setParentView:aView];
	[_notificationController setNotificationTitle:@"Hello"];
	[_notificationController show];
	
Or with the convinience constructor:
	
	SJNotificationViewController* n = [[SJNotificationViewController alloc] initWithParentView:aView title:@"Hello" 
		level:SJNotificationLevelMessage position:SJNotificationPositionBottom spinner:NO];
	[n show];
	
![](http://www.judoburrito.com/SJNotificationViewController/notification.png)
	
That gives you a basic notification that slides up from the bottom of `aView`. When you want your notification to slide back down, you just call `[notificationController hide]`. Pretty simple, right?

You can customise a few things about SJNotificationViewController:
    
## Notification Levels ##

SJNotificationViewController has a property called `notificationLevel` that changes the notification's background colour. A notification's `notificationLevel` is one of `SJNotificationLevelError` (red -- for error notifications), `SJNotificationLevelMessage` (blue -- for regular notifications), or `SJNotificationLevelSuccess` (green -- for success notifications). The exact RGB values for the notification levels aren't set in stone yet. Right now, they're extremely red, extremely blue, and extremely green.

![](http://www.judoburrito.com/SJNotificationViewController/error.png)

![](http://www.judoburrito.com/SJNotificationViewController/message.png)

![](http://www.judoburrito.com/SJNotificationViewController/success.png)

## Notification Position ##

There is also a property called `notificationPosition` to control whether your notification should appear at the top or at the bottom of its parent view. Set it to `SJNotificationPositionTop` or `SJNotificationPositionBottom` (default) accordingly.

    [notificationController setNotificationPosition:SJNotificationPositionTop];

## Tapping on a Notification ##

By default, tapping on a notification just hides it, but you can define your own target/selector pair to be called when the notification is tapped with `[notificationController setTapTarget:self action:@selector(doSomething)]`.

## Showing notification for x seconds ##

Calling the showFor method will show the notification for a number of seconds.

	[notificationController showFor:2];

## Spinner ##

By default, a notification doesn't have a spinner, but you can give it one by calling `[notificationController setShowSpinner:YES]`. Doing so will shrink the notification's label to fit the spinner.

![](http://www.judoburrito.com/SJNotificationViewController/spinner.png)

## More In-Depth Customisations ##

If you want to get into the .m file, you can change the colours that correspond to the different notification levels, the durations of the various animations, and the opacity of the notification's background.

