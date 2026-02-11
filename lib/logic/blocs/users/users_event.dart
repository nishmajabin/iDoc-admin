import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {
  const LoadUsers();
}

class RefreshUsers extends UserEvent {
  const RefreshUsers();
}

class SearchUsers extends UserEvent {
  final String query;

  const SearchUsers(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterUsersByStatus extends UserEvent {
  final String? status; // 'active', 'inactive', null for all

  const FilterUsersByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class LoadUserDetails extends UserEvent {
  final String userId;

  const LoadUserDetails(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateUserStatus extends UserEvent {
  final String userId;
  final bool isActive;

  const UpdateUserStatus({
    required this.userId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [userId, isActive];
}