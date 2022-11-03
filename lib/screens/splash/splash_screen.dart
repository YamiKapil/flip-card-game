import 'package:flip_game/screens/menu/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import '../../widgets/animated_color_text.dart';
import '../../widgets/flip_animation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  List<FlipController> flipController = [];
  late AnimationController _animationController;
  dynamic images;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    images = listOfItems..shuffle();
    flipController.clear();
    flipController = List.generate(4, (i) => FlipController());
    startAnimation();

    super.initState();
  }

  startAnimation() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _animationController
          .animateTo(0.2)
          .then((value) => flipController[0].flip())
          .then((value) => _animationController
              .animateTo(0.4)
              .then((value) => flipController[3].flip()))
          .then((value) => _animationController
              .animateTo(0.6)
              .then((value) => flipController[1].flip()))
          .then((value) => _animationController
              .animateTo(0.8)
              .then((value) => flipController[2].flip())
              .then(
                (value) => _animationController.animateTo(1.0).then((value) {
                  for (var i = 0; i < 4; i++) {
                    flipController[i].flip();
                  }
                  navigate();
                }),
              ));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    flipController.map((e) => e.dispose());
    super.dispose();
  }

  navigate() {
    Future.delayed(const Duration(milliseconds: 700)).then(
      (value) => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MenuScreen(),
          ),
          (route) => false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: AnimatedColorText(
                  text: 'CARD FLIP MEMORY GAME',
                  colorsList: const [Colors.blue, Colors.purple, Colors.red],
                  textStyle: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              // for showing 2 vertical and 2 horizontal cards....
              // GridView.builder(
              //   // physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     // crossAxisSpacing: 40,
              //     childAspectRatio: 5.0,
              //     crossAxisSpacing: 20.w,
              //     mainAxisSpacing: 20.h,
              //   ),
                
              //   itemCount: 4,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       alignment: (index==3||index==1)?Alignment.centerLeft: Alignment.centerRight,
              //       // color: Colors.green.shade100,
              //       child: FlipAnimation(
              //         controller: flipController[index],
              //         firstChild: CircleAvatar(
              //           radius: 45.r,
              //           foregroundImage: const AssetImage(
              //             'assets/images/card_bg.jpg',
              //           ),
              //         ),
              //         secondChild: CircleAvatar(
              //           radius: 45.r,
              //           foregroundImage: AssetImage(
              //             images[index],
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
              // for showing 4 horizontal cards....
              GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  // crossAxisSpacing: 40,
                  // childAspectRatio: 5.0,
                  // crossAxisSpacing: 20.w,
                  // mainAxisSpacing: 20.h,
                ),
                
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    // color: Colors.green.shade100,
                    child: FlipAnimation(
                      controller: flipController[index],
                      firstChild: CircleAvatar(
                        radius: 45.r,
                        foregroundImage: const AssetImage(
                          'assets/images/card_bg.jpg',
                        ),
                      ),
                      secondChild: CircleAvatar(
                        radius: 45.r,
                        foregroundImage: AssetImage(
                          images[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // SizedBox(height: 20.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-0.5, 0.1),
                          end: const Offset(0.5, 0.1),
                        ).animate(_animationController),
                        child: Image(
                          height: 50.h,
                          width: 50.w,
                          image: (_animationController.value < 1)
                              ? const AssetImage(
                                  'assets/gifs/itachi_loading.gif')
                              : const AssetImage('assets/images/itachi.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: _animationController.value,
                        minHeight: 10.h,
                        backgroundColor: Colors.white,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      (_animationController.value < 1)
                          ? 'Loading..'
                          : 'Completed',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
