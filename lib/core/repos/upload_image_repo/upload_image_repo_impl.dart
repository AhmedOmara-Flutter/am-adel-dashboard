import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:am_adel_dashboard/core/errors/failure.dart';
import 'package:am_adel_dashboard/core/repos/upload_image_repo/upload_image_repo.dart';
import 'package:am_adel_dashboard/core/services/storage_services.dart';

class UploadImageRepoImpl implements UploadImageRepo {
  final StorageServices _storageServices;

  UploadImageRepoImpl(this._storageServices);
  @override
  Future<Either<Failure, String>> uploadImage(File imageFile) async {
    try {
      final compressedImage = await _storageServices.compressedImage(imageFile);
      var imageUploaded = await _storageServices.uploadImage(
        compressedImage,
        'images',
      );
      return Right(imageUploaded);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<String>>> uploadSubImages(
    List<File> subImages,
  ) async {
    try {
      List<String> imageUrls = [];

      for (File image in subImages) {
        final compressedImage = await _storageServices.compressedImage(image);

        final imageUrl = await _storageServices.uploadImage(
          compressedImage,
          'images',
        );

        imageUrls.add(imageUrl);
      }

      return Right(imageUrls);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
