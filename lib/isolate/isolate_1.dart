import 'dart:isolate';

import 'package:flutter/material.dart';

class BouncingBallExample extends StatefulWidget {
  const BouncingBallExample({super.key});

  @override
  State<BouncingBallExample> createState() => _BouncingBallExampleState();
}

class _BouncingBallExampleState extends State<BouncingBallExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/animation/bouncing ball.gif"),
            const SizedBox(
              height: 20.0,
            ),

            // blocaking main ui
            ElevatedButton(
                onPressed: () {
                  print("fun run");
                  longTask();
                  print("fun complete");
                },
                child: const Text("Task 1")),
            const SizedBox(
              height: 20.0,
            ),
            // run isolate
            ElevatedButton(
                onPressed: () async {
                  final recivePort =
                      ReceivePort(); // create a recaving port to listen value from another thread pipe
                  await Isolate.spawn(longTask2, recivePort.sendPort);

                  // why we add async await ???....because isolate.spaen create
                  // a instance of a isolate thats why we use async await from waiting for
                  // instance making other wise flutter single thread avoid thius line

                  recivePort.listen((msg) {
                    print(msg); // do whet ever want to do man for this value
                  });
                },
                child: const Text("Task 2")),
          ],
        ),
      )),
    );
  }

  longTask() {
    var num = 0;

    for (var i = 0; i < 1000000000; i++) {
      num += i;
    }
    return num;
  }
}

longTask2(SendPort sendPort) {
  var num = 0;

  for (var i = 0; i < 1000000000; i++) {
    num += i;
  }
  sendPort.send(num);
}
