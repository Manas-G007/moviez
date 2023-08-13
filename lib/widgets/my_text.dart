import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  const MyText({super.key,
  required this.text,
  required this.size,
  this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color:color??Colors.white,
        fontSize: size
      ),
    );
  }
}