// lib/logic/blocs/category/category_bloc.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/department_model.dart';
import 'package:idoc_admin_side/data/repositories/department_repository.dart';
import 'package:idoc_admin_side/data/services/image_service.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_event.dart';
import 'package:idoc_admin_side/logic/blocs/category/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;
  final ImageService _imageService;
  File? _selectedImage;

  CategoryBloc({
    CategoryRepository? repository,
    ImageService? imageService,
  })  : _repository = repository ?? CategoryRepository(),
        _imageService = imageService ?? ImageService(),
        super(const CategoryInitial()) {
    on<PickImageEvent>(_onPickImage);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<ClearImageEvent>(_onClearImage);
  }

  Future<void> _onPickImage(
    PickImageEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final image = await _imageService.pickImage();
      if (image != null) {
        _selectedImage = image;
        emit(CategoryImagePicked(_selectedImage));
      }
    } catch (e) {
      emit(CategoryError('Failed to pick image: ${e.toString()}'));
    }
  }

  Future<void> _onAddCategory(
    AddCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryUploading('Uploading image...'));

    try {
      if (event.name.trim().isEmpty) {
        emit(const CategoryError('Please enter a category name'));
        return;
      }

      final imageUrl = await _imageService.uploadImage(event.image);
      if (imageUrl == null) {
        emit(const CategoryError('Failed to upload image'));
        return;
      }

      final category = Department(
        id: _repository.generateCategoryId(),
        name: event.name.trim(),
        image: imageUrl,
      );

      await _repository.addCategory(category);

      _selectedImage = null;
      emit(const CategorySuccess('Category added successfully!'));
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(CategoryError('Failed to add category: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(const CategoryUploading('Updating category...'));

    try {
      String imageUrl;

      if (event.newImage != null) {
        final uploadedUrl = await _imageService.uploadImage(event.newImage!);
        if (uploadedUrl == null) {
          emit(const CategoryError('Failed to upload new image'));
          return;
        }
        imageUrl = uploadedUrl;
      } else {
        imageUrl = event.currentImageUrl ?? '';
      }

      await _repository.updateCategory(event.docId, event.name.trim(), imageUrl);

      _selectedImage = null;
      emit(const CategorySuccess('Category updated successfully!'));
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(CategoryError('Failed to update category: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _repository.deleteCategory(event.docId);
      emit(const CategorySuccess('Category deleted successfully!'));
      add(const LoadCategoriesEvent());
    } catch (e) {
      emit(CategoryError('Failed to delete category: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      final categories = await _repository.loadCategories();
      emit(CategoryLoaded(
        categories: categories,
        selectedImage: _selectedImage,
      ));
    } catch (e) {
      emit(CategoryError('Failed to load categories: ${e.toString()}'));
    }
  }

  void _onClearImage(
    ClearImageEvent event,
    Emitter<CategoryState> emit,
  ) {
    _selectedImage = null;
    
    if (state is CategoryLoaded) {
      emit((state as CategoryLoaded).copyWith(clearImage: true));
    } else {
      emit(const CategoryImagePicked(null));
    }
  }
}