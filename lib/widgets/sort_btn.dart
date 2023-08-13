import 'package:flutter/material.dart';
import 'package:moviez/widgets/my_text.dart';

class MySortBtn extends StatelessWidget {
  final String text;
  const MySortBtn({super.key,
  required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
                    padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                    margin: const EdgeInsets.only(left:10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: MyText(text: text,size:16,color:Colors.black),
                  );
  }
}