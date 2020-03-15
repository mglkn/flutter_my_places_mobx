import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageService {
  Future<File> pickImage(ImageSource source);
  File getImage(String path);
  Future saveImage(File image);
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
  File getImage(String path) {
    return File(path);
  }

  @override
  Future saveImage(File image) async {
    final String pathAppDocsDirectory =
        (await getApplicationDocumentsDirectory()).path;

    try {
      await image.copy('$pathAppDocsDirectory/${basename(image.path)}');
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<File> pickImage(ImageSource source) {
    try {
      return ImagePicker.pickImage(source: source);
    } catch (_) {
      rethrow;
    }
  }
}
