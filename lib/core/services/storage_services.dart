import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageServices {
  Future<String> uploadImage(File imageFile, String path);

  Future<File> compressedImage(File imageFile);
}

class SupabaseStorage implements StorageServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File imageFile, String path) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.webp';

    await _supabase.storage
        .from(path)
        .upload(
      fileName,
      imageFile,
      fileOptions: const FileOptions(
        contentType: 'image/webp',
        cacheControl: '31536000',
      ),
    );

    return _supabase.storage.from(path).getPublicUrl(fileName);
  }

  @override
  Future<File> compressedImage(File imageFile) async {
    final targetPath = '${imageFile.path}_compressed.webp';

    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      minWidth: 600,
      minHeight: 600,
      quality: 70,
      format: CompressFormat.webp,
    );

    if (result == null) {
      return imageFile;
    }

    return File(result.path);
  }
}
