import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[].obs;
  RxString headerTitle = "".obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = AssetEntity(typeInt: AssetType.image.index, id: '', width: 0, height: 0).obs;

  @override
  void onInit() {
    super.onInit();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      var list = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
            imageOption: const FilterOption(sizeConstraint: SizeConstraint(minWidth: 100, minHeight: 100)),
            orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)]),
      );
      albums.addAll(list);
      _loadData();
    } else {}
  }

  void _loadData() async {
    changeAlbum(albums.first);
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(photos.first);
  }

  void changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) {
    headerTitle(album.name);
    _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    // var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    // image = imageLib.copyResize(image, width: 600);
    // Map imagefile = await Navigator.push(
    //   context,
    //   new MaterialPageRoute(
    //     builder: (context) => new PhotoFilterSelector(
    //       title: Text("Photo Filter Example"),
    //       image: image,
    //       filters: presetFiltersList,
    //       filename: fileName,
    //       loader: Center(child: CircularProgressIndicator()),
    //       fit: BoxFit.contain,
    //     ),
    //   ),
    // );
    // if (imagefile != null && imagefile.containsKey('image_filtered')) {
    //   setState(() {
    //     imageFile = imagefile['image_filtered'];
    //   });
    //   print(imageFile.path);
    // }
  }
}
