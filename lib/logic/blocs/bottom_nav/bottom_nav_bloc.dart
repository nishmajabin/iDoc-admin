import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_event.dart';
import 'package:idoc_admin_side/logic/blocs/bottom_nav/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial()) {
    on<BottomNavTabChanged>(_onTabChanged);
    on<BottomNavReset>(_onReset);
  }

  Future<void> _onTabChanged(
    BottomNavTabChanged event,
    Emitter<BottomNavState> emit,
  ) async {
    // Simply emit the new index without tracking previous index
    emit(BottomNavChanged(
      currentIndex: event.index,
      previousIndex: 0, // Not needed for admin, but kept for compatibility
    ));
  }

  Future<void> _onReset(
    BottomNavReset event,
    Emitter<BottomNavState> emit,
  ) async {
    emit(const BottomNavInitial());
  }
}