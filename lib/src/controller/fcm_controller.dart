import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

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
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    fcmToken.value = await _messaging.getToken(
            vapidKey: "BIhke2ggQ2CIRV5ykzSwXenuNWGZ_o8hB-dWAXvLeCdHG4AcniFsiQ8A_8DyfIlxwVy5jJOSjAmWEzyPyThSEPI") ??
        '';
    print('fcmToken.value = ${fcmToken.value}');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

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
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
  }
}
