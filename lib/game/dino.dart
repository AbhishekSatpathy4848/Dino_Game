import 'package:dino_game/core/constants.dart';
import 'package:dino_game/game/enemy_handler.dart';
import 'package:flame/components.dart' hide Timer;
import 'package:flame/flame.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class Dino extends SpriteAnimationComponent {
  late SpriteAnimation idleDinoAnimation;
  late SpriteAnimation runningDinoAnimation;
  late SpriteAnimation kickDinoAnimation;
  late SpriteAnimation hitDinoAnimation;
  late SpriteAnimation sprintDinoAnimation;
  late EnemyHandler enemyHandler;
  late double yMax;
  double dinoSpeedY = 0.0;
  double gravity = 0.0;
  late Timer hitTimer;
  bool isHit = false;
  ValueNotifier<int> dinoHealth = ValueNotifier(kHealthHeartsNumber);

  Dino() : super() {
    Flame.images.load('DinoSprites-tard.png').then((spriteSheet) {
      SpriteAnimationData idleDinoAnimationData = SpriteAnimationData.range(
          amount: totalDinoSpritesNumber,
          start: idleDinoSprites.first,
          end: idleDinoSprites[1],
          stepTimes: List.generate(
              getIdleDinoSpritesNumber() + 1, (index) => frameDuration),
          textureSize: Vector2(24, 24));

      idleDinoAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, idleDinoAnimationData);

      SpriteAnimationData runningDinoAnimationData = SpriteAnimationData.range(
          amount: totalDinoSpritesNumber,
          start: runningDinoSprites.first,
          end: runningDinoSprites[1],
          stepTimes: List.generate(
              getRunningDinoSpritesNumber() + 1, (index) => frameDuration),
          textureSize: Vector2(24, 24));

      runningDinoAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, runningDinoAnimationData);

      SpriteAnimationData kickDinoAnimationData = SpriteAnimationData.range(
          amount: totalDinoSpritesNumber,
          start: kickDinoSprites.first,
          end: kickDinoSprites[1],
          stepTimes: List.generate(
              getKickDinoSpritesNumber() + 1, (index) => frameDuration),
          textureSize: Vector2(24, 24));

      kickDinoAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, kickDinoAnimationData);

      SpriteAnimationData hitDinoAnimationData = SpriteAnimationData.range(
          amount: totalDinoSpritesNumber,
          start: hitDinoSprites.first,
          end: hitDinoSprites[1],
          stepTimes: List.generate(
              getHitDinoSpritesNumber() + 1, (index) => frameDuration),
          textureSize: Vector2(24, 24));

      hitDinoAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, hitDinoAnimationData);

      SpriteAnimationData sprintDinoAnimationData = SpriteAnimationData.range(
          amount: totalDinoSpritesNumber,
          start: sprintDinoSprites.first,
          end: sprintDinoSprites[1],
          stepTimes: List.generate(
              getSprintDinoSpritesNumber() + 1, (index) => frameDuration),
          textureSize: Vector2(24, 24));

      sprintDinoAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, sprintDinoAnimationData);

      run();

      return this;
    });
  }

  @override
  void onGameResize(Vector2 size) {
    height = size.y * 0.2;
    width = size.y * 0.2;
    x = size.x * 0.1;
    y = size.y - groundHeight - height + dinoSpritePadding;
    yMax = y;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // hitTimer.update(dt);
    dinoSpeedY = dinoSpeedY + gravity * dt;
    y = y + dinoSpeedY * 5 * dt;
    if (onGround()) {
      dinoSpeedY = 0;
      gravity = 0;
      y = yMax;
    }

    super.update(dt);
  }

  bool onGround() {
    if (y >= yMax) {
      return true;
    }
    return false;
  }

  void idle() {
    animation = idleDinoAnimation;
  }

  void run() {
    animation = runningDinoAnimation;
  }

  void kick() {
    animation = kickDinoAnimation;
  }

  void hit() async {
    if (!isHit) {
      hitTimer = Timer(const Duration(milliseconds: 800), () {
        run();
        isHit = false;
      });
      animation = hitDinoAnimation;
      dinoHealth.value--;
      isHit = true;
      // Clipboard.setData(const ClipboardData());
      // HapticFeedback.heavyImpact();
      // if(await Vibration.hasVibrator() ?? false) {
      // Vibration.vibrate(duration: 1000);
      // }
    }
  }

  void sprint() {
    animation = sprintDinoAnimation;
  }

  void jump() {
    if (onGround()) {
      dinoSpeedY = -220.0;
      gravity = 500.0;
    }
  }
}
