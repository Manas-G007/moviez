import 'package:flutter/material.dart';
import 'package:moviez/widgets/my_text.dart';

class MyBtn extends StatelessWidget {
  final String text;
  final bool load;
  const MyBtn({super.key,
  required this.text,
  required this.load});

  @override
  Widget build(BuildContext context) {
    return Container(
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child:load?
              const Center(child: CircularProgressIndicator(color:Colors.black)):
              Center(child: MyText(text: text, size: 24,color: Colors.black,))
            );
  }
}