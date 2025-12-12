// lib/data/services/image_service.dart
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ImageService {
  final ImagePicker _picker;
  final CloudinaryPublic _cloudinary;

  ImageService({
    ImagePicker? picker,
    String cloudName = 'dwykvyw5l',
    String uploadPreset = 'department_images_preset',
  })  : _picker = picker ?? ImagePicker(),
        _cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);

  /// Pick an image from gallery
  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    return pickedFile != null ? File(pickedFile.path) : null;
  }

  /// Upload image to Cloudinary
  Future<String?> uploadImage(File image, {String folder = 'category_images'}) async {
    try {
      final response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          folder: folder,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return response.secureUrl;
    } catch (e) {
      print('Error uploading image to Cloudinary: $e');
      return null;
    }
  }
}