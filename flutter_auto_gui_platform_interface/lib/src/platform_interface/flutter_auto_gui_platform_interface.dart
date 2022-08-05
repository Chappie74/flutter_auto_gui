import 'dart:math';

import 'package:flutter/material.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../method_channel/method_channel_flutter_auto_gui.dart';
import '../types/types.dart';

//
// The functions in this interface should all be implemented in such a way that
// all/most of the processing happens natively, rather than making method
// channel calls. This hopefully will help circumvent any performance issues,
// since making a call to the method channel can be very computionally expensive
// and making excessive calls in a short period of time might be inefficient.
// For example. Consider typing a tring in the [write] function.
// Rather than making multiple [press] method calls in a for loop, prefer making
// one method call with the string to write as parameter, and have the for loop
// execute natively.
//
abstract class FlutterAutoGUIPlatform extends PlatformInterface {
  /// Constructs a FlutterAutoGUIPlatform.
  FlutterAutoGUIPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAutoGUIPlatform _instance = MethodChannelFlutterAutoGUI();

  /// The default instance of [FlutterAutoGUIPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAutoGUI].
  static FlutterAutoGUIPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterAutoGUIPlatform] when they register themselves.

  // https://github.com/flutter/flutter/issues/43368
  static set instance(FlutterAutoGUIPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  // MOUSE

  /// Returns the current xy co-ordinate of the mouse cursor
  ///
  /// Returns the current mouse position as [Point] of type [int]
  ///
  Future<Point<int>?> position() async {
    throw UnimplementedError('position has not been implemented.');
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
  Future<void> moveTo({
    required Point<int> point,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    throw UnimplementedError('moveTo has not been implemented.');
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
  Future<void> moveToRel({
    required Size offset,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    throw UnimplementedError('moveToRel has not been implemented.');
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
  Future<void> dragTo({
    required Point<int> point,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    throw UnimplementedError('dragTo has not been implemented.');
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
  Future<void> dragToRel({
    required Size offset,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    throw UnimplementedError('dragToRel has not been implemented.');
  }

  /// Performs pressing a mouse button down (but not up afterwards)
  /// at the current mouse position
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  Future<void> mouseDown({
    MouseButton button = MouseButton.left,
  }) async {
    throw UnimplementedError('mouseDown has not been implemented.');
  }

  /// Performs releasing a mouse button up (but not down beforehand)
  /// at the current mouse position
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  Future<void> mouseUp({
    MouseButton button = MouseButton.left,
  }) async {
    throw UnimplementedError('mouseUp has not been implemented.');
  }

  /// Performs pressing a mouse button down and then releasing immediately it.
  ///
  /// `button` : [MouseButton] - The mouse button to press.
  ///
  /// `clicks` : [int] - The amount of clicks to perform.
  ///
  /// `interval`: [Duration] - The time interval between each click.
  ///
  Future<void> click({
    MouseButton button = MouseButton.left,
    int clicks = 1,
    Duration interval = Duration.zero,
  }) async {
    throw UnimplementedError('click has not been implemented.');
  }

  /// Performs a scroll of the mouse forwards or backwards
  ///
  /// `clicks`: [int] - How much to scroll the mouse by
  ///  a positive (forwards / right), negative (backwards / left)
  ///
  /// `axis` : [Axis] - Direction to scroll.
  ///
  Future<void> scroll({
    required int clicks,
    Axis axis = Axis.vertical,
  }) async {
    throw UnimplementedError('scroll has not been implemented.');
  }

  // KEYBOARD

  /// Types the characters in the string
  ///
  /// `text`: [String] - String to type
  ///
  /// `interval`: [Duration] - interval between key presses
  ///
  /// `omitInvalid`: [bool] - True to omit unsupported characters found in text,
  /// else an error is thrown.
  ///
  Future<void> write({
    required String text,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
    bool omitInvalid = false,
  }) async {
    throw UnimplementedError('write has not been implemented.');
  }

  /// Sets a single key to the up position
  ///
  /// `key`: [String] - String representation of the key
  ///
  Future<void> keyUp({required String key}) async {
    throw UnimplementedError('keyup has not been implemented.');
  }

  /// Sets a single key to the up position
  ///
  /// `key`: [String] - String representation of the key
  ///
  Future<void> keyDown({required String key}) async {
    throw UnimplementedError('keyup has not been implemented.');
  }

  /// Sets a key down then up to simulate a key press
  ///
  /// `key`: [String] - String representation of the key
  ///
  /// `times`: [int] - Amount of times to press the key
  ///
  /// `interval`: [Duration] - Delay between each key press
  ///
  Future<void> press({
    required String key,
    int times = 1,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
  }) async {
    throw UnimplementedError('press has not been implemented.');
  }

  /// Sets the keys to down state in order and releases then in reverse order
  ///
  /// `keys`: [List] of [String] - List of keys to press
  ///
  /// `times`: [int] - Amount of times to press the key
  ///
  /// `interval`: [Duration] - Delay between each key press
  ///
  Future<void> hotkey({
    required List<String> keys,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
  }) async {
    throw UnimplementedError('hotkey has not been implemented.');
  }
}
