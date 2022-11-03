import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/screens/game/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/selection_tile.dart';

class PlayerSelectionScreen extends StatelessWidget {
  final AudioPlayer player;
  final AudioPlayer bgm;
  const PlayerSelectionScreen({
    super.key,
    required this.player,
    required this.bgm,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg.jpg'),
                ),
              ),
              // width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectionTile(
                    playerNumber: '2P',
                    tileColor: Colors.red,
                    players: 2,
                    player: player,
                    bgm: bgm,
                  ),
                  SelectionTile(
                    playerNumber: '3P',
                    tileColor: Colors.blue,
                    players: 3,
                    player: player,
                    bgm: bgm,
                  ),
                  SelectionTile(
                    playerNumber: '4P',
                    tileColor: Colors.green,
                    players: 4,
                    player: player,
                    bgm: bgm,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onLongPress: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.home,
                    size: 25.w,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
