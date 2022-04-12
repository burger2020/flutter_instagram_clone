import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/message_pop_up.dart';
import 'package:flutter_instagram_clone/src/controller/upload_contoller.dart';
import 'package:get/get.dart';

import '../pages/upload.dart';

enum PageName { home, search, upload, activity, myPage }

class BottomNavController extends GetxController {
  static BottomNavController get of => Get.find();
  GlobalKey<NavigatorState> searchPageNavigationKey = GlobalKey<NavigatorState>();

  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  @override
  void onInit() {
    super.onInit();
    setupInteractedMessage();
  }

  Future<void> setupInteractedMessage() async {
    // 앱이 종료된 상태에서 푸시 알림 클릭하여 열릴 경우 메세지 가져옴
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // 종료상태에서 클릭한 푸시 알림 메세지 핸들링
    if (initialMessage != null) _handleMessage(initialMessage);

    // 앱이 백그라운드 상태에서 푸시 알림 클릭 하여 열릴 경우 메세지 스트림을 통해 처리
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print('message = ${message.notification!.title}');
    if (message.data['type'] == 'chat') {
      Get.toNamed('/chat', arguments: message.data);
    }
  }


  void changeBottomNave(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.upload:
        Get.to(const Upload());
        break;
      case PageName.home:
      case PageName.search:
      case PageName.activity:
      case PageName.myPage:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    if (bottomHistory.contains(value) && value != 0) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      print("exit");
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopUp(
              title: "title",
              message: "message",
              successCallback: () {
                exit(0);
              },
              cancelCallback: Get.back));
      return true;
    } else {
      /// 현재 검색 탭이고 검색 내비게이션에 팝시도(검색 화면 닫기) 후 팝할게 있었으면 바탐내비게이션 이동 하지 않음
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.search) {
        var value = await searchPageNavigationKey.currentState!.maybePop();
        if (value) return false;
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNave(index, hasGesture: false);
      return false;
    }
  }
}
