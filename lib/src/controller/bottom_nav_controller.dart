import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/message_pop_up.dart';
import 'package:get/get.dart';

import '../pages/upload.dart';

enum PageName { home, search, upload, activity, myPage }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  GlobalKey<NavigatorState> searchPageNavigatorKey = GlobalKey<NavigatorState>();
  List<int> bottomHistory = [0];

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
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopUp(
                title: "title",
                message: "message",
                successCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
              ));
      return true;
    } else {
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.search) {
        var value = await searchPageNavigatorKey.currentState!.maybePop();
        if (value) {
          return false;
        } else {}
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNave(index, hasGesture: false);
      print(bottomHistory);
      return false;
    }
  }
}
