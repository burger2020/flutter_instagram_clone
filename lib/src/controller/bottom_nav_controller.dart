import 'dart:io';

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

  void changeBottomNave(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.upload:
        Get.to(const Upload(), binding: BindingsBuilder(() {
          Get.put(UploadController());
        }));
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
