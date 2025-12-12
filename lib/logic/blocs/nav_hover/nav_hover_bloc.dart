import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_event.dart';
import 'package:idoc_admin_side/logic/blocs/nav_hover/nav_hover_state.dart';

class NavHoverBloc extends Bloc<NavHoverEvent, NavHoverState> {
  final Set<int> _hoveredIndices = {};

  NavHoverBloc() : super(const NavHoverInitial()) {
    on<NavHoverEntered>(_onHoverEntered);
    on<NavHoverExited>(_onHoverExited);
  }

  void _onHoverEntered(NavHoverEntered event, Emitter<NavHoverState> emit) {
    _hoveredIndices.add(event.index);
    emit(NavHoverChanged(Set.from(_hoveredIndices)));
  }

  void _onHoverExited(NavHoverExited event, Emitter<NavHoverState> emit) {
    _hoveredIndices.remove(event.index);
    emit(NavHoverChanged(Set.from(_hoveredIndices)));
  }
}

