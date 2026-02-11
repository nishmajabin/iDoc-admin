import 'package:equatable/equatable.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final List<UserModel> filteredUsers;
  final String? searchQuery;
  final String? statusFilter;

  const UserLoaded({
    required this.users,
    required this.filteredUsers,
    this.searchQuery,
    this.statusFilter,
  });

  @override
  List<Object?> get props => [users, filteredUsers, searchQuery, statusFilter];

  UserLoaded copyWith({
    List<UserModel>? users,
    List<UserModel>? filteredUsers,
    String? searchQuery,
    String? statusFilter,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserDetailLoading extends UserState {
  const UserDetailLoading();
}

class UserDetailLoaded extends UserState {
  final UserModel user;

  const UserDetailLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserDetailError extends UserState {
  final String message;

  const UserDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserStatusUpdating extends UserState {
  const UserStatusUpdating();
}

class UserStatusUpdated extends UserState {
  final UserModel user;

  const UserStatusUpdated(this.user);

  @override
  List<Object?> get props => [user];
}