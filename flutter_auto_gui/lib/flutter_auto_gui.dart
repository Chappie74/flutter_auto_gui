export 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart'
    show MouseButton;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart';

class FlutterAutoGUI {
  static FlutterAutoGUIPlatform get _platform =>
      FlutterAutoGUIPlatform.instance;

  /// Returns the current xy co-ordinate of the mouse cursor
  ///
  /// Returns the current mouse position as [Point] of type [int]
  ///
  static Future<Point<int>?> position() async {
    return await FlutterAutoGUIPlatform.instance.position();
  }

  /// Moves the mouse cursor to the xy co-ordinate.
  ///
  /// `point` : [Point] - x,y co-ordinate to move the mouse cursor to.
  ///
  /// `duration` : [Duration] - The amount of time it takes to move the mouse
  /// cursor. If duration is zero mouse cursor is moved instantaneously.
  ///
  /// `curve` : [Curve] - The curve function used if the duration is not zero.
  ///
  static Future<void> moveTo({
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

  /// Moves the mouse cursor relative to it's current position.
  ///
  /// `offset` : [Size] - How far left (for negative values of [Size.width]) or
  /// right (for positive values of [Size.width]) / up (for positive values of [Size.height])
  /// or down (for negative values of [Size.height]) to move the mouse cursor by
  ///
  /// `duration` : [Duration] - The amount of time it takes to move the mouse
  /// cursor. If duration is zero mouse cursor is moved instantaneously.
  ///
  /// `curve` : [Curve] - The curve function used if the duration is not zero.
  ///
  static Future<void> moveToRel({
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

  /// Pressed mouse button then moves the cursor to the xy co-ordinate then
  /// release mouse button.
  ///
  /// `point` : [Point] - x,y co-ordinate to move the mouse cursor to.
  ///
  /// `button` : [MouseButton] - The mouse button to press down while moving.
  ///
  /// `duration` : [Duration] - The amount of time it takes to move the mouse
  /// cursor. If duration is zero mouse cursor is moved instantaneously.
  ///
  /// `curve` : [Curve] - The curve function used if the duration is not zero.
  ///
  static Future<void> dragTo({
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

  ///  Pressed mouse button then moves the mouse cursor relative to it's current
  ///  position then release mouse button.
  ///
  /// `offset` : [Size] - How far left (for negative values of [Size.width]) or
  /// right (for positive values of [Size.width]) / up (for positive values of [Size.height])
  /// or down (for negative values of [Size.height]) to move the mouse cursor by
  ///
  /// `button` : [MouseButton] - The mouse button to press down while moving.
  ///
  /// `duration` : [Duration] - The amount of time it takes to move the mouse
  /// cursor. If duration is zero mouse cursor is moved instantaneously.
  ///
  /// `curve` : [Curve] - The curve function used if the duration is not zero.
  ///
  static Future<void> dragToRel({
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

  /// Performs pressing a mouse button down (but not up afterwards)
  /// at the current mouse position
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  static Future<void> mouseDown({
    MouseButton button = MouseButton.left,
  }) async {
    await _platform.mouseDown(
      button: button,
    );
  }

  /// Performs releasing a mouse button up (but not down beforehand)
  /// at the current mouse position
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  static Future<void> mouseUp({
    MouseButton button = MouseButton.left,
  }) async {
    await _platform.mouseUp(
      button: button,
    );
  }

  /// Performs pressing a mouse button down and then releasing immediately it.
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  /// `clicks` : [int] - The amount of clicks to perform.
  ///
  /// `interval`: [Duration] - The time interval between each click.
  ///
  static Future<void> click({
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

  /// Performs a scroll of the mouse forwards or backwards
  ///
  /// `clicks`: [int] - How much to scroll the mouse by
  ///  a positive (forwards / right), negative (backwards / left)
  ///
  /// `axis` : [Axis] - Direction to scroll.
  ///
  static Future<void> scroll({
    required int clicks,
    Axis axis = Axis.vertical,
  }) async {
    await _platform.scroll(clicks: clicks, axis: axis);
  }

  /// Types the characters in the string
  ///
  /// `text`: [String] - String to type
  ///
  /// `interval`: [Duration] - interval between key presses
  ///
  /// `omitInvalid`: [bool] - True to omit unsupported characters found in text,
  /// else an error is thrown.
  ///
  static Future<void> write({
    required String text,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
    bool omitInvalid = false,
  }) async {
    _platform.write(text: text, interval: interval, omitInvalid: omitInvalid);
  }

  /// Sets a single key to the up position
  ///
  /// `key`: [String] - String representation of the key
  ///
  static Future<void> keyUp({required String key}) async {
    _platform.keyUp(key: key);
  }

  /// Sets a single key to the up position
  ///
  /// `key`: [String] - String representation of the key
  ///
  static Future<void> keyDown({required String key}) async {
    _platform.keyDown(key: key);
  }

  /// Sets a key down then up to simulate a key press
  ///
  /// `key`: [String] - String representation of the key
  ///
  /// `times`: [int] - Amount of times to press the key
  ///
  /// `interval`: [Duration] - Time between each key press
  ///
  static Future<void> press({
    required String key,
    int times = 1,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
  }) async {
    _platform.press(
      key: key,
      times: times,
      interval: interval,
    );
  }

  /// Sets the keys to down state in order and releases then in reverse order
  ///
  /// `keys`: [List] of [String] - List of keys to press
  ///
  /// `interval`: [Duration] - Delay between each key press
  static Future<void> hotkey({
    required List<String> keys,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
  }) async {
    _platform.hotkey(
      keys: keys,
      interval: interval,
    );
  }
}
