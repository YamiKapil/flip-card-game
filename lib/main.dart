import 'package:flip_game/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MyApp());
  });
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   // DeviceOrientation.landscapeLeft,
    // ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return ScreenUtilInit(
              designSize: Size(constraints.maxWidth, constraints.maxHeight),
              minTextAdapt: true,
              builder: (BuildContext context, Widget? child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Card Flip Memory Game',
                  home: const SplashScreen(),
                  theme: ThemeData(
                    primarySwatch: Colors.cyan,
                    fontFamily: GoogleFonts.audiowide().fontFamily,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
