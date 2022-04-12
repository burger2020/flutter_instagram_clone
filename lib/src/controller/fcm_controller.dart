import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../pages/upload.dart';

class FcmController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  var fcmToken = ''.obs;
  var isRequestPermission = false.obs;
  late NotificationSettings settings;
  var messages = <RemoteMessage>[].obs;

  @override
  void onInit() {
    super.onInit();
    initFcm();
  }

  Future checkPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.getNotificationSettings();
    settings.authorizationStatus;
    print('settings = $settings');
  }

  Future requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    this.settings = settings;
    isRequestPermission(true);
    print('settings = $settings');
  }

  Future<void> initFcm() async {
    var channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) {
      if (payload != null) {
        Get.to(const Upload(), arguments: payload);
      }
    });

    // flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
    // ?.createNotificationChannel(channel);

    // fcmToken.value = await _messaging.getToken(
    //         vapidKey: "BIhke2ggQ2CIRV5ykzSwXenuNWGZ_o8hB-dWAXvLeCdHG4AcniFsiQ8A_8DyfIlxwVy5jJOSjAmWEzyPyThSEPI") ??
    //     '';
    // print('fcmToken.value = ${fcmToken.value}');
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('메세지 오픈 앱 : ${event.notification!.title}');
    });
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print('메세지 오픈 앱 2: ${value?.notification?.title ?? 'asd'}');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('foreground Message data: ${message.data}');

      if (message.notification != null) {
        messages.add(message);
        print('Message also contained a notification: ${message.notification}');
        flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const IOSNotificationDetails(
                  badgeNumber: 1,
                  subtitle: 'the subtitle',
                  sound: 'slow_spring_board.aiff',
                )));
      }
    });
  }

  void selectNotification(String? payload) async {
    print('notification payload11: $payload');
    if (payload != null) {
      print('notification payload: $payload');
    }
    await Get.to(const Upload());
  }
}
