import 'package:flutter/material.dart';

List<Color> playerBgColor = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.orange,
];

enum GameMode {
  easy,
  normal,
  hard,
  extreme,
}

List listOfItems = [
  'assets/images/bg1.jpg',
  'assets/images/bg1.jpg',
  'assets/images/yugi2.png',
  'assets/images/saitama.png',
  'assets/images/saitama.png',
  'assets/images/axel.jpg',
  'assets/images/axel.jpg',
  'assets/images/yugi2.png',
  'assets/images/axelb.jpg',
  'assets/images/axelb.jpg',
  'assets/images/axelblaze.jpg',
  'assets/images/axelblaze.jpg',
  'assets/images/itachi.jpg',
  'assets/images/itachi.jpg',
  'assets/images/itachi1.jpg',
  'assets/images/itachi1.jpg',
  'assets/images/yami.jpg',
  'assets/images/yami.jpg',
  'assets/images/yugi1.jpg',
  'assets/images/yugi1.jpg',
  'assets/images/yato.png',
  'assets/images/yato.png',
  'assets/images/yugii.jpg',
  'assets/images/yugii.jpg',
];

// audio files
String narutoBgm = 'audio/Naruto-Naruto.mp3';
String noragamiBgm = 'audio/Noragami-Ost-Misogi.mp3';
String clickSound = 'audio/Click.mp3';

enum Players {
  player1,
  player2,
  // player3,
  // player4,
}
