import 'dart:developer';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/screens/menu/menu_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import '../../widgets/flip_animation.dart';
import '../../widgets/game_end_widget.dart';
import '../../widgets/player_widget.dart';

class GameScreen extends StatefulWidget {
  final int players;
  final AudioPlayer bgm;
  const GameScreen({
    super.key,
    required this.players,
    required this.bgm
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  List<FlipController> flipController = [];
  List twoTaps = [];
  List twoTapsElement = [];
  List totalItems = [];
  final random = math.Random();
  dynamic images;
  dynamic player = -1;
  int player1Score = 0;
  int player2Score = 0;
  int player3Score = 0;
  int player4Score = 0;
  List numberOfPlayers = [];
  List<Color> bgColor = [];
  late AnimationController colorAnimation;
  late Animation<double> animation;
  bool gameStarted = false;

  @override
  void initState() {
    images = listOfItems..shuffle();
    setPlayers();
    player = numberOfPlayers[0];
    setPlayerBgColor();
    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    colorAnimation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 30 * math.pi,
    ).animate(colorAnimation)
      ..addListener(() {});
    // changeBackgroundColor();
    super.initState();
  }

  startAnimation() {
    colorAnimation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 0,
      end: 30 * math.pi,
    ).animate(colorAnimation)
      ..addListener(() {});
  }

  changeBackgroundColor() {
    colorAnimation.forward();
  }

  setPlayers() {
    numberOfPlayers = List.generate(
      widget.players,
      (index) => index,
    );
  }

  setPlayerBgColor() {
    for (var i = 0; i <= numberOfPlayers.length - 1; i++) {
      bgColor.add(playerBgColor[i]);
    }
  }

  resetGame() {
    setState(() {
      twoTaps.clear();
      twoTapsElement.clear();
      for (var i = 0; i < totalItems.length; i++) {
        flipController[i].isFront = true;
      }
      player = numberOfPlayers[0];
      player1Score = 0;
      player2Score = 0;
      player3Score = 0;
      player4Score = 0;
      images = listOfItems..shuffle();
      totalItems.clear();
      gameStarted = false;
    });
  }

  @override
  void dispose() {
    flipController.map((e) => e.dispose());
    colorAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(player1Score.toString(), name: 'score1');
    log(player2Score.toString(), name: 'score2');
    log(player3Score.toString(), name: 'score3');
    log(player4Score.toString(), name: 'score4');
    log('build rebuild');
    log(player.toString());
    log(numberOfPlayers.length.toString(), name: 'number of players');
    log(bgColor.toString(), name: 'bg color');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          // color: (player == numberOfPlayers[0])
          //     ? (gameStarted)
          //         ? bgColor.last
          //         : Colors.white
          //     : (player == numberOfPlayers[1])
          //         ? bgColor[player - 1]
          //         : (player == numberOfPlayers[2] && numberOfPlayers[2] != null)
          //             ? bgColor[player - 1]
          //             : (player == numberOfPlayers[3] &&
          //                     numberOfPlayers[3] != null)
          //                 ? bgColor[player - 1]
          //                 : Colors.white,
          color: (player == numberOfPlayers[0])
              ? bgColor[player]
              : (player == numberOfPlayers[1])
                  ? bgColor[player]
                  : (player == numberOfPlayers[2] && numberOfPlayers[2] != null)
                      ? bgColor[player]
                      : (player == numberOfPlayers[3] &&
                              numberOfPlayers[3] != null)
                          ? bgColor[player]
                          : null,

          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Stack(
              children: [
                Center(
                  child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Transform.scale(
                          scale: animation.value,
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: (player == numberOfPlayers[0])
                                  ? Colors.red
                                  : (player == numberOfPlayers[1])
                                      ? Colors.blue
                                      : (player == numberOfPlayers[2] &&
                                              numberOfPlayers[2] != null)
                                          ? Colors.green
                                          : (player == numberOfPlayers[3] &&
                                                  numberOfPlayers[3] != null)
                                              ? Colors.orange
                                              : Colors.white,
                            ),
                            alignment: Alignment.center,
                          ),
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.w),
                    child: GridView.builder(
                      itemCount: images.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        mainAxisSpacing: 10,
                        // crossAxisSpacing: 5,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        return (flipController.isNotEmpty)
                            ? GestureDetector(
                                onTap: () async {
                                  if (twoTaps.length < 2 &&
                                      !totalItems.contains(index)) {
                                    flipController[index].flip();
                                    log(
                                        flipController[index]
                                            .value
                                            .toString(),
                                        name: 'flipedd');
                                    twoTaps.add(index);
                                    totalItems.add(index);
                                    twoTapsElement.add(listOfItems[index]);
                                    if (twoTaps.length == 2) {
                                      if (twoTapsElement[0] ==
                                          twoTapsElement[1]) {
                                        if (player == numberOfPlayers[0]) {
                                          setState(() {
                                            player1Score++;
                                          });
                                        } else if (player ==
                                            numberOfPlayers[1]) {
                                          setState(() {
                                            player2Score++;
                                          });
                                        } else if (player ==
                                            numberOfPlayers[2]) {
                                          setState(() {
                                            player3Score++;
                                          });
                                        } else if (player ==
                                            numberOfPlayers[3]) {
                                          setState(() {
                                            player4Score++;
                                          });
                                        }
                                        if (listOfItems.length !=
                                            totalItems.length) {
                                          twoTaps.clear();
                                          twoTapsElement.clear();
                                        } else {}
                                      } else {
                                        await Future.delayed(const Duration(
                                                milliseconds: 800))
                                            .then(
                                          (value) {
                                            flipController[twoTaps[0]].flip();
                                            flipController[twoTaps[1]].flip();
                                            totalItems.remove(twoTaps[0]);
                                            totalItems.remove(twoTaps[1]);
                                            if (player <
                                                numberOfPlayers.length - 1) {
                                              setState(() {
                                                player++;
                                                colorAnimation.value = 0;
                                                gameStarted = true;
                                              });
                                              // changeBackgroundColor();
                                            } else {
                                              setState(() {
                                                player = numberOfPlayers[0];
                                                colorAnimation.value = 0;
                                              });
                                              // changeBackgroundColor();
                                            }
                                            twoTaps.clear();
                                            twoTapsElement.clear();
                                          },
                                        );
                                      }
                                    }
                                  } else {
                                    if (totalItems.length ==
                                        listOfItems.length) {}
                                  }
                                },
                                child: FlipAnimation(
                                  controller: flipController[index],
                                  // firstChild: CircleAvatar(
                                  //   radius: 45.r,
                                  //   backgroundColor: Colors.white,
                                  //   foregroundColor: Colors.white,
                                  //   child: CircleAvatar(
                                  //     radius: 40.r,
                                  //     foregroundImage: const AssetImage(
                                  //       'assets/images/card_bg.jpg',
                                  //     ),
                                  //   ),
                                  // ),
                                  firstChild: Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(40.r),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(40.r),
                                      child: Image.asset(
                                          'assets/images/card_bg.jpg'),
                                    ),
                                  ),
                                  // secondChild: CircleAvatar(
                                  //   radius: 45.r,
                                  //   backgroundColor: Colors.white,
                                  //   foregroundColor: Colors.white,
                                  //   child: CircleAvatar(
                                  //     radius: 40.r,
                                  //     foregroundImage: AssetImage(
                                  //       images[index],
                                  //     ),
                                  //   ),
                                  // ),
                                  secondChild: Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(40.r),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(40.r),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                            images[index],
                                            
                                          ),
                                          fit: BoxFit.cover
                                        )),
                                        // child: Image.asset(
                                        //   images[index],
                                        //   fit: BoxFit.fitWidth,
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                if (totalItems.length == listOfItems.length)
                  Center(
                    child: GameEndWidget(
                      onPlayTap: () => resetGame(),
                      onMenuTap: () {},
                    ),
                  ),
                if (totalItems.length == listOfItems.length)
                  (player1Score > player2Score &&
                          player1Score > player3Score &&
                          player1Score > player4Score)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Transform.rotate(
                            alignment: Alignment.bottomRight,
                            angle: -math.pi / 4,
                            child: Image.asset(
                              'assets/gifs/winner.gif',
                              height: 50.h,
                            ),
                          ),
                        )
                      : (player2Score > player3Score &&
                              player2Score > player4Score)
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Transform.rotate(
                                alignment: Alignment.topLeft,
                                angle: -math.pi / 4,
                                child: Image.asset(
                                  'assets/gifs/winner.gif',
                                  height: 50,
                                ),
                              ),
                            )
                          : (player3Score > player4Score)
                              ? Align(
                                  alignment: Alignment.topRight,
                                  child: Transform.rotate(
                                    alignment: Alignment.bottomLeft,
                                    angle: math.pi / 4,
                                    child: Image.asset(
                                      'assets/gifs/winner.gif',
                                      height: 50.h,
                                    ),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Transform.rotate(
                                    alignment: Alignment.topRight,
                                    angle: math.pi / 4,
                                    child: Image.asset(
                                      'assets/gifs/winner.gif',
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: PlayerWidget(
                    color: Colors.red,
                    score: player1Score,
                  ),
                ),
                if (numberOfPlayers.length == 3 || numberOfPlayers.length == 4)
                  Align(
                    alignment: Alignment.topRight,
                    child: PlayerWidget(
                      color: Colors.green,
                      score: player3Score,
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: PlayerWidget(
                    color: Colors.blue,
                    score: player2Score,
                  ),
                ),
                if (numberOfPlayers.length == 4)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: PlayerWidget(
                      color: Colors.orange,
                      score: player4Score,
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onLongPress: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      widget.bgm.play(AssetSource(narutoBgm));
                    },
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 25.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
