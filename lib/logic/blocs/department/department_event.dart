import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class PickImageEvent extends CategoryEvent {
  const PickImageEvent();
}

class AddCategoryEvent extends CategoryEvent {
  final String name;
  final File image;

  const AddCategoryEvent({
    required this.name,
    required this.image,
  });

  @override
  List<Object?> get props => [name, image];
}

class UpdateCategoryEvent extends CategoryEvent {
  final String docId;
  final String name;
  final File? newImage;
  final String? currentImageUrl;

  const UpdateCategoryEvent({
    required this.docId,
    required this.name,
    this.newImage,
    this.currentImageUrl,
  });

  @override
  List<Object?> get props => [docId, name, newImage, currentImageUrl];
}

class DeleteCategoryEvent extends CategoryEvent {
  final String docId;

  const DeleteCategoryEvent(this.docId);

  @override
  List<Object?> get props => [docId];
}

class LoadCategoriesEvent extends CategoryEvent {
  const LoadCategoriesEvent();
}

class ClearImageEvent extends CategoryEvent {
  const ClearImageEvent();
}