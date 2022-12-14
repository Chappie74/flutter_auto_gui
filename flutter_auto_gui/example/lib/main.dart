import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auto_gui/flutter_auto_gui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Auto GUI'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Mouse API'),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Point<int>? p =
                                      await FlutterAutoGUI.position();
                                  controller.text =
                                      'Mouse Position = ${p.toString()}';
                                },
                                child: const Text('Mouse Position'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await FlutterAutoGUI.moveTo(
                                    point: const Point(10, 10),
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text('Move to 10, 10'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await FlutterAutoGUI.moveToRel(
                                    offset: const Size(100, -100),
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text('Move to rel 100, -100'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.dragTo(
                                    point: const Point(100, 100),
                                    button: MouseButton.left,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text('Drag to 100, 100'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.dragToRel(
                                    offset: const Size(200, 300),
                                    button: MouseButton.left,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text('Drag to rel 100, 0'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.mouseDown(
                                    button: MouseButton.left,
                                  );
                                },
                                child: const Text('Set Left Button Down'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.mouseDown(
                                    button: MouseButton.left,
                                  );
                                },
                                child: const Text('Set Left Button Up'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.click(
                                    button: MouseButton.left,
                                    clicks: 1,
                                  );
                                },
                                child: const Text('Single click left button'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.click(
                                    button: MouseButton.left,
                                    clicks: 2,
                                  );
                                },
                                child: const Text('Double click left button'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.scroll(
                                    axis: Axis.vertical,
                                    clicks: 5,
                                  );
                                },
                                child: const Text(
                                    'Vertical Scroll up for 5 clicks'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await FlutterAutoGUI.scroll(
                                    axis: Axis.horizontal,
                                    clicks: 5,
                                  );
                                },
                                child: const Text(
                                    'Horizontal Scroll right for 5 clicks'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Keyboard API'),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  FlutterAutoGUI.keyDown(key: 'w');
                                },
                                child: const Text('W key down'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  FlutterAutoGUI.keyUp(key: 'w');
                                },
                                child: const Text('W key up'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  FlutterAutoGUI.press(
                                    key: 'w',
                                    times: 2,
                                    interval: const Duration(
                                      seconds: 2,
                                    ),
                                  );
                                },
                                child: const Text(
                                    'Press W key up 2 time over 2 seconds'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  FlutterAutoGUI.write(
                                    text: 'hellO wOrld!',
                                    interval: const Duration(
                                      milliseconds: 50,
                                    ),
                                  );
                                },
                                child: const Text('Writes \'hellO wOrld!\''),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  FlutterAutoGUI.hotkey(
                                    keys: ['ctrl', 'shift', 'esc'],
                                  );
                                },
                                child: const Text(
                                    'Hotkey (control + shift + escape)'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('Screen API'),
                          Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: const [],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
