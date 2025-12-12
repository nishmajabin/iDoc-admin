import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool _isPasswordVisible = true;

  AuthBloc() : super(const AuthUnauthenticated()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<TogglePasswordVisibilityEvent>(_onTogglePasswordVisibility);
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
        emit(AuthUnauthenticated(isPasswordVisible: _isPasswordVisible));
      }
    } catch (e) {
      emit(AuthError(
        message: 'Error checking login status',
        isPasswordVisible: _isPasswordVisible,
      ));
    }
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      if (event.username == "admin" && event.password == "admin123") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        emit(const AuthAuthenticated());
      } else {
        emit(AuthError(
          message: 'username and password is not correct',
          isPasswordVisible: _isPasswordVisible,
        ));
      }
    } catch (e) {
      emit(AuthError(
        message: 'An error occurred during login',
        isPasswordVisible: _isPasswordVisible,
      ));
    }
  }

  Future<void> _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      _isPasswordVisible = true;
      emit(AuthUnauthenticated(isPasswordVisible: _isPasswordVisible));
    } catch (e) {
      emit(AuthError(
        message: 'Error during logout',
        isPasswordVisible: _isPasswordVisible,
      ));
    }
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    _isPasswordVisible = !_isPasswordVisible;
    
    if (state is AuthUnauthenticated) {
      emit(AuthUnauthenticated(isPasswordVisible: _isPasswordVisible));
    } else if (state is AuthError) {
      final currentState = state as AuthError;
      emit(AuthError(
        message: currentState.message,
        isPasswordVisible: _isPasswordVisible,
      ));
    }
  }
}