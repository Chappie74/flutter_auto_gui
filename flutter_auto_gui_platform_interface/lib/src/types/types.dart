import 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart';

enum MouseButton { left, right, middle }

extension MouseButtonExtension on MouseButton {
  String toShortString() {
    return toString().split('.').last;
  }
}
