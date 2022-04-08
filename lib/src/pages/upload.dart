import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/src/controller/upload_contoller.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../components/image_data.dart';
import '../imagepath.dart';

class Upload extends GetView<UploadController> {
  const Upload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Get.back,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.closeImage),
            ),
          ),
          titleSpacing: 0,
          title:
              const Text("New Post", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ImageData(IconsPath.nextImage, width: 50),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [_imagePreview(), _header(), _imageSelectList()],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    var size = Get.width;
    return Obx(() => SizedBox(
        width: size,
        height: size,
        child: _photoWidget(controller.selectedImage.value, size.toInt(), builder: (data) {
          return Image.memory(data, fit: BoxFit.cover);
        })));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: Get.context!,
                  // isScrollControlled: true,
                  constraints: BoxConstraints(maxHeight: Get.height - MediaQuery.of(Get.context!).padding.top),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  builder: (_) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black54),
                              width: 40,
                              height: 4,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                    controller.albums.length,
                                    (index) => GestureDetector(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                            child: Text(controller.albums[index].name),
                                          ),
                                          onTap: () {
                                            controller.changeAlbum(controller.albums[index])
                                          },
                                        )),
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                              ),
                            ),
                          )
                        ],
                      ));
            },
            child: Row(children: [
              Obx(() => Text(controller.headerTitle.value, style: const TextStyle(color: Colors.black, fontSize: 18))),
              const Icon(Icons.arrow_drop_down)
            ]),
          ),
          Row(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xff808080)),
              child: Row(
                children: [
                  ImageData(IconsPath.imageSelectIcon),
                  const SizedBox(width: 8),
                  const Text("여러 항목 선택", style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xff808080)),
              child: ImageData(IconsPath.cameraIcon),
            )
          ])
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(
      () => GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 4, mainAxisSpacing: 1, crossAxisSpacing: 1),
          itemCount: controller.imageList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.changeSelectedImage(controller.imageList[index]);
              },
              child: _photoWidget(controller.imageList[index], 200, builder: (data) {
                return Obx(() => Opacity(
                    opacity: controller.imageList[index] == controller.selectedImage.value ? 0.4 : 1,
                    child: Image.memory(data, fit: BoxFit.cover)));
              }),
            );
          }),
    );
  }

  Widget _photoWidget(AssetEntity? asset, int size, {required Widget Function(Uint8List) builder}) {
    var thumbnail = asset?.thumbnailDataWithSize(ThumbnailSize(size, size));
    return FutureBuilder(
        future: thumbnail,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }
}
