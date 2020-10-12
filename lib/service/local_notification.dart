import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  LocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings("app_icon");

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    Future setDailyNotification(
        int hour, int minute, int id, String title, String body) async {
      var time = Time(hour, minute, 0);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'repeatDailyAtTime channel id',
          'repeatDailyAtTime channel name',
          'repeatDailyAtTime description');

      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          id, title, body, time, platformChannelSpecifics);
    }
  }
}
