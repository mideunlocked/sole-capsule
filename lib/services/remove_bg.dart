import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remove_bg/remove_bg.dart';
import 'package:uuid/uuid.dart';

import '../helpers/app_contants.dart';

class RemoveBackground {
  static Future<File> removeImageBackground(File imageFile) async {
    Uint8List? bytes = await Remove().bg(
      imageFile,
      privateKey: AppConstants.removeBgKey,
      onUploadProgressCallback: (progressValue) {
        if (kDebugMode) {
          // print(progressValue);
        }
      },
    );

    final tempDir = await getTemporaryDirectory();
    String uniqueFileName = const Uuid().v4();
    File file = await File('${tempDir.path}/$uniqueFileName.png').create();
    file.writeAsBytesSync(bytes ?? []);

    return file;
  }

  static Future<File> getSavedFilePath(File imageFile) async {
    final file = await removeImageBackground(imageFile);
    return file;
  }
}
