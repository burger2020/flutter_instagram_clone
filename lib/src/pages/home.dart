import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/avatar_widget.dart';
import 'package:flutter_instagram_clone/src/components/post_widget_.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';

import '../components/image_data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageData(IconsPath.logo, width: 260),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(IconsPath.directMessage, width: 50),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _storyBoardList(),
          _postList()
        ],
      ),
    );
  }

  Widget _storyBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(width: 20),
        _myStory(),
        const SizedBox(width: 5),
        ...List.generate(
          3,
          (index) => Container(
            child: const AvatarWidget(
              thumbPath: 'https://t1.daumcdn.net/cfile/tistory/2438573358070C1535',
              type: AvatarType.type1,
            ),
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
        ),
      ]),
    );
  }

  Widget _myStory() {
    return Stack(
      children: [
        const AvatarWidget(
          thumbPath: "https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg",
          type: AvatarType.type2,
          size: 70,
        ),
        Positioned(
          right: 5.0,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.blue, border: Border.all(color: Colors.white, width: 2)),
            child: const Center(
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _postList() {
    return Column(
      children: List.generate(50, (index) => const PostWidget()),
    );
  }
}
