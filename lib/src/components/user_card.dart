import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/components/avatar_widget.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.title, required this.description}) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 220,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              const AvatarWidget(thumbPath: "", type: AvatarType.type2, size: 80),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              Text(description, style: const TextStyle(fontSize: 13), textAlign: TextAlign.center),
              ElevatedButton(onPressed: () {}, child: const Text("Follow"))
            ],
          ),
        ),
        Positioned(
          child: GestureDetector(
            child: const Icon(Icons.close, size: 14),
            onTap: () {},
          ),
          right: 5,
          top: 5,
        ),
      ]),
    );
  }
}
