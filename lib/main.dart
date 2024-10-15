import 'package:dart_isolate/isolate/isolate_1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DartIsolate());
}

class DartIsolate extends StatelessWidget {
  const DartIsolate({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BouncingBallExample(),
    );
  }
}
