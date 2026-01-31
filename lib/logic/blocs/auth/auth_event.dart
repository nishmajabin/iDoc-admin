import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckLoginStatusEvent extends AuthEvent {
  const CheckLoginStatusEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class TogglePasswordVisibilityEvent extends AuthEvent {
  const TogglePasswordVisibilityEvent();
}

// NEW EVENTS FOR TEXT FIELD MANAGEMENT
class UpdateUsernameEvent extends AuthEvent {
  final String username;

  const UpdateUsernameEvent(this.username);

  @override
  List<Object?> get props => [username];
}

class UpdatePasswordEvent extends AuthEvent {
  final String password;

  const UpdatePasswordEvent(this.password);

  @override
  List<Object?> get props => [password];
}

class ClearLoginFieldsEvent extends AuthEvent {
  const ClearLoginFieldsEvent();
}