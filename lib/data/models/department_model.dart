import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String id;
  final String name;
  final String image;

  const Department({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  factory Department.fromFirestore(Map<String, dynamic> map, String docId) {
    return Department(
      id: docId,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Department copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [id, name, image];
}