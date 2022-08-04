import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart';

class FlutterAutoGUIMouse {
  static FlutterAutoGUIPlatform get _platform =>
      FlutterAutoGUIPlatform.instance;

  Future<Point<int>?> position() async {
    return await FlutterAutoGUIPlatform.instance.position();
  }

  Future<void> moveTo({
    required Point<int> point,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    await _platform.moveTo(
      point: point,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> moveToRel({
    required Size offset,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    await _platform.moveToRel(
      offset: offset,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> dragTo({
    required Point<int> point,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    await _platform.dragTo(
      point: point,
      button: button,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> dragToRel({
    required Size offset,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    await _platform.dragToRel(
      offset: offset,
      button: button,
      duration: duration,
      curve: curve,
    );
  }

  Future<void> mouseDown({
    MouseButton button = MouseButton.left,
  }) async {
    await _platform.mouseDown(
      button: button,
    );
  }

  Future<void> mouseUp({
    MouseButton button = MouseButton.left,
  }) async {
    await _platform.mouseUp(
      button: button,
    );
  }

  Future<void> click({
    MouseButton button = MouseButton.left,
    int clicks = 1,
    Duration interval = Duration.zero,
  }) async {
    await _platform.click(
      button: button,
      clicks: clicks,
      interval: interval,
    );
  }
}
