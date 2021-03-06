import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../api/stories.dart';

class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings);
    schedule();
  }

  void schedule() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('repeating channel id', 'repeating channel name', 'repeating description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 
    (await new StoriesAPI().getData(null, null, null, 1)).elementAt(0).title,
    'repeating body', 
    RepeatInterval.EveryMinute, platformChannelSpecifics);
  }
  
  showNotification(String message) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High,importance: Importance.Max
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, 'HiLite News', message, platform);
  }
}