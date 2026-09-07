// import 'dart:io';
// import 'package:image/image.dart'as img;
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// abstract class StorageServices {
//   Future<String> uploadImage(File imageFile,String path);
//   Future<File> compressedImage(File imageFile);
//
// }
//
//
// class SupabaseStorage implements StorageServices {
//   final SupabaseClient _supabase = Supabase.instance.client;
//   @override
//   Future<String> uploadImage(File imageFile, String path) async {
//     final file = File(imageFile.path);
//
//     final fileName =
//         '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
//
//     await _supabase.storage.from(path).upload(fileName, file);
//
//     final publicUrl = _supabase.storage.from(path).getPublicUrl(fileName);
//
//     return publicUrl;
//   }
//
//   @override
//   Future<File> compressedImage(File imageFile) async {
//     final bytes = await imageFile.readAsBytes();
//
//     img.Image? image = img.decodeImage(bytes);
//
//     final compressed = img.copyResize(
//       image!,
//       width: 500,
//     );
//
//     final compressedFile = File(
//       '${imageFile.path}_compressed.jpg',
//     )
//       ..writeAsBytesSync(
//         img.encodeJpg(
//           compressed,
//           quality: 60,
//         ),
//       );
//
//     return compressedFile;
//
//   }
// }

import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageServices {
  Future<String> uploadImage(File imageFile, String path);
  Future<File> compressedImage(File imageFile);
}

class SupabaseStorage implements StorageServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File imageFile, String path) async {
    final file = File(imageFile.path);

    final extension = file.path.split('.').last.toLowerCase();

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.$extension';

    await _supabase.storage.from(path).upload(fileName, file);

    return _supabase.storage.from(path).getPublicUrl(fileName);
  }

  @override
  Future<File> compressedImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();

    final image = img.decodeImage(bytes);

    if (image == null) {
      return imageFile;
    }

    final resized = img.copyResize(
      image,
      width: 500,
    );

    final extension = imageFile.path.split('.').last.toLowerCase();

    if (extension == 'png') {
      final compressedFile = File(
        '${imageFile.path}_compressed.png',
      );

      compressedFile.writeAsBytesSync(
        img.encodePng(resized),
      );

      return compressedFile;
    }

    final compressedFile = File(
      '${imageFile.path}_compressed.jpg',
    );

    compressedFile.writeAsBytesSync(
      img.encodeJpg(
        resized,
        quality: 60,
      ),
    );

    return compressedFile;
  }
}