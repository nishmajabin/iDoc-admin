import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryImagePicked extends CategoryState {
  final File? image;

  const CategoryImagePicked(this.image);

  @override
  List<Object?> get props => [image];
}

class CategoryUploading extends CategoryState {
  final String message;

  const CategoryUploading(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryLoaded extends CategoryState {
  final List<Department> categories;
  final File? selectedImage;

  const CategoryLoaded({
    required this.categories,
    this.selectedImage,
  });

  @override
  List<Object?> get props => [categories, selectedImage];

  CategoryLoaded copyWith({
    List<Department>? categories,
    File? selectedImage,
    bool clearImage = false,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
    );
  }
}

class CategorySuccess extends CategoryState {
  final String message;

  const CategorySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}