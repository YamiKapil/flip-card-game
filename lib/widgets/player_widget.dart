import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  final Color? color;
  final int score;
  const PlayerWidget({
    super.key,
    this.color,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 3,
          color: Colors.white,
        ),
      ),
      height: 40,
      width: 40,
      child: Center(
        child: Text(
          score.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
