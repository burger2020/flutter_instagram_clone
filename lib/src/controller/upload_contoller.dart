import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

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
    headerTitle(albums.first.name);
    await _pagingPhotos();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(photos.first);
  }

  void changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) {
    headerTitle(album.name);
  }
}
