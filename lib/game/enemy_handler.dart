import 'dart:math';
import 'package:dino_game/game/enemy.dart';
import 'package:dino_game/game/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class EnemyHandler extends Component with HasGameRef<DinoGame> {
  late Random random;
  late Timer timer;
  int spawnWaitTime = 3;

  EnemyHandler() : super() {
    random = Random();
    timer = Timer(spawnWaitTime.toDouble(), repeat: true, onTick: (() {
      spawnEnemy();
    }));
  }

  void spawnEnemy() {
    int enemyNumber = random.nextInt(EnemyType.values.length);
    EnemyType enemyType = EnemyType.values[enemyNumber];
    Enemy enemy = Enemy(enemyType);
    gameRef.add(enemy);
  }

  @override
  void update(double dt) {
    // int newSpawnWaitTime = (gameRef.score ~/ 100) + spawnWaitTime;

    // if (newSpawnWaitTime < spawnWaitTime) {
    //   timer.stop();
    //   timer = Timer(newSpawnWaitTime.toDouble(), repeat: true, onTick: (() {
    //     debugPrint('Enemy spawned');
    //     spawnEnemy();
    //   }));
    // }
    timer.update(dt);
    super.update(dt);
  }
}
