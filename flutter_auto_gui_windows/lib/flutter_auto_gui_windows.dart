import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart';
import 'package:flutter_auto_gui_windows/types/keyboard_keys.dart';
export 'package:flutter_auto_gui_platform_interface/flutter_auto_gui_platform_interface.dart'
    show MouseButton, MouseButtonExtension;

const MethodChannel _channel = MethodChannel('flutter_auto_gui_windows');

enum _MouseAction { move, drag }

const int _minimumDuration = 100; // ms
const int _minimumSleep = 10; // ms

class FlutterAutoGuiWindows extends FlutterAutoGUIPlatform {
  /// Registers this class as the default instance of [FlutterAutoGUIPlatform].
  static void registerWith() {
    FlutterAutoGUIPlatform.instance = FlutterAutoGuiWindows();
  }

  @override
  Future<Point<int>?> position() async {
    Map<String, int>? mousePosition =
        await _channel.invokeMapMethod<String, int>('position');

    if (mousePosition != null) {
      return Point(mousePosition['x'] ?? 0, mousePosition['y'] ?? 0);
    }
    return null;
  }

  @override
  Future<void> moveTo({
    required Point<int> point,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    _moveOrDrag(
      point: point,
      action: _MouseAction.move,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Future<void> moveToRel({
    required Size offset,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    _moveOrDrag(
      offset: offset,
      action: _MouseAction.move,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Future<void> dragTo({
    required Point<int> point,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    _moveOrDrag(
      point: point,
      button: button,
      action: _MouseAction.drag,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Future<void> dragToRel({
    required Size offset,
    required MouseButton button,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    _moveOrDrag(
      offset: offset,
      button: button,
      action: _MouseAction.drag,
      duration: duration,
      curve: curve,
    );
  }

  @override
  Future<void> mouseDown({
    MouseButton button = MouseButton.left,
  }) async {
    await _channel.invokeMethod(
      'mouseDown',
      button.toShortString(),
    );
  }

  @override
  Future<void> mouseUp({
    MouseButton button = MouseButton.left,
  }) async {
    await _channel.invokeMethod(
      'mouseUp',
      button.toShortString(),
    );
  }

  @override
  Future<void> click({
    MouseButton button = MouseButton.left,
    int clicks = 1,
    Duration interval = Duration.zero,
  }) async {
    int sleep = interval.inMilliseconds < _minimumSleep
        ? _minimumSleep
        : interval.inMilliseconds;
    await _channel.invokeMethod(
      'click',
      {
        'button': button.toShortString(),
        'clicks': clicks,
        'interval': sleep,
      },
    );
  }

  @override
  Future<void> scroll({
    required int clicks,
    Axis axis = Axis.vertical,
  }) async {
    await _channel.invokeMethod(
      'scroll',
      {
        'axis': axis.toString(),
        'clicks': clicks,
      },
    );
  }

  @override
  Future<void> write({
    required String text,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
    bool omitInvalid = false,
  }) async {
    String newText = '';
    for (String character in text.characters) {
      if (!keyMapping.containsKey(character)) {
        if (!omitInvalid) {
          assert(
            false,
            'An invalid character was found: \' $character \'',
          );
        }
      } else {
        newText += character;
      }
    }
    await _channel.invokeMethod(
      'write',
      {
        'text': newText,
        'interval': interval.inMilliseconds,
      },
    );
  }

  @override
  Future<void> keyUp({
    required String key,
  }) async {
    assert(keyMapping.containsKey(key),
        'Invalid key. Key must be a supported string');
    int keyCode = keyMapping[key]! == 0x000
        ? await _convertCharacter(key)
        : keyMapping[key]!;

    await _channel.invokeMethod(
      'keyUp',
      keyCode,
    );
  }

  @override
  Future<void> keyDown({
    required String key,
  }) async {
    assert(keyMapping.containsKey(key),
        'Invalid key. Key must be a supported string');
    int keyCode = keyMapping[key]! == 0x000
        ? await _convertCharacter(key)
        : keyMapping[key]!;

    await _channel.invokeMethod(
      'keyDown',
      keyCode,
    );
  }

  @override
  Future<void> press({
    required String key,
    int times = 1,
    Duration interval = const Duration(
      milliseconds: 50,
    ),
  }) async {
    assert(keyMapping.containsKey(key),
        'Invalid key. Key must be a supported string');
    times = times < 0 ? 1 : times;
    int keyCode = keyMapping[key]! == 0x000
        ? await _convertCharacter(key)
        : keyMapping[key]!;

    await _channel.invokeMethod('press', {
      'key': keyCode,
      'times': times,
      'interval': interval.inMilliseconds,
    });
  }

  // Future<bool> _isShiftKey(String char) async {
  //   assert(char.length == 1);

  //   return char == char.toUpperCase()
  //       ? true
  //       : '~!@#\$%^&*()_+{}|:"<>?'.contains(char);
  // }

  Future<int> _convertCharacter(String char) async {
    assert(char.length == 1);
    int converted = await _channel.invokeMethod(
      'convertCharacter',
      char,
    );
    return converted;
  }

  Future<void> _moveOrDrag({
    required _MouseAction action,
    Point<int>? point,
    Size offset = const Size(0, 0),
    MouseButton button = MouseButton.left,
    Duration duration = Duration.zero,
    Curve curve = Curves.linear,
  }) async {
    // check to see if parameters results in no mouse movement at all
    if (point == null && offset.longestSide == 0.0) {
      return;
    }

    Point<int>? currentMousePosition = await position();
    if (currentMousePosition == null) return;

    // set point to current mouse position if point is null;
    point = point ?? currentMousePosition;

    point += Point(
      offset.width.toInt(),
      offset.height.toInt(),
    );

    // list to hold points to move the mouse at overtime if curve is present
    // converted as a primative type to use in method call
    List<Map<String, int>> steps = [
      {
        'x': point.x,
        'y': point.y,
      }
    ];
    // check to see if duration is above threshold. If it is, apply tween.
    int sleepTimePerStep = 0; // ms
    if (duration.inMilliseconds >= _minimumDuration) {
      int numberOfSteps = duration.inMilliseconds ~/ _minimumSleep;
      sleepTimePerStep = duration.inMilliseconds ~/ numberOfSteps;

      for (var i = numberOfSteps - 1; i >= 0; i--) {
        Point<int> p = await _getPointOnLine(
          p1: currentMousePosition,
          p2: point,
          n: curve.transform(i / numberOfSteps),
        );
        steps.insert(0, {
          'x': p.x,
          'y': p.y,
        });
      }
    }

    switch (action) {
      case _MouseAction.move:
        await _channel.invokeMethod<void>('move', <String, dynamic>{
          'sleep': sleepTimePerStep,
          'steps': steps,
        });

        break;
      case _MouseAction.drag:
        await _channel.invokeMethod<void>('drag', <String, dynamic>{
          'sleep': sleepTimePerStep,
          'steps': steps,
          'button': button.toShortString()
        });
        break;
    }
  }

  Future<Point<int>> _getPointOnLine({
    required Point p1,
    required Point p2,
    required double n,
  }) async {
    assert(n >= 0.0 && n <= 1.0, "parameter n must be between 0.0 and 1.0");

    int x = (((p2.x - p1.x) * n) + p1.x).toInt();
    int y = (((p2.y - p1.y) * n) + p1.y).toInt();
    return Point(x, y);
  }
}
