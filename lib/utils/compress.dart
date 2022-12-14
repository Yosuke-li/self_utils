import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'log_utils.dart';

class ImageCompressUtil {
  /// 图片压缩 File -> File
  static Future<File?> imageCompressAndGetFile(File file) async {
    if (file.lengthSync() < 200 * 1024) {
      return file;
    }
    var quality = 100;
    if (file.lengthSync() > 10 * 1024 * 1024) {
      quality = 50;
    } else if (file.lengthSync() > 4 * 1024 * 1024) {
      quality = 60;
    } else if (file.lengthSync() > 1 * 1024 * 1024) {
      quality = 70;
    } else if (file.lengthSync() > 0.5 * 1024 * 1024) {
      quality = 80;
    } else if (file.lengthSync() > 0.1 * 1024 * 1024) {
      quality = 90;
    }
    final Directory dir = await path_provider.getTemporaryDirectory();
    final String targetPath = dir.absolute.path +'/'+DateTime.now().millisecondsSinceEpoch.toString()+ '.jpg';
    Log.info('quality: $quality');
    final File? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 600,
      quality: quality,
      rotate: 0,
    );

    Log.info('压缩后：${file.lengthSync() / 1024}');
    Log.info('压缩后：${(result?.lengthSync() ?? 0)/ 1024}');

    return result;
  }

  /// 图片压缩 File -> Uint8List
  static Future<Uint8List?> imageCompressFile(File file) async {
    final Uint8List? result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 94,
      rotate: 90,
    );
    print(file.lengthSync());
    print(result?.length);
    return result;
  }

  /// 图片压缩 Asset -> Uint8List
  static Future<Uint8List?> imageCompressAsset(String assetName) async {
    var list = await FlutterImageCompress.compressAssetImage(
      assetName,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 180,
    );

    return list;
  }

  /// 图片压缩 Uint8List -> Uint8List
  static Future<Uint8List> testComporessList(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1920,
      minWidth: 1080,
      quality: 96,
      rotate: 135,
    );
    print(list.length);
    print(result.length);
    return result;
  }
}