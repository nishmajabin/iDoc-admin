import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  Timer? _animationTimer;
  Timer? _completionTimer;
  int _beatCount = 0;
  int _animationStep = 0;
  
  final List<double> _beatPattern = [
    1.0,   // start
    1.0,   // very slight up
    1.12,  // peak (reduced from 1.15)
    1.12,  // down
    1.0,   // normal
    1.0,   // pause
  ];
  
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
    on<AnimationTick>(_onAnimationTick);
    on<CompleteSplash>(_onCompleteSplash);
  }
  
  void _onStartSplash(StartSplash event, Emitter<SplashState> emit) {
    emit(const SplashAnimating(1.0));
    
    _startSlowHeartbeat();
    
    _completionTimer = Timer(const Duration(seconds: 3), () {
      add(const CompleteSplash());
    });
  }
  
  void _startSlowHeartbeat() {
    _animationTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_beatCount < 3) {
        double scale = _beatPattern[_animationStep];
        
        if (!isClosed) {
          add(AnimationTick(scale));
        }
        
        _animationStep++;
        
        if (_animationStep >= _beatPattern.length) {
          _animationStep = 0;
          _beatCount++;
        }
      } else {
        timer.cancel();
      }
    });
  }
  
  void _onAnimationTick(AnimationTick event, Emitter<SplashState> emit) {
    emit(SplashAnimating(event.scale));
  }
  
  Future<void> _onCompleteSplash(
    CompleteSplash event,
    Emitter<SplashState> emit,
  ) async {
    _animationTimer?.cancel();
    _completionTimer?.cancel();
    
    // Check login status from SharedPreferences
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      
      emit(SplashCompleted(isLoggedIn: isLoggedIn));
    } catch (e) {
      // If there's an error, default to not logged in
      emit(const SplashCompleted(isLoggedIn: false));
    }
  }
  
  @override
  Future<void> close() {
    _animationTimer?.cancel();
    _completionTimer?.cancel();
    return super.close();
  }
}