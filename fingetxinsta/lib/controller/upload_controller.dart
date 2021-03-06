import 'dart:io';

import 'package:fingetxinsta/components/message_popup.dart';
import 'package:fingetxinsta/src/models/post.dart';
import 'package:fingetxinsta/src/repository/post_repository.dart';
import 'package:fingetxinsta/src/utils/data_util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';

import '../pages/upload/upload_description.dart';
import 'auth_controller.dart';

class UploadController extends GetxController {
  var albums = [];
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  RxString headerTitle = ''.obs;
  RxBool titleImage = false.obs;
  TextEditingController textEditingController = TextEditingController();
  Rx<AssetEntity> selectedImage =
      AssetEntity(id: '0', typeInt: 0, width: 200, height: 200).obs;
  File? filteredImage;
  Post? post;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //gridview 데이터 가져오기
    _loadPhotos();
    post = Post.init(AuthController.to.user.value);
  }

  //갤러리 안에있는 데이터 가져오기
  //PhotoManager 패키지로 이미지 데이터들 가져오기
  void _loadPhotos() async {
    print("asd");
    var result = await PhotoManager.requestPermissionExtend();
    print("asd");
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minWidth: 200, minHeight: 200),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {
      //message 권한 요청
    }
  }

  //처음 데이터 불러올때는 recent로
  void _loadData() async {
    changeAlbum(albums.first);

    // update();
  }

  //recent, picture, download에 맞춰서 이미지 가져옴
  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    print(album);
    // AssetPathEntity(id: -1617409521, name: Pictures, assetCount: 10)
    var photo = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photo);
    titleImage(true);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
    // print(selectedImage);
  }

  //recent, picture, download
  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    print(headerTitle);
    await _pagingPhotos(album);
  }

  //이미지 filter패키지로 변경
  void gotoImageFilter() async {
    //file은 기본적으로 future로 쌓여 있어서 풀어줘야함
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 1000);
    var imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      //
      filteredImage = imagefile['image_filtered'];
      //업데이트 페이지
      Get.to(() => const UploadDescription());
    }
  }

  void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unfocusKeyboard();
    print(textEditingController.text);
    String filename = DataUtil.makeFilePath();
    var task = uploadXFile(
        filteredImage!, '/${AuthController.to.user.value.uid}/${filename}');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.state == TaskState.success &&
            event.bytesTransferred == event.totalBytes) {
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
            thumbnail: downloadUrl,
            description: textEditingController.text,
          );
          _submitPost(updatedPost);
        }
      });
    }
  }

  UploadTask uploadXFile(File file, String filename) {
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    return ref.putFile(f, metadata);
    //users/{uid}/profile.jpg or profile.png
  }

  void _submitPost(Post postData) async {
    await PostRepository.updatePost(postData);
    showDialog(
      context: Get.context!,
      builder: (context) => MessagePopup(
        title: '포스트',
        message: '포스팅이 완료 되었습니다.',
        okCallback: () {
          //Get.until / > A > B > C > D > E(현재페이지), '/' 페이지가 나올 때 까지 앞의 페이지를 종료하는 방법
          Get.until((route) => Get.currentRoute == '/');
        },
      ),
    );
  }
}
