import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/controller/fcm_controller.dart';
import 'package:get/get.dart';

class FcmTest extends GetView<FcmController> {
  const FcmTest({Key? key}) : super(key: key);

  static const statusMap = {
    AuthorizationStatus.authorized: 'Authorized',
    AuthorizationStatus.denied: 'Denied',
    AuthorizationStatus.notDetermined: 'Not Determined',
    AuthorizationStatus.provisional: 'Provisional',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("fcmTest")),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text("fcmToken : ${controller.fcmToken}"),
              const SizedBox(height: 10),
              controller.isRequestPermission.value
                  ? Text('Authorization Status = ${statusMap[controller.settings.authorizationStatus]!}')
                  : ElevatedButton(onPressed: () => controller.requestPermission(), child: const Text("권한 요청")),
              ...controller.messages.map((element) {
                return Text('${element.messageId} , ${element.sentTime}');
              })
            ],
          ),
        ),
      ),
    );
  }
}
