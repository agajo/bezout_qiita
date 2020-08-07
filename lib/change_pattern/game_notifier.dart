import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../count_repository.dart';

class GameNotifier extends ChangeNotifier {
  GameNotifier({CountRepository countRepository})
      : _countRepository = countRepository ?? CountRepository() {
    makeNextGame();
    _countRepository.load().then((value) {
      clearedCount = value;
      notifyListeners();
    });
  }
  int a = 0, b = 0, x = 0, y = 0, target = 0;
  int clearedCount = 0;
  int pressedCount = 0;
  bool justCleared = false;
  final CountRepository _countRepository;

  void makeNextGame() {
    do {
      // aとbは2以上
      a = Random().nextInt(30) + 2;
      b = Random().nextInt(30) + 2;
      target = Random().nextInt(200);
    } while (target % a.gcd(b) != 0); // クリア可能じゃなかったらa,b,targetを再生成
    notifyListeners();
  }

  void checkCleared() {
    if (a * x + b * y == target) {
      justCleared = true;
      notifyListeners();
      Timer(const Duration(milliseconds: 3000), () {
        justCleared = false;
        ++clearedCount;
        x = 0;
        y = 0;
        _countRepository.save(clearedCount);
        makeNextGame();
      });
    }
  }

  void changeXY({@required bool isX, @required int value}) {
    if (isX) {
      x += value;
    } else {
      y += value;
    }
    ++pressedCount;
    notifyListeners();
    checkCleared();
  }
}
