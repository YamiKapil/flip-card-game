import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/game/game_screen.dart';

class SelectionTile extends StatelessWidget {
  final String playerNumber;
  final Color tileColor;
  final VoidCallback? onTap;
  final int players;
  final AudioPlayer player;
  final AudioPlayer bgm;
  const SelectionTile({
    super.key,
    required this.playerNumber,
    required this.tileColor,
    this.onTap,
    required this.players,
    required this.player,
    required this.bgm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          bgm.stop();
          player.play(AssetSource(clickSound));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(players: players, bgm: bgm),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: ScreenUtil().screenHeight * 0.6,
          width: ScreenUtil().screenWidth * 0.3,
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: FittedBox(
            child: Text(
              playerNumber,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
