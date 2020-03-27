import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nanoid/nanoid.dart';

abstract class ImageService {
  Future<File> pickImage(ImageSource source);
  Future<File> saveImage(File image);
  Future deleteImage(File image);

  factory ImageService.instance() => _ImageService();
}

class _ImageService implements ImageService {
  _ImageService._internal();
  static final _ImageService _instance = _ImageService._internal();
  factory _ImageService() => _instance;

  @override
  Future deleteImage(File image) {
    return image.delete();
  }

  @override
  Future<File> saveImage(File image) async {
    final String pathAppDocsDirectory =
        (await getApplicationDocumentsDirectory()).path;

    try {
      final fileName = '${nanoid()}.jpg';
      return await image.copy('$pathAppDocsDirectory/$fileName');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<File> pickImage(ImageSource source) async {
    final storagePermission = PermissionGroup.storage;
    PermissionStatus permissionStatus =
        await PermissionHandler().checkPermissionStatus(storagePermission);
    if (permissionStatus == PermissionStatus.denied) {
      final permissions =
          await PermissionHandler().requestPermissions([storagePermission]);
      if (permissions[storagePermission] == PermissionStatus.denied) {
        throw PlatformException(
            code: 'photo_access_denied', message: 'Photo access denied');
      }
    }

    return ImagePicker.pickImage(source: source);
  }
}
