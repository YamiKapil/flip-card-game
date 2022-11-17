import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuItems extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? function;
  const MenuItems({
    super.key,
    required this.text,
    required this.icon,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: 15.h,
      ),
      child: GestureDetector(
        onTap: function,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: Colors.white,
            ),
            SizedBox(width: 20.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
