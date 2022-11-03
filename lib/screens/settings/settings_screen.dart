import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onBackPressed;
  final AudioPlayer player;
  const SettingsScreen({
    super.key,
    required this.onBackPressed,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            dense: true,
            leading: Text(
              'Game Mode',
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              ),
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Text(
                'Easy',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          TextButton(
            onPressed: () {
              player.play(AssetSource(clickSound));
              onBackPressed();
            },
            child: Text(
              'Back',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
