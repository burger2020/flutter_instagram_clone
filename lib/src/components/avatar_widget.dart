import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarType { type1, type2, type3 }

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    Key? key,
    this.hasStory,
    required this.thumbPath,
    this.nickname,
    required this.type,
    this.size = 65,
  }) : super(key: key);

  final bool? hasStory;
  final String thumbPath;
  final String? nickname;
  final AvatarType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.type1:
        return type1Widget();
      case AvatarType.type2:
        return type2Widget();
      case AvatarType.type3:
        return type3Widget();
    }
  }

  Widget type1Widget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.orange],
          ),
          shape: BoxShape.circle),
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65),
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget type3Widget() {
    return Row(
      children: [
        type1Widget(),
        Text(nickname ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16,),)
      ],
    );
  }
}
