import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_event.dart';
import 'package:idoc_admin_side/logic/blocs/log_out/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final FirebaseAuth _firebaseAuth;

  LogoutBloc({
    FirebaseAuth? firebaseAuth,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const LogoutInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    emit(const LogoutLoading());

    try {
      // Clear SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.clear(); // Optional: clear all preferences

      // Sign out from Firebase (if using Firebase elsewhere)
      await _firebaseAuth.signOut();

      emit(const LogoutSuccess(message: 'Logged out successfully'));
    } on FirebaseAuthException catch (e) {
      emit(LogoutFailure(error: _handleFirebaseError(e)));
    } catch (e) {
      emit(LogoutFailure(error: 'Failed to logout: ${e.toString()}'));
    }
  }

  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Failed to logout. Please try again.';
    }
  }
}