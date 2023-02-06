import 'package:dino_game/core/constants.dart';
import 'package:dino_game/game/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.setLandscape();
  await Flame.device.fullScreen();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late DinoGame _dinoGame;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _dinoGame = DinoGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GameWidget(
      game: _dinoGame,
      overlayBuilderMap: {
        kOverlaysPlayPauseButton: (context, DinoGame game) {
          return GestureDetector(
            child: Icon(
              isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              size: 50,
              color: Colors.white,
            ),
            onTap: () {
              isPaused ? game.resumeEngine() : game.pauseEngine();
              setState(() {
                isPaused = !isPaused;
              });
            },
          );
        }
      },
    ));
  }
}
