abstract class NavHoverEvent {
  const NavHoverEvent();
}

class NavHoverEntered extends NavHoverEvent {
  final int index;
  const NavHoverEntered(this.index);
}

class NavHoverExited extends NavHoverEvent {
  final int index;
  const NavHoverExited(this.index);
}

