import 'package:flutter/material.dart';

class MyInputText extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool hide;
  const MyInputText({super.key,
  required this.text,
  required this.controller,
  required this.hide});

  @override
  Widget build(BuildContext context) {
    return TextField(
              controller: controller,
              style: const TextStyle(fontSize:20,color:Colors.white),
              obscureText: hide,
              decoration: InputDecoration(
                labelText: text,
                labelStyle: const TextStyle(fontSize:20,color:Colors.white),
                focusedBorder: const OutlineInputBorder(
                  borderSide:BorderSide(width: 3,color:Colors.white),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:BorderSide(width: 3,color:Colors.white),
                ),
              ),
            );
  }
}