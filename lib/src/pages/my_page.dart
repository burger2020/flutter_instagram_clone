import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/avatar_widget.dart';
import 'package:flutter_instagram_clone/src/components/user_card.dart';

import '../components/image_data.dart';
import '../imagepath.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("dddccc123cc", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
        elevation: 0,
        actions: [
          GestureDetector(
            child: ImageData(IconsPath.uploadIcon, width: 50),
            onTap: () {},
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.menuIcon, width: 50),
            ),
            onTap: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [_information(), _menu(), _discoverPeople(), const SizedBox(height: 20), _tabMenu(), _tabView()],
        ),
      ),
    );
  }

  Widget _information() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AvatarWidget(
                  thumbPath: "https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg",
                  type: AvatarType.type3,
                  size: 80),
              const SizedBox(width: 5),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _staticsOne('Post', 15)),
                    Expanded(child: _staticsOne('Followers', 15)),
                    Expanded(child: _staticsOne('Following', 15)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Text("버거입니다.", style: TextStyle(fontSize: 13, color: Colors.black))
        ],
      ),
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: const Color(0xffdedede)),
                  ),
                  child: const Text(
                    "Edit profile",
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ))),
          const SizedBox(width: 8),
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xffefefef)),
                color: const Color(0xffefefef),
              ),
              child: ImageData(IconsPath.addFriend))
        ],
      ),
    );
  }

  Widget _staticsOne(String title, int value) {
    return Column(
      children: [
        Text(value.toString(), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 15, color: Colors.black))
      ],
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
            Text("Discover People", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
            Text("See All", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.blue))
          ]),
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                children: List.generate(
                    10, (index) => UserCard(title: 'burger$index', description: 'burger$index님이 팔로우합니다.')))),
      ],
    );
  }

  Widget _tabMenu() {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Container(padding: const EdgeInsets.symmetric(vertical: 10), child: ImageData(IconsPath.gridViewOn)),
        Container(padding: const EdgeInsets.symmetric(vertical: 10), child: ImageData(IconsPath.myTagImageOff)),
      ],
    );
  }

  Widget _tabView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1, mainAxisSpacing: 1, crossAxisSpacing: 1),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey,
        );
      },
    );
  }
}
