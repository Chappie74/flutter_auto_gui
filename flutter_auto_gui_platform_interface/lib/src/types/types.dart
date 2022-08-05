enum MouseButton { left, right, middle }

extension MouseButtonExtension on MouseButton {
  String toShortString() {
    return toString().split('.').last;
  }
}
