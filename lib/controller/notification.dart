import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notificaions = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificaionDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channel Id', 'channel Name',
            channelDescription: 'channel description',
            importance: Importance.max,
            playSound: true,
            priority: Priority.high));
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(
      android: android,
    );
    await _notificaions.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });
  }

  static Future showNotificaion({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notificaions.show(id, title, body, await _notificaionDetails(),
          payload: payload);
}
