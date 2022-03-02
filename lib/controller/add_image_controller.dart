import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibeshot/networking/profile.dart';

class AddImageController extends GetxController {
  var images = <File>[].obs;

  final ImagePicker _picker = ImagePicker();

  storage.Reference? ref;

  final RxList<String> imagesUrl = <String>[].obs;

  var isUploading = false.obs;

  void addImages(List<String> urls) {
    imagesUrl.clear();
    imagesUrl.addAll(urls);
  }

  void deleteImageAtIndex(int index) {
    images.removeAt(index);
  }

  Future<bool> deleteImage(String url) async {
    if (imagesUrl.length > 1) {
      await FirebaseStorage.instance.refFromURL(url).delete();
      imagesUrl.remove(url);
      List<String> urls = [];
      urls.addAll(imagesUrl);
      imagesUrl.value = urls;
      return true;
    } else {
      return false;
    }
  }

  Future<void> singleImageUpload() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userName = sharedPreferences.getString('userid')!;
    XFile? pickedImages =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    isUploading.value = true;
    if (pickedImages != null) {
      File image = File(pickedImages.path);
      ref = storage.FirebaseStorage.instance
          .ref()
          .child('images/$userName/${Path.basename(image.path)}');
      await ref!.putFile(image);
      imagesUrl.add(await ref!.getDownloadURL());
      bool hasUpdated = await ProfileApi.uploadPhotos(imagesUrl.value);
      if (hasUpdated) {
        print("Updated in API");
      } else {
        print("Error while updating");
      }
    }
    isUploading.value = false;
  }

  Future galleryImage() async {
    if (images.length < 6) {
      var pics = await _picker.pickMultiImage(imageQuality: 40);
      if (pics != null && pics.length <= (6 - images.length)) {
        pics.forEach((XFile element) {
          images.add(File(element.path));
        });
        update();
      }
    }
  }

  void pickImage() async {
    if (images.value.length < 6) {
      // List<Asset> pickedImages =
      //     await MultiImagePicker.pickImages(maxImages: 6 - images.length);

      // List<File> tempList = [];
      // tempList.addAll(images);
      // tempList.addAll(pickedImages
      //     .map((Asset asset) => File(asset.identifier! + '/${asset.name}')));
      // images.value = tempList;
      XFile? pickedImages = (await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      ));
      if (pickedImages != null) {
        List<File> tempList = [];
        tempList.addAll(images);
        tempList.add(File(pickedImages.path));
        images.value = tempList;
      }
    }
    notifyChildrens();
  }

  Future uploadImages(String userName, Future updateUser) async {
    isUploading.value = true;
    File image = images[0];
    ref = storage.FirebaseStorage.instance
        .ref()
        .child('images/$userName/${Path.basename(image.path)}');
    await ref!.putFile(image);
    imagesUrl.add(await ref!.getDownloadURL());
    bool success = await ProfileApi.uploadPhotos(
      imagesUrl,
    );
    lazyUpload(userName);

    isUploading.value = false;
    return success;
  }

  Future lazyUpload(String userName) async {
    images.value.removeAt(0);
    for (File image in images.value) {
      ref = storage.FirebaseStorage.instance
          .ref()
          .child('images/$userName/${Path.basename(image.path)}');
      await ref!.putFile(image);
      imagesUrl.add(await ref!.getDownloadURL());
    }
    await ProfileApi.uploadPhotos(
      imagesUrl,
    );
    images.clear();
    imagesUrl.clear();
  }
}
