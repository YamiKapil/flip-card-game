import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu_items.dart';

class GameEndWidget extends StatelessWidget {
  final Widget? onMenuTap;
  final VoidCallback? onPlayTap;
  const GameEndWidget({super.key, this.onMenuTap, this.onPlayTap});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Theme.of(context).primaryColor,
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.all(16.w),
    //         child: Container(
    //           decoration: const BoxDecoration(
    //             color: Colors.white,
    //           ),
    //           height: MediaQuery.of(context).size.height * 0.12,
    //           child: FittedBox(
    //             child: GestureDetector(
    //               onTap: onMenuTap,
    //               child: const Icon(
    //                 Icons.menu,
    //                 color: Colors.red,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(16.w),
    //         child: Container(
    //           decoration: const BoxDecoration(
    //             color: Colors.white,
    //           ),
    //           height: MediaQuery.of(context).size.height * 0.12,
    //           child: FittedBox(
    //             child: GestureDetector(
    //               onTap: onPlayTap,
    //               child: const Icon(
    //                 Icons.play_arrow,
    //                 color: Colors.blue,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItems(
            icon: Icons.restart_alt_rounded,
            text: 'Restart Again',
            function: onPlayTap,
          ),
          MenuItems(
            icon: Icons.menu,
            text: 'Main Menu',
            function: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => onMenuTap!),
                (route) => false),
          ),
        ],
      ),
    );
  }
}
