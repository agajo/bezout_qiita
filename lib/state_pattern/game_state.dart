import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  factory GameState({
    @Default(0) int a,
    @Default(0) int b,
    @Default(0) int x,
    @Default(0) int y,
    @Default(0) int target,
    @Default(0) int clearedCount,
    @Default(false) bool justCleared,
  }) = _GameState;
}
