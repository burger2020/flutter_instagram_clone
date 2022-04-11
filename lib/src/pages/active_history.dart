import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("활동", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView('오늘'),
            _newRecentlyActiveView('이번주'),
            _newRecentlyActiveView('이번달'),
          ],
        ),
      ),
    );
  }

  Widget _newRecentlyActiveView(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 15),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
        ],
      ),
    );
  }

  Widget _activeItemOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: const [
          AvatarWidget(
              thumbPath: "https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg",
              type: AvatarType.type2,
              size: 40),
          SizedBox(width: 10),
          Expanded(
              child: Text.rich(TextSpan(
            text: '버거님',
            style: TextStyle(fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: '이 회원님의 게시물을 좋아합니다.', style: TextStyle(fontWeight: FontWeight.normal)),
              TextSpan(
                  text: ' 5일 전', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black54))
            ],
          )))
        ],
      ),
    );
  }
}
