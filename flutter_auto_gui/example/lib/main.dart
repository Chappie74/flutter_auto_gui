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
  final _mouseAPI = FlutterAutoGUIMouse();
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
                                  Point<int>? p = await _mouseAPI.position();
                                  controller.text =
                                      'Mouse Position = ${p.toString()}';
                                },
                                child: const Text('Mouse Position'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await _mouseAPI.moveTo(
                                    point: const Point(10, 10),
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text('Move to 10, 10'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await _mouseAPI.moveToRel(
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
                                  await _mouseAPI.dragTo(
                                    point: const Point(100, 100),
                                    button: MouseButton.left,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text(
                                    'Drag to 100, 100 (2 seconds delay)'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await _mouseAPI.dragToRel(
                                    offset: const Size(200, 300),
                                    button: MouseButton.left,
                                    duration: const Duration(seconds: 1),
                                  );
                                },
                                child: const Text(
                                    'Drag to rel 100, 0 (2 seconds delay)'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await _mouseAPI.mouseDown(
                                    button: MouseButton.left,
                                  );
                                },
                                child: const Text(
                                    'Set Left Button Down (2 seconds delay)'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await _mouseAPI.mouseDown(
                                    button: MouseButton.left,
                                  );
                                },
                                child: const Text(
                                    'Set Left Button Up (2 seconds delay)'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  await _mouseAPI.click(
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
                                  await _mouseAPI.click(
                                    button: MouseButton.left,
                                    clicks: 2,
                                  );
                                },
                                child: const Text('Double click left button'),
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
                            children: [],
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
                            children: [],
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
