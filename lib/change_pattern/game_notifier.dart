import 'dart:math';

import 'package:flutter/material.dart';

import '../count_repository.dart';

class GameNotifier extends ChangeNotifier {
  GameNotifier({@required CountRepository countRepository})
      : _countRepository = countRepository ?? CountRepository() {
    clearedCount = _countRepository.load();
    makeNextGame();
  }
  int a = 0, b = 0, x = 0, y = 0, target = 0;
  int clearedCount = 0;
  final CountRepository _countRepository;

  void makeNextGame() {
    do {
      a = Random().nextInt(30);
      b = Random().nextInt(30);
      target = Random().nextInt(200);
    } while (target % a.gcd(b) != 0); // クリア可能じゃなかったらa,b,targetを再生成
    notifyListeners();
  }

  void checkCleared() {
    if (a * x + b * y == target) {
      ++clearedCount;
      _countRepository.save(clearedCount);
      makeNextGame();
    }
  }

  void changeXY({@required bool isX, @required int value}) {
    if (isX) {
      x += value;
    } else {
      y += value;
    }
    checkCleared();
  }
}
