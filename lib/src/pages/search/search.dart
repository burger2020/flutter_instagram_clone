import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/pages/search/search_detail.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    setPostSizes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [_appBar(), Expanded(child: _posts())],
    )));
  }

  Widget _appBar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchDetail())),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              padding: const EdgeInsets.all(8),
              height: 40,
              decoration: BoxDecoration(color: const Color(0xffe3e3e3), borderRadius: BorderRadius.circular(6)),
              child: Row(children: const [
                Icon(Icons.search),
                Text(
                  "검색",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ]),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 15.0),
          child: Icon(Icons.location_on),
        )
      ],
    );
  }

  final List<List<int>> postSizeLists = [[], [], []];
  final List<int> listSizes = [0, 0, 0];

  int getListMinValue() {
    var temp = listSizes[0];
    var minPosition = 0;
    for (var i = 0; i < listSizes.length; i++) {
      if (temp > listSizes[i]) {
        temp = listSizes[i];
        minPosition = i;
      }
    }
    return minPosition;
  }

  void setPostSizes() {
    var postSize = 50;

    for (var i = 0; i < postSize; i++) {
      var minPosition = getListMinValue();
      var size = 1;
      if (minPosition != 1) {
        size = Random().nextInt(100) % 3 == 0 ? 2 : 1;
      }
      postSizeLists[minPosition].add(size);
      listSizes[minPosition] += size;
    }
  }

  Widget _posts() {
    return SingleChildScrollView(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              postSizeLists.length,
              (index) => Expanded(
                      child: Column(
                    children: List.generate(
                        postSizeLists[index].length,
                        (jndex) => Container(
                              decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                              height: Get.width / 3 * postSizeLists[index][jndex],
                              child: CachedNetworkImage(
                                  imageUrl:
                                      "https://helpx.adobe.com/content/dam/help/en/photoshop/how-to/compositing/jcr%3Acontent/main-pars/image/compositing_1408x792.jpg",
                                  fit: BoxFit.cover),
                            )),
                  )))),
    );
  }
}
