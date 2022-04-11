import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/image_data.dart';
import 'package:flutter_instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:flutter_instagram_clone/src/controller/fcm_controller.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';
import 'package:flutter_instagram_clone/src/pages/search/search.dart';
import 'package:get/get.dart';

import 'pages/active_history.dart';
import 'pages/fcm_test.dart';
import 'pages/home.dart';
import 'pages/my_page.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => controller.willPopAction(),
        child: Obx(
          () => Stack(
            children: [
              Scaffold(
                body: IndexedStack(
                  index: controller.pageIndex.value,
                  children: [
                    const Home(),
                    Navigator(
                        key: controller.searchPageNavigationKey,
                        onGenerateRoute: (routeSetting) {
                          return MaterialPageRoute(builder: (context) => const Search());
                        }),
                    const Center(),
                    const ActiveHistory(),
                    const MyPage()
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
              SafeArea(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(const FcmTest(), binding: BindingsBuilder(() {
                          Get.put(FcmController());
                        }));
                      },
                      child: const Text("fcm test")))
            ],
          ),
        ));
  }
}
