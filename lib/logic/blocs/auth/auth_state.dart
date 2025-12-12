import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthUnauthenticated extends AuthState {
  final bool isPasswordVisible;

  const AuthUnauthenticated({this.isPasswordVisible = false});

  @override
  List<Object?> get props => [isPasswordVisible];
}

class AuthError extends AuthState {
  final String message;
  final bool isPasswordVisible;

  const AuthError({
    required this.message,
    this.isPasswordVisible = false,
  });

  @override
  List<Object?> get props => [message, isPasswordVisible];
}