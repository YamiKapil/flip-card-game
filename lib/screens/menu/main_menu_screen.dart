import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../../widgets/menu_items.dart';
import '../player_selection/player_selection_screen.dart';

class MainMenuScreen extends StatelessWidget {
  final VoidCallback onSettingsPressed;
  final AudioPlayer player;
  final AudioPlayer bgm;
  const MainMenuScreen({
    Key? key,
    required this.onSettingsPressed,
    required this.player,
    required this.bgm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItems(
            icon: Icons.play_arrow_rounded,
            text: 'Play',
            function: () {
              player.play(AssetSource(clickSound));
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlayerSelectionScreen(
                    player: player,
                    bgm: bgm,
                  ),
                ),
              );
            },
          ),
          MenuItems(
            icon: Icons.settings,
            text: 'Settings',
            // function: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const TapPuzzleSettings(),
            //   ),
            // ),
            function: () {
              player.play(AssetSource(clickSound));
              onSettingsPressed();
            },
          ),
          MenuItems(
            icon: Icons.info_outline_rounded,
            text: 'Info',
            function: () {
              player.play(AssetSource(clickSound));
            },
          ),
          MenuItems(
            icon: Icons.logout_outlined,
            text: 'Exit',
            function: () async {
              await player.play(AssetSource(clickSound));
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
    );
  }
}
