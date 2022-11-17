import 'dart:developer';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flip_game/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import '../../widgets/flip_animation.dart';
import '../../widgets/game_end_widget.dart';
import '../../widgets/player_widget.dart';

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[math.Random().nextInt(length)];
  }
}

class GameScreenCom extends StatefulWidget {
  final int players;
  final AudioPlayer bgm;
  const GameScreenCom({super.key, required this.players, required this.bgm});

  @override
  State<GameScreenCom> createState() => _GameScreenComState();
}

class _GameScreenComState extends State<GameScreenCom>
    with SingleTickerProviderStateMixin {
  List<FlipController> flipController = [];
  List twoTaps = [];
  List twoTapsElement = [];
  List totalItems = [];
  final random = math.Random();
  dynamic images;
  dynamic player = -1;
  int player1Score = 0;
  int comScore = 0;
  List numberOfPlayers = [];
  List<Color> bgColor = [];
  late AnimationController colorAnimation;
  late Animation<double> animation;
  bool gameStarted = false;
  bool comTurn = false;
  // List<FlipController> compFlipController = [];
  Set comMemory = {};

  @override
  void initState() {
    images = listOfItems..shuffle();
    setPlayers();
    player = numberOfPlayers[0];
    setPlayerBgColor();
    flipController.clear();
    flipController = List.generate(listOfItems.length, (i) => FlipController());
    // compFlipController = [...flipController];
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

  late int firstIndex;
  late int secondIndex;

  getRandomIndex() async {
    firstIndex = random.nextInt(flipController.length);
    secondIndex = random.nextInt(flipController.length);
  }

  comTurnStart() async {
    await getRandomIndex();
    if (firstIndex == secondIndex) {
      await getRandomIndex();
    }
    late int nextFirstIndex;
    late int nextSecondIndex;
    if (comMemory.length > 2) {
      outerLoop:
      for (int i = 0; i < comMemory.length; i++) {
        for (int j = i + 1; j < comMemory.length; j++) {
          log((images[comMemory.elementAt(i)]).toString(),
              name: 'com turn img i');
          log((images[comMemory.elementAt(j)]).toString(),
              name: 'com turn img j');
          if (images[comMemory.elementAt(i)] ==
              images[comMemory.elementAt(j)]) {
            nextFirstIndex = comMemory.elementAt(i);
            nextSecondIndex = comMemory.elementAt(j);
            break outerLoop;
          } else {
            nextFirstIndex = firstIndex;
            nextSecondIndex = secondIndex;
          }
        }
      }
    } else {
      nextFirstIndex = firstIndex;
      nextSecondIndex = secondIndex;
    }
    // compFlipController.shuffle();
    // final firstIndex = compFlipController.indexOf((compFlipController).first);
    log(firstIndex.toString(), name: 'com turn first index');
    log(nextFirstIndex.toString(), name: 'com turn first next index');
    // final secondIndex = compFlipController.indexOf((compFlipController).last);
    log(secondIndex.toString(), name: 'com turn second index');
    log(nextSecondIndex.toString(), name: 'com turn second next index');
    log(totalItems.toString(), name: 'not com turn total items');

    if (twoTaps.length < 2 &&
        !totalItems.contains(nextFirstIndex) &&
        !totalItems.contains(nextSecondIndex)) {
      await Future.delayed(
        const Duration(milliseconds: 800),
        () async {
          flipController[nextFirstIndex].flip();
          twoTaps.add(nextFirstIndex);
          totalItems.add(nextFirstIndex);
          twoTapsElement.add(listOfItems[nextFirstIndex]);
          await Future.delayed(const Duration(milliseconds: 500), () async {
            flipController[nextSecondIndex].flip();
            twoTaps.add(nextSecondIndex);
            totalItems.add(nextSecondIndex);
            twoTapsElement.add(listOfItems[nextSecondIndex]);
          }).then((value) async {
            if (twoTaps.length == 2) {
              if (twoTapsElement[0] == twoTapsElement[1]) {
                // compFlipController.removeAt(firstIndex);
                // compFlipController.removeAt(secondIndex);
                if (comMemory.contains(nextFirstIndex) &&
                    comMemory.contains(nextSecondIndex)) {
                  comMemory.remove(nextFirstIndex);
                  comMemory.remove(nextSecondIndex);
                }
                if (player == numberOfPlayers[1]) {
                  setState(() {
                    comScore++;
                  });
                }
                if (listOfItems.length != totalItems.length) {
                  twoTaps.clear();
                  twoTapsElement.clear();
                  setState(() {});
                } else {
                  setState(() {
                    comTurn = false;
                    gameStarted = false;
                  });
                }
              } else {
                comMemory.add(nextFirstIndex);
                comMemory.add(nextSecondIndex);
                await Future.delayed(const Duration(milliseconds: 800)).then(
                  (value) {
                    flipController[twoTaps[0]].flip();
                    flipController[twoTaps[1]].flip();
                    totalItems.remove(twoTaps[0]);
                    totalItems.remove(twoTaps[1]);
                    if (player < numberOfPlayers.length - 1) {
                      setState(() {
                        player++;
                        colorAnimation.value = 0;
                        gameStarted = true;
                        comTurn = false;
                      });
                    } else {
                      setState(() {
                        player = numberOfPlayers[0];
                        colorAnimation.value = 0;
                        comTurn = false;
                      });
                    }
                    twoTaps.clear();
                    twoTapsElement.clear();
                  },
                );
              }
            }
          });
        },
      );
    } else if (totalItems.contains(nextFirstIndex) ||
        totalItems.contains(nextSecondIndex)) {
      comTurnStart();
    } else {
      // setState(() {});
      // comTurnStart();
    }
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
      comScore = 0;
      images = listOfItems..shuffle();
      totalItems.clear();
      gameStarted = false;
      comMemory.clear();
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
    log(comMemory.toString(), name: 'com turn memory');
    log(comTurn.toString(), name: 'comTurn');
    if (comTurn) {
      comTurnStart();
    }
    log(player1Score.toString(), name: 'score1');
    log(comScore.toString(), name: 'score2');
    log('build rebuild');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          color: (player == numberOfPlayers[0])
              ? bgColor[player]
              : (player == numberOfPlayers[1])
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
                                  if (!comTurn) {
                                    if (twoTaps.length < 2 &&
                                        !totalItems.contains(index)) {
                                      flipController[index].flip();
                                      twoTaps.add(index);
                                      totalItems.add(index);
                                      twoTapsElement.add(listOfItems[index]);
                                      if (twoTaps.length == 2) {
                                        if (twoTapsElement[0] ==
                                            twoTapsElement[1]) {
                                          // compFlipController
                                          //     .removeAt(twoTaps[0]);
                                          // compFlipController
                                          //     .removeAt(twoTaps[1]);
                                          if (comMemory.contains(twoTaps[0]) &&
                                              comMemory.contains(twoTaps[1])) {
                                            comMemory.remove(twoTaps[0]);
                                            comMemory.remove(twoTaps[1]);
                                          }
                                          if (player == numberOfPlayers[0]) {
                                            setState(() {
                                              player1Score++;
                                            });
                                          }
                                          //  else if (player ==
                                          //     numberOfPlayers[1]) {
                                          //   setState(() {
                                          //     comScore++;
                                          //   });
                                          // }
                                          if (listOfItems.length !=
                                              totalItems.length) {
                                            twoTaps.clear();
                                            twoTapsElement.clear();
                                          }
                                        } else {
                                          comMemory.add(twoTaps[0]);
                                          comMemory.add(twoTaps[1]);
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
                                                  comTurn = true;
                                                });
                                              } else {
                                                setState(() {
                                                  player = numberOfPlayers[0];
                                                  colorAnimation.value = 0;
                                                  comTurn = true;
                                                });
                                              }
                                              twoTaps.clear();
                                              twoTapsElement.clear();
                                            },
                                          );
                                        }
                                      }
                                    }
                                  } else {
                                    null;
                                  }
                                },
                                child: FlipAnimation(
                                  controller: flipController[index],
                                  firstChild: Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.r),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.r),
                                      child: Image.asset(
                                          'assets/images/card_bg.jpg'),
                                    ),
                                  ),
                                  secondChild: Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40.r),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.r),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                images[index],
                                              ),
                                              fit: BoxFit.cover),
                                        ),
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
                      onMenuTap: const MenuScreen(),
                    ),
                  ),
                if (totalItems.length == listOfItems.length)
                  (player1Score > comScore)
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
                      : (comScore > player)
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
                          : Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'assets/gifs/winner.gif',
                                height: 50,
                              ),
                            ),
                Align(
                  alignment: Alignment.topLeft,
                  child: PlayerWidget(
                    color: Colors.red,
                    score: player1Score,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: PlayerWidget(
                    color: Colors.blue,
                    score: comScore,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onLongPress: () {
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
