import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'game_controller.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

final gameControllerProvider = StateNotifierProvider((ref) => GameController());

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text("Bézout's identity")),
          body: DefaultTextStyle(
            style: const TextStyle(fontSize: 30, color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Question(),
                const ClearedMessage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [UpDown(isX: true), UpDown(isX: false)],
                ),
                const SizedBox(height: 30),
                const ClearedCount(),
              ],
            ),
          )),
    );
  }
}

class ClearedCount extends HookWidget {
  const ClearedCount({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clearedCount = useProvider(gameControllerProvider.state).clearedCount;
    return Text('クリア数: $clearedCount', style: const TextStyle(fontSize: 25));
  }
}

class Question extends HookWidget {
  const Question();
  @override
  Widget build(BuildContext context) {
    final gameState = useProvider(gameControllerProvider.state);
    final a = gameState.a;
    final b = gameState.b;
    final x = gameState.x;
    final y = gameState.y;
    final target = gameState.target;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('$a'),
        const Text('x'),
        Container(
            padding: const EdgeInsets.all(3),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.red, width: 3)),
            child: Text(
              '$x',
              style: const TextStyle(color: Colors.red),
            )),
        const Text('+'),
        Text('$b'),
        const Text('x'),
        Container(
            padding: const EdgeInsets.all(3),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue, width: 3)),
            child: Text(
              '$y',
              style: const TextStyle(color: Colors.blue),
            )),
        const Text('='),
        Text('$target'),
      ],
    );
  }
}

class UpDown extends HookWidget {
  const UpDown({@required this.isX});
  final bool isX;
  @override
  Widget build(BuildContext context) {
    final justCleared = useProvider(gameControllerProvider.state).justCleared;
    final color = isX ? Colors.red : Colors.blue;
    return Column(
      children: [
        IconButton(
          iconSize: 60,
          icon: Icon(Icons.arrow_upward, color: color),
          onPressed: justCleared
              ? null
              : () {
                  gameControllerProvider
                      .read(context)
                      .changeXY(isX: isX, value: 1);
                },
        ),
        const SizedBox(width: 165),
        IconButton(
          iconSize: 60,
          icon: Icon(Icons.arrow_downward, color: color),
          onPressed: justCleared
              ? null
              : () {
                  gameControllerProvider
                      .read(context)
                      .changeXY(isX: isX, value: -1);
                },
        ),
      ],
    );
  }
}

class ClearedMessage extends HookWidget {
  const ClearedMessage();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Center(
          child: useProvider(gameControllerProvider.state).justCleared
              ? const Text(
                  'Cleared!',
                  style: TextStyle(fontSize: 25, color: Colors.amber),
                )
              : Container()),
    );
  }
}
