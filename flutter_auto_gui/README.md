# flutter_auto_gui

A flutter plugin for desktop applications for controlling mouse and keyboard to automate interactions with other applications. This plugin is highly inspired by the [PyAutoGui](https://pyautogui.readthedocs.io/en/latest/) python package and [RobotJs](http://robotjs.io/) and as such tries to mimic most of the available methods.

|             | Android | iOS | Linux      | macOS      | Windows     |
| ----------- | ------- | --- | ---------- | ---------- | ----------- |
| **Support** | N/A     | N/A | Future Dev | Future Dev | Windows 10+ |

# Usage

To use this plugin add `flutter_auto_gui` as a [dependency in your pubspec.yaml file](https://docs.flutter.dev/development/platform-integration/platform-channels?tab=type-mappings-c-plus-plus-tab).

```yaml
dependencies:
    flutter_auto_gui: <version>
```

Import the package

```dart
import 'package:flutter_auto_gui/flutter_auto_gui.dart';
```

All functions are static and can be used like the following

```dart
// mouse move function
 await FlutterAutoGUI.moveTo(
    point: const Point(10, 10),
    duration: const Duration(seconds: 1),
);
```

Check out the [`example`][2] project for further assistance.

A compresive [`documentation`][1] can be found [`here`][1]

<br>

## Contributions

I'm currently working on getting the `screen` functions ([`1`][4], [`2`][5]) implemented.

If anyone would like to assist on the Mac OS / Linux implementation you can follow the [`flutter federated plugin`][3] design and I would be more than happy to endorse it.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Chappie74/flutter_auto_gui/issues).

If you fixed a bug or implemented a new feature, please send a [pull request](https://github.com/Chappie74/flutter_auto_gui/pulls).

[1]: https://flutter-auto-gui.chappie.dev/
[2]: https://github.com/Chappie74/flutter_auto_gui/blob/main/flutter_auto_gui/example/lib/main.dart
[3]: https://docs.flutter.dev/development/packages-and-plugins/developing-packages#federated-plugins
[4]: https://pyautogui.readthedocs.io/en/latest/screenshot.html
[5]: http://robotjs.io/docs/syntax#getpixelcolorx-y
