import 'package:dino_game/game.dart';
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

  @override
  void initState() {
    super.initState();
    _dinoGame = DinoGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: _dinoGame,));
  }
}
