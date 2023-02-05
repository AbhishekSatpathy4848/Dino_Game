import 'package:dino_game/core/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Dino extends SpriteAnimationComponent {
  late SpriteAnimation idleDinoAnimation;
  late SpriteAnimation runningDinoAnimation;
  late SpriteAnimation kickDinoAnimation;
  late SpriteAnimation hitDinoAnimation;
  late SpriteAnimation sprintDinoAnimation;
  double dinoSpeedY = 0.0;
  double gravity = 0.0;
  double yMax;

  Dino({required this.yMax}) {
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
  void update(double dt) {
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

  void hit() {
    animation = hitDinoAnimation;
  }

  void sprint() {
    animation = sprintDinoAnimation;
  }

  void jump() {
    if (onGround()) {
      dinoSpeedY = -300.0;
      gravity = 1200.0;
    }
  }
}
