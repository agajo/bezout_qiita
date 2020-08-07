import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:state_notifier/state_notifier.dart';

import '../count_repository.dart';
import 'game_state.dart';

class GameController extends StateNotifier<GameState> {
  GameController({CountRepository countRepository})
      : _countRepository = countRepository ?? CountRepository(),
        super(GameState()) {
    makeNextGame();
    _countRepository.load().then((value) {
      state = state.copyWith(clearedCount: value);
    });
  }
  final CountRepository _countRepository;
  int pressedCount = 0;

  void makeNextGame() {
    int a, b, target;
    do {
      // aとbは2以上
      a = Random().nextInt(30) + 2;
      b = Random().nextInt(30) + 2;
      target = Random().nextInt(200);
    } while (target % a.gcd(b) != 0); // クリア可能じゃなかったらa,b,targetを再生成
    state = state.copyWith(a: a, b: b, target: target);
  }

  void checkCleared() {
    if (state.a * state.x + state.b * state.y == state.target) {
      state = state.copyWith(justCleared: true);
      Timer(const Duration(milliseconds: 3000), () {
        state = state.copyWith(
            justCleared: false,
            clearedCount: state.clearedCount + 1,
            x: 0,
            y: 0);
        _countRepository.save(state.clearedCount);
        makeNextGame();
      });
    }
  }

  void changeXY({@required bool isX, @required int value}) {
    if (isX) {
      state = state.copyWith(x: state.x + 1);
    } else {
      state = state.copyWith(y: state.y + 1);
    }
    ++pressedCount;
    checkCleared();
  }
}
