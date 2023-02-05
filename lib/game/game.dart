import 'package:dino_game/core/constants.dart';
import 'package:dino_game/game/dino.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino dino;
  late ParallaxComponent parallaxComponent;

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
    final dinoHeightWidth = size[1] * 0.2;
    final dinoX = size[0] * 0.1;

    parallaxComponent = await getParallaxComponent();
    add(parallaxComponent);

    double yLimit = size[1] - groundHeight - dinoHeightWidth + dinoSpritePadding;
    dino = Dino(yMax:yLimit);
    dino.height = dinoHeightWidth;
    dino.width = dinoHeightWidth;
    dino.x = dinoX;
    dino.y = yLimit;
    add(dino);
  }

  @override
  void onTap() {
    print("hey");
    dino.jump();
    // dino.spee
    super.onTap();
  }
}
