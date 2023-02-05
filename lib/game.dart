import 'package:dino_game/core/constants.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';

class DinoGame extends FlameGame {
  // SpriteAnimationComponent? idleDinoAnimation;
  // SpriteAnimationComponent? dinoAnimation;
  // ParallaxComponent? parallaxComponent;

  SpriteAnimationComponent getDinoIdleAnimationComponent(
      Image spriteSheet, Vector2 spriteSize) {
    SpriteAnimationData idleAnimationData = SpriteAnimationData.range(
        amount: totalDinoSpritesNumber,
        start: idleDinoSprites.first,
        end: idleDinoSprites[1],
        stepTimes: List.generate(
            getIdleDinoSpritesNumber() + 1, (index) => frameDuration),
        textureSize: Vector2(24, 24));

    return SpriteAnimationComponent.fromFrameData(
        spriteSheet, idleAnimationData)
      ..size = spriteSize;
  }

  SpriteAnimationComponent getDinoRunningAnimationComponent(
      Image spriteSheet, Vector2 spriteSize) {
    SpriteAnimationData runningAnimationData = SpriteAnimationData.range(
        amount: totalDinoSpritesNumber,
        start: runningDinoSprites.first,
        end: runningDinoSprites[1],
        stepTimes: List.generate(
            getRunningDinoSpritesNumber() + 1, (index) => frameDuration),
        textureSize: Vector2(24, 24));

    return SpriteAnimationComponent.fromFrameData(
        spriteSheet, runningAnimationData)
        ..y = size[1]- 31 - size[0] * 0.1
      ..size = spriteSize;
  }

  Future<ParallaxComponent> getParallaxComponent() async {
    final parallaxImages = [
      await loadParallaxImage('plx-1.png'),
      await loadParallaxImage('plx-2.png'),
      await loadParallaxImage('plx-3.png'),
      await loadParallaxImage('plx-4.png'),
      await loadParallaxImage('plx-5.png'),
      await loadParallaxImage('ground_dino.png', fill: LayerFill.none),
    ];

    final parallaxLayers = parallaxImages.map((image) {
      return ParallaxLayer(image,
          velocityMultiplier: Vector2(parallaxImages.indexOf(image) * 4, 0));
    });

    return ParallaxComponent(
        parallax: Parallax(parallaxLayers.toList(),
            baseVelocity: Vector2(baseVelocity, 0)));
  }

  @override
  Future<void> onLoad() async {
    add(await getParallaxComponent());

    //define sprite size
    final spriteSize = Vector2(size[0] * 0.1, size[0] * 0.1);
    //load the spritesheet
    Image spriteSheet = await images.load('DinoSprites-tard.png');

    add(getDinoRunningAnimationComponent(spriteSheet, spriteSize));
  }
}
