import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/image_data.dart';
import 'package:flutter_instagram_clone/src/controller/bottom_nav_controller.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';
import 'package:get/get.dart';

class SearchDetail extends StatefulWidget {
  const SearchDetail({Key? key}) : super(key: key);

  @override
  State<SearchDetail> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  var tabList = ['인기', '계정', '오디오', '장소', '태그'];

  List<Widget> _tabItems() {
    return List.generate(
        tabList.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
              child: Text(tabList[index], style: const TextStyle(fontSize: 15, color: Colors.black)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _appBarLeading(),
        elevation: 0,
        titleSpacing: 0,
        title: _appBarTitle(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
            padding: const EdgeInsets.symmetric(horizontal: 0),
            width: Size.infinite.width,
            height: AppBar().preferredSize.height,
            child: TabBar(
              indicatorColor: Colors.black,
              controller: tabController,
              labelPadding: const EdgeInsets.all(0),
              tabs: _tabItems(),
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  /// 앱바 리딩
  Widget _appBarLeading() {
    return GestureDetector(
        onTap: () => BottomNavController.of.willPopAction,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ImageData(IconsPath.backBtnIcon),
        ));
  }

  /// 앱바 검색창
  Widget _appBarTitle() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: const Color(0xffe3e3e3)),
        child: const TextField(
          style: TextStyle(fontSize: 15),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "검색",
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              isDense: true),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      child: TabBarView(controller: tabController, children: const [
        Center(child: Text("1")),
        Center(child: Text("2")),
        Center(child: Text("3")),
        Center(child: Text("4")),
        Center(child: Text("5"))
      ]),
    );
  }
}
