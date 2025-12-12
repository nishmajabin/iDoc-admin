import 'package:equatable/equatable.dart';

abstract class NavHoverState extends Equatable {
  const NavHoverState();

  @override
  List<Object> get props => [];
}

class NavHoverInitial extends NavHoverState {
  const NavHoverInitial();
}

class NavHoverChanged extends NavHoverState {
  final Set<int> hoveredIndices;

  const NavHoverChanged(this.hoveredIndices);

  @override
  List<Object> get props => [hoveredIndices];
}

