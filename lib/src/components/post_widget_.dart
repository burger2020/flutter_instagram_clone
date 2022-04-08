import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/avatar_widget.dart';
import 'package:flutter_instagram_clone/src/components/image_data.dart';
import 'package:flutter_instagram_clone/src/imagepath.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 15),
        _header(),
        const SizedBox(height: 10),
        _image(),
        const SizedBox(height: 10),
        _infoCount(),
        const SizedBox(height: 10),
        _infoDescription(),
        const SizedBox(height: 10),
        _replyTextBtn(),
        const SizedBox(height: 10),
        _dateAgo()
      ],
    );
  }

  /// 프로필 정보
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AvatarWidget(
            thumbPath: "https://www.walkerhillstory.com/wp-content/uploads/2020/09/2-1.jpg",
            type: AvatarType.type3,
            size: 40,
            nickname: "burger",
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageData(
                IconsPath.postMoreIcon,
                width: 30,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 개시물 이미지
  Widget _image() {
    return CachedNetworkImage(
        imageUrl:
            'https://helpx.adobe.com/content/dam/help/en/photoshop/how-to/compositing/jcr%3Acontent/main-pars/image/compositing_1408x792.jpg');
  }

  /// 좋아요, 댓글 등
  Widget _infoCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageData(IconsPath.likeOffIcon, width: 65),
              const SizedBox(width: 15),
              ImageData(IconsPath.replyIcon, width: 60),
              const SizedBox(width: 15),
              ImageData(IconsPath.directMessage, width: 50),
            ],
          ),
          ImageData(IconsPath.bookMarkOffIcon, width: 50)
        ],
      ),
    );
  }

  ///게시물 내용
  Widget _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Text("좋아요 150게", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          ExpandableText('content 1\ncontent 1\ncontent 1', expandText: '더보기 ')
        ],
      ),
    );
  }

  /// 댓글 개수
  Widget _replyTextBtn() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text("댓글 199개 모두 보기", style: TextStyle(color: Color(0xffe3e3e3), fontSize: 14)),
    );
  }

  /// 작성 날짜
  Widget _dateAgo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text("1일 전", style: TextStyle(color: Color(0xffe3e3e3), fontSize: 13)),
    );
  }
}
