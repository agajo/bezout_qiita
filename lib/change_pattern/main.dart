import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Bézout's identity")),
          body: DefaultTextStyle(
            style: TextStyle(fontSize: 30, color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Question(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [UpDown(isX: true), UpDown(isX: false)],
                ),
                const SizedBox(height: 30),
                Text("クリア回数: 3", style: TextStyle(fontSize: 25)),
              ],
            ),
          )),
    );
  }
}

class Question extends StatelessWidget {
  const Question();
  @override
  Widget build(BuildContext context) {
    const a = 11;
    const b = 7;
    const x = 3;
    const y = 4;
    const target = 61;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$a'),
        Text('x'),
        Container(
            padding: EdgeInsets.all(3),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
            child: Text(
              '$x',
              style: TextStyle(color: Colors.red),
            )),
        Text('+'),
        Text('$b'),
        Text('x'),
        Container(
            padding: EdgeInsets.all(3),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
            child: Text(
              '$y',
              style: TextStyle(color: Colors.blue),
            )),
        Text('='),
        Text('$target'),
      ],
    );
  }
}

class UpDown extends StatelessWidget {
  const UpDown({@required this.isX});
  final bool isX;
  @override
  Widget build(BuildContext context) {
    final color = isX ? Colors.red : Colors.blue;
    return Column(
      children: [
        Icon(Icons.arrow_upward, size: 60, color: color),
        SizedBox(width: 165),
        Icon(Icons.arrow_downward, size: 60, color: color),
      ],
    );
  }
}
