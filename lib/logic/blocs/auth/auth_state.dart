import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  final bool isPasswordVisible;
  final String username;
  final String password;

  const AuthState({
    this.isPasswordVisible = true,
    this.username = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [isPasswordVisible, username, password];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({
    super.isPasswordVisible,
    super.username,
    super.password,
  });
}

class AuthLoading extends AuthState {
  const AuthLoading({
    super.isPasswordVisible,
    super.username,
    super.password,
  });
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();

  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String message;

  const AuthError({
    required this.message,
    super.isPasswordVisible,
    super.username,
    super.password,
  });

  @override
  List<Object?> get props => [message, isPasswordVisible, username, password];
}