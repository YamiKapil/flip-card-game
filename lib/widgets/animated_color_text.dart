import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedColorText extends StatefulWidget {
  final String text;
  final List<Color> colorsList;
  final TextStyle? textStyle;
  final int? animationDuration;
  const AnimatedColorText({
    super.key,
    required this.text,
    required this.colorsList,
    this.textStyle,
    this.animationDuration,
  });

  @override
  State<AnimatedColorText> createState() => _AnimatedColorTextState();
}

class _AnimatedColorTextState extends State<AnimatedColorText>
    with SingleTickerProviderStateMixin {
  late AnimationController _colorController;
  late Animation _colorAnimation;

  @override
  void initState() {
    _colorController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration ?? 1),
    );
    _colorAnimation = Tween(begin: 0.0, end: 1.0).animate(_colorController)
      ..addListener(() {
        setState(() {});
      });
    _colorController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Text(
        widget.text,
        style: widget.textStyle ??
            TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
      shaderCallback: (rect) {
        return LinearGradient(
          stops: [
            _colorAnimation.value - 0.5,
            _colorAnimation.value,
            _colorAnimation.value + 0.5,
          ],
          colors: widget.colorsList,
        ).createShader(rect);
      },
    );
  }
}
