import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorApplicationModel {
  final String? id;
  final String name;
  final String place;
  final String email;
  final String phone;
  final String gender;
  final String specialist;
  final String bio;
  final String licenseNumber;
  final int experience;
  final String? licenseProofUrl;
  final String? profileImageUrl;
  final String status;
  final double consultationFee;
  final bool blocked; // New field for blocking functionality
  final String? blockReason; // Optional reason for blocking
  final DateTime? blockedAt; // When the doctor was blocked
  final DateTime createdAt;
  final DateTime? updatedAt;

  DoctorApplicationModel({
    this.id,
    required this.name,
    required this.place,
    required this.email,
    required this.phone,
    required this.gender,
    required this.specialist,
    required this.bio,
    required this.licenseNumber,
    required this.experience,
    this.licenseProofUrl,
    this.profileImageUrl,
    this.status = 'pending',
    this.consultationFee = 0.0,
    this.blocked = false, // Default to not blocked
    this.blockReason,
    this.blockedAt,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'place': place,
      'email': email,
      'phone': phone,
      'gender': gender,
      'specialist': specialist,
      'bio': bio,
      'licenseNumber': licenseNumber,
      'experience': experience,
      'licenseProofUrl': licenseProofUrl,
      'profileImageUrl': profileImageUrl,
      'status': status,
      'consultationFee': consultationFee,
      'blocked': blocked,
      'blockReason': blockReason,
      'blockedAt': blockedAt != null ? Timestamp.fromDate(blockedAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  factory DoctorApplicationModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorApplicationModel.fromMap(data, doc.id);
  }

  factory DoctorApplicationModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return DoctorApplicationModel(
      id: documentId,
      name: map['name'] ?? '',
      place: map['place'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      specialist: map['specialist'] ?? '',
      bio: map['bio'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      experience: map['experience'] ?? 0,
      licenseProofUrl: map['licenseProofUrl'],
      profileImageUrl: map['profileImageUrl'],
      status: map['status'] ?? 'pending',
      consultationFee: (map['consultationFee'] ?? 0.0).toDouble(),
      blocked: map['blocked'] ?? false,
      blockReason: map['blockReason'],
      blockedAt: (map['blockedAt'] as Timestamp?)?.toDate(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  DoctorApplicationModel copyWith({
    String? id,
    String? name,
    String? place,
    String? email,
    String? phone,
    String? gender,
    String? specialist,
    String? bio,
    String? licenseNumber,
    int? experience,
    String? licenseProofUrl,
    String? profileImageUrl,
    String? status,
    double? consultationFee,
    bool? blocked,
    String? blockReason,
    DateTime? blockedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DoctorApplicationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      place: place ?? this.place,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      specialist: specialist ?? this.specialist,
      bio: bio ?? this.bio,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      experience: experience ?? this.experience,
      licenseProofUrl: licenseProofUrl ?? this.licenseProofUrl,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      status: status ?? this.status,
      consultationFee: consultationFee ?? this.consultationFee,
      blocked: blocked ?? this.blocked,
      blockReason: blockReason ?? this.blockReason,
      blockedAt: blockedAt ?? this.blockedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'DoctorApplicationModel(id: $id, name: $name, email: $email, specialist: $specialist, status: $status, blocked: $blocked, fee: ₹$consultationFee)';
  }
}