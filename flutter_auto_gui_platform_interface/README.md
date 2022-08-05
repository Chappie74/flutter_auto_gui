# flutter_auto_gui_platform_interface

A common platform interface for the [`flutter_auto_gui`][1] plugin.

This interface allows platform-specific implementations of the `flutter_auto_gui`
plugin, as well as the plugin itself, to ensure they are supporting the
same interface.

# Usage

To implement a new platform-specific implementation of `flutter_auto_gui`, extend
[`FlutterAutoGUIPlatform`][2] with an implementation that performs the
platform-specific behavior, and when you register your plugin, set the default
`FlutterAutoGUIPlatform` by calling
`FlutterAutoGUIPlatform.instance = MyFlutterAutoGUIPlatform()`.

# Note on breaking changes

Strongly prefer non-breaking changes (such as adding a method to the interface)
over breaking changes for this package.

See https://flutter.dev/go/platform-interface-breaking-changes for a discussion
on why a less-clean interface is preferable to a breaking change.

[1]: https://github.com/Chappie74/flutter_auto_gui/tree/main/flutter_auto_gui
[2]: https://github.com/Chappie74/flutter_auto_gui/blob/main/flutter_auto_gui_platform_interface/lib/src/platform_interface/flutter_auto_gui_platform_interface.dart
