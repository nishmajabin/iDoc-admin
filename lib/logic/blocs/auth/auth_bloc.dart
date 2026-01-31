import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const AuthUnauthenticated()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<LoginEvent>(_onLogin);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
    on<UpdateUsernameEvent>(_onUpdateUsername);
    on<UpdatePasswordEvent>(_onUpdatePassword);
    on<ClearLoginFieldsEvent>(_onClearLoginFields);
  }

  Future<void> _onCheckLoginStatus(
    CheckLoginStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        emit(const AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthError(message: 'Error checking login status'));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(
      isPasswordVisible: state.isPasswordVisible,
      username: state.username,
      password: state.password,
    ));

    try {
      // Simple admin check
      if (event.username.trim() == "admin" && event.password.trim() == "admin123") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        emit(const AuthAuthenticated());
      } else {
        emit(AuthError(
          message: 'Username and password is not correct',
          isPasswordVisible: state.isPasswordVisible,
          username: state.username,
          password: state.password,
        ));
      }
    } catch (e) {
      emit(AuthError(
        message: 'An error occurred during login',
        isPasswordVisible: state.isPasswordVisible,
        username: state.username,
        password: state.password,
      ));
    }
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated) {
      emit(AuthUnauthenticated(
        isPasswordVisible: !state.isPasswordVisible,
        username: state.username,
        password: state.password,
      ));
    } else if (state is AuthError) {
      final currentState = state as AuthError;
      emit(AuthError(
        message: currentState.message,
        isPasswordVisible: !state.isPasswordVisible,
        username: state.username,
        password: state.password,
      ));
    }
  }

  void _onUpdateUsername(
    UpdateUsernameEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated) {
      emit(AuthUnauthenticated(
        isPasswordVisible: state.isPasswordVisible,
        username: event.username,
        password: state.password,
      ));
    } else if (state is AuthError) {
      final currentState = state as AuthError;
      emit(AuthError(
        message: currentState.message,
        isPasswordVisible: state.isPasswordVisible,
        username: event.username,
        password: state.password,
      ));
    }
  }

  void _onUpdatePassword(
    UpdatePasswordEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated) {
      emit(AuthUnauthenticated(
        isPasswordVisible: state.isPasswordVisible,
        username: state.username,
        password: event.password,
      ));
    } else if (state is AuthError) {
      final currentState = state as AuthError;
      emit(AuthError(
        message: currentState.message,
        isPasswordVisible: state.isPasswordVisible,
        username: state.username,
        password: event.password,
      ));
    }
  }

  void _onClearLoginFields(
    ClearLoginFieldsEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state is AuthUnauthenticated || state is AuthError) {
      emit(const AuthUnauthenticated(
        isPasswordVisible: true,
        username: '',
        password: '',
      ));
    }
  }
}