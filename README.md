# SJNotificationViewController #

SJNotificationViewController lets you put dead-simple notifications that slide up from the bottom of a view into your iOS apps.

All you need to do is import the QuartzCore framework, create a notification, give it a view to slide up from, and tell it to show itself. Like this:

	SJNotificationViewController *notificationController = [[SJNotificationViewController alloc] initWithNibName:@"SJNotificationViewController" bundle:nil];
	[notificationController setParentView:aView];
	[notificationController setNotificationTitle:@"Hello"];
	[notificationController show];
	
![](http://files.droplr.com/files_production/acc_1432/WRd4?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1329125061&Signature=9%2FckO%2BTq8hz34CG9hzRShb1ItFA%3D&response-content-disposition=inline%3B+filename%3DScreen+Shot+2012-02-13+at+6.56.46+PM.png)
	
That gives you a basic notification that slides up from the bottom of `aView`. When you want your notification to slide down again, you just call `[notificationController hide]`. Pretty simple, right?

You can customise a few things about SJNotificationViewController:

## Notification Levels ##

SJNotificationViewController has a property called `notificationLevel` that changes the notification's background colour. A notification's `notificationLevel` is one of `SJNotificationLevelError` (red -- for error notifications), `SJNotificationLevelMessage` (blue -- for regular notifications), or `SJNotificationLevelSuccess` (green -- for success notifications). The exact RGB values for the notification levels aren't set in stone yet. Right now, they're extremely red, extremely blue, and extremely green.

![](http://files.droplr.com/files_production/acc_1432/3XL8?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1329125071&Signature=Uwu5%2BwQuTa4p9A%2B11suT6k7aWw8%3D&response-content-disposition=inline%3B+filename%3DScreen+Shot+2012-02-13+at+7.16.45+PM.png)

![](http://files.droplr.com/files_production/acc_1432/RLA?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1329125078&Signature=L9%2BQa9Z2qF2pPwOIIsI9B0ORu3k%3D&response-content-disposition=inline%3B+filename%3DScreen+Shot+2012-02-13+at+7.17.11+PM.png)

![](http://files.droplr.com/files_production/acc_1432/rDGj?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1329125084&Signature=IP%2FLZvzGUx8Ho8SEb8uzoPu%2B8V8%3D&response-content-disposition=inline%3B+filename%3DScreen+Shot+2012-02-13+at+7.17.32+PM.png)

## Tapping on a Notification ##

By default, tapping on a notification just hides it, but you can define your own action/selector pair to be called when the notification is tapped with `[notificationController setTapTarget:self action:@selector(doSomething)]`.

## Spinner ##

By default, a notification doesn't have a spinner, but you can give it one by calling `[notificationController setShowSpinner:YES]`. Doing so will shrink the notification's label to fit the spinner.

![](http://files.droplr.com/files_production/acc_1432/7QVJ?AWSAccessKeyId=AKIAJSVQN3Z4K7MT5U2A&Expires=1329125091&Signature=Tvk9FQzk4IkTkvymNBK68y7KsFw%3D&response-content-disposition=inline%3B+filename%3DScreen+Shot+2012-02-13+at+7.20.04+PM.png)

## More In-Depth Customisations ##

If you want to get into the .m file, you can change the colours that correspond to the different notification levels, the durations of the various animations, and the opacity of the notification's background.
