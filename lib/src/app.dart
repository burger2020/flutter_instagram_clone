import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/image_data.dart';
import 'package:flutter_instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';
import 'package:get/get.dart';

import 'pages/home.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => controller.willPopAction(),
        child: Obx(
          () => Scaffold(
            backgroundColor: Colors.red,
            body: IndexedStack(
              index: controller.pageIndex.value,
              children: [
                Container(child: const Home()),
                Container(child: Center(child: Text("search"))),
                Container(child: Center(child: Text("upload"))),
                Container(child: Center(child: Text("activity"))),
                Container(child: Center(child: Text("my page")))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: controller.pageIndex.value,
              elevation: 0,
              onTap: controller.changeBottomNave,
              items: [
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.homeOff),
                  activeIcon: ImageData(IconsPath.homeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.searchOff),
                  activeIcon: ImageData(IconsPath.searchOn),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.uploadIcon),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: ImageData(IconsPath.activeOff),
                  activeIcon: ImageData(IconsPath.activeOn),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey)),
                    label: 'home'),
              ],
            ),
          ),
        ));
  }
}
