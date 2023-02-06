import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:dino_game/core/constants.dart';

enum EnemyType {
  angryPig,
  bat,
}

class EnemyData {
  final String spriteSheetPath;
  final int totalSprites;
  final double spriteFrameDurations;
  final Vector2 textureSize;
  final Vector2 speed;
  final double enemySpritePadding;

  const EnemyData(
      {required this.spriteSheetPath,
      required this.totalSprites,
      required this.spriteFrameDurations,
      required this.textureSize,
      required this.speed,
      required this.enemySpritePadding});
}

Map<EnemyType, EnemyData> enemyMap = {
  EnemyType.angryPig: EnemyData(
    spriteSheetPath: 'AngryPig.png',
    totalSprites: 16,
    spriteFrameDurations: frameDuration,
    textureSize: Vector2(36, 36),
    speed: Vector2(-200, 0),
    enemySpritePadding: 16,
  ),
  EnemyType.bat: EnemyData(
    spriteSheetPath: 'Bat.png',
    totalSprites: 7,
    spriteFrameDurations: frameDuration,
    textureSize: Vector2(46, 46),
    speed: Vector2(-250, 0),
    enemySpritePadding: 10,
  ),
};

class Enemy extends SpriteAnimationComponent{
  double xMax;
  EnemyType enemyType;

  Enemy({required this.enemyType, required this.xMax}) : super() {
    SpriteAnimationData spriteAnimationData = SpriteAnimationData.sequenced(
      amount: enemyMap[enemyType]!.totalSprites,
      stepTime: enemyMap[enemyType]!.spriteFrameDurations,
      textureSize: enemyMap[enemyType]!.textureSize,
    );
    Flame.images.load(enemyMap[enemyType]!.spriteSheetPath).then((spriteSheet) {
      SpriteAnimation spriteAnimation =
          SpriteAnimation.fromFrameData(spriteSheet, spriteAnimationData);
      animation = spriteAnimation;
      return this;
    });
  }

  @override
  void onGameResize(Vector2 size) {
    height = size[1] * 0.2;
    width = size[1] * 0.2;
    x = size[0];
    y = size[1] -
        groundHeight -
        height +
        enemyMap[EnemyType.angryPig]!.enemySpritePadding;
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    x += enemyMap[enemyType]!.speed[0] * dt;
    if (x <= -enemyMap[enemyType]!.textureSize[0]) x = xMax;
    super.update(dt);
  }
}
