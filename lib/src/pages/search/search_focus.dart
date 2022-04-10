import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/image_data.dart';
import 'package:flutter_instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';
import 'package:get/get.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.backBtnIcon),
            ),
            onTap: () => Get.find<BottomNavController>().willPopAction(),
          ),
          titleSpacing: 0,
          title: Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xffefefef)),
            child: const TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '검색',
                  contentPadding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  isDense: true),
            ),
          ),
          bottom: _menu(),
        ),
        body: _body());
  }

  final List<String> tabList = ['인기', '계정', '오디오', '장소', '태그'];

  List<Widget> _tabMenu() => List.generate(
      tabList.length,
      (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(tabList[index], style: const TextStyle(fontSize: 15, color: Colors.black))));

  PreferredSizeWidget _menu() => PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Container(
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
          height: AppBar().preferredSize.height,
          width: Size.infinite.width,
          child: TabBar(indicatorColor: Colors.black, controller: tabController, tabs: _tabMenu()),
        ),
      );

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text("인기")),
        Center(child: Text("계정")),
        Center(child: Text("오디오")),
        Center(child: Text("태그")),
        Center(child: Text("장소"))
      ],
    );
  }
}
