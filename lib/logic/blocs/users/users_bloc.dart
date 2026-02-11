import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/data/models/user_model.dart';
import 'package:idoc_admin_side/data/repositories/user_repository.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_event.dart';
import 'package:idoc_admin_side/logic/blocs/users/users_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;
  StreamSubscription<List<UserModel>>? _usersSubscription;

  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(const UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<SearchUsers>(_onSearchUsers);
    on<FilterUsersByStatus>(_onFilterUsersByStatus);
    on<LoadUserDetails>(_onLoadUserDetails);
    on<UpdateUserStatus>(_onUpdateUserStatus);
  }

  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(const UserLoading());

    try {
      await _usersSubscription?.cancel();

      _usersSubscription = _repository.getUsersStream().listen(
        (users) {
          add(RefreshUsers());
        },
        onError: (error) {
          add(const RefreshUsers());
        },
      );
    } catch (e) {
      emit(UserError('Failed to load users: ${e.toString()}'));
    }
  }

  void _onRefreshUsers(RefreshUsers event, Emitter<UserState> emit) async {
    try {
      final users = await _repository.getUsers();

      if (state is UserLoaded) {
        final currentState = state as UserLoaded;
        emit(currentState.copyWith(
          users: users,
          filteredUsers: _applyFilters(
            users,
            currentState.searchQuery,
            currentState.statusFilter,
          ),
        ));
      } else {
        emit(UserLoaded(
          users: users,
          filteredUsers: users,
        ));
      }
    } catch (e) {
      emit(UserError('Failed to refresh users: ${e.toString()}'));
    }
  }

  void _onSearchUsers(SearchUsers event, Emitter<UserState> emit) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      final filteredUsers = _applyFilters(
        currentState.users,
        event.query,
        currentState.statusFilter,
      );

      emit(currentState.copyWith(
        filteredUsers: filteredUsers,
        searchQuery: event.query,
      ));
    }
  }

  void _onFilterUsersByStatus(
      FilterUsersByStatus event, Emitter<UserState> emit) {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;
      final filteredUsers = _applyFilters(
        currentState.users,
        currentState.searchQuery,
        event.status,
      );

      emit(currentState.copyWith(
        filteredUsers: filteredUsers,
        statusFilter: event.status,
      ));
    }
  }

  List<UserModel> _applyFilters(
    List<UserModel> users,
    String? searchQuery,
    String? statusFilter,
  ) {
    var filtered = users;

    // Apply search filter
    if (searchQuery != null && searchQuery.isNotEmpty) {
      filtered = filtered.where((user) {
        final nameLower = user.name.toLowerCase();
        final emailLower = user.email.toLowerCase();
        final addressLower = (user.address ?? '').toLowerCase();
        final queryLower = searchQuery.toLowerCase();

        return nameLower.contains(queryLower) ||
            emailLower.contains(queryLower) ||
            addressLower.contains(queryLower);
      }).toList();
    }

    // Apply status filter if needed
    // if (statusFilter != null) {
    //   filtered = filtered.where((user) {
    //     if (statusFilter == 'active') return user.isActive == true;
    //     if (statusFilter == 'inactive') return user.isActive == false;
    //     return true;
    //   }).toList();
    // }

    return filtered;
  }

  void _onLoadUserDetails(
      LoadUserDetails event, Emitter<UserState> emit) async {
    emit(const UserDetailLoading());
    try {
      final user = await _repository.getUserById(event.userId);

      if (user != null) {
        emit(UserDetailLoaded(user));
      } else {
        emit(const UserDetailError('User not found'));
      }
    } catch (e) {
      emit(UserDetailError('Failed to load user details: ${e.toString()}'));
    }
  }

  void _onUpdateUserStatus(
      UpdateUserStatus event, Emitter<UserState> emit) async {
    emit(const UserStatusUpdating());
    try {
      final user = await _repository.updateUserStatus(
        userId: event.userId,
        isActive: event.isActive,
      );

      if (user != null) {
        emit(UserStatusUpdated(user));
        add(const RefreshUsers());
      } else {
        emit(const UserDetailError('Failed to update user status'));
      }
    } catch (e) {
      emit(UserDetailError('Failed to update user status: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _usersSubscription?.cancel();
    return super.close();
  }
}