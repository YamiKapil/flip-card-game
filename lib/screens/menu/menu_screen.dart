import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import 'main_menu_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  bool isFirstChild = true;
  late ValueNotifier<CrossFadeState> _crossFadeStateNotifier;
  late ValueNotifier<bool> isPlaying;
  final player = AudioPlayer();
  final player2 = AudioPlayer();

  @override
  void initState() {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 700),
    // );
    _crossFadeStateNotifier = ValueNotifier(CrossFadeState.showFirst);
    isPlaying = ValueNotifier(true);
    player.setReleaseMode(ReleaseMode.loop);
    player.setVolume(0.3);
    player2.setVolume(0.3);
    playBgm();
    super.initState();
  }

  void showMainMenu() {
    _crossFadeStateNotifier.value = CrossFadeState.showFirst;
  }

  void showSettings() {
    _crossFadeStateNotifier.value = CrossFadeState.showSecond;
  }

  void playBgm() {
    isPlaying.value = true;
    player.play(AssetSource(narutoBgm));
  }

  void stopBgm() {
    player.pause();
    isPlaying.value = false;
  }

  @override
  void dispose() {
    player.dispose();
    player2.dispose();
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/bg.jpg'),
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  // vertical: MediaQuery.of(context).padding.top,
                  horizontal: 20.w,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ValueListenableBuilder(
                      valueListenable: isPlaying,
                      builder: (context, val, _) {
                        return IconButton(
                          onPressed: () {
                            val == true ? stopBgm() : playBgm();
                          },
                          icon: Icon(
                            (val == true) ? Icons.volume_up : Icons.volume_off,
                          ),
                          iconSize: 40.w,
                        );
                      }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: _crossFadeStateNotifier,
                      builder: (context, value, _) {
                        return AnimatedCrossFade(
                          firstChild: MainMenuScreen(
                            onSettingsPressed: showSettings,
                            player: player2,
                            bgm: player,
                          ),
                          secondChild: SettingsScreen(
                            player: player2,
                            onBackPressed: showMainMenu,
                          ),
                          crossFadeState: value,
                          duration: const Duration(milliseconds: 300),
                          secondCurve: Curves.easeIn,
                          firstCurve: Curves.easeInCubic,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
