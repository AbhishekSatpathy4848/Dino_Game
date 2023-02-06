import 'package:dino_game/core/constants.dart';
import 'package:dino_game/game/dino.dart';
import 'package:dino_game/game/enemy.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';

class DinoGame extends FlameGame with TapDetector {
  late Dino dino;
  late ParallaxComponent parallaxComponent;
  int score = 0;
  late TextComponent scoreTextComponent;

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

    parallaxComponent = await getParallaxComponent();
    add(parallaxComponent);

    scoreTextComponent = TextComponent(text: score.toString());
    scoreTextComponent.x = size[0] * 0.5 - scoreTextComponent.width * 0.5;
    add(scoreTextComponent);

    dino = Dino();
    
    add(dino);

    Enemy enemyAngryPig = Enemy(enemyType: EnemyType.angryPig, xMax: size[0]);
    add(enemyAngryPig);

    Enemy enemyBat = Enemy(enemyType: EnemyType.bat, xMax: size[0]);
    add(enemyBat);
  }

  @override
  void onTap() {
    dino.jump();
    super.onTap();
  }

  @override
  void update(double dt) {
    score = score + (60 * dt).toInt();
    scoreTextComponent.text = score.toString();

    

    super.update(dt);
  }
}
