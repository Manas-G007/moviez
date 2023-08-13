import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


class AddList extends StatefulWidget {
  final int id;
  final String posterLink;
  final double imdb;
  final String title;
  final String year; 
  const AddList({super.key,
  required this.id,
  required this.posterLink,
  required this.imdb,
  required this.title,
  required this.year});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  final _currentUser=FirebaseAuth.instance.currentUser!;

  String text='Add to list';
  void addToList() async{
    updateMessage('Adding ... ');
    try{
      QuerySnapshot<Map<String,dynamic>> snapshot=await FirebaseFirestore.instance.collection('Favourite_list')
      .where('mid',isEqualTo: widget.id)
      .where('email',isEqualTo: _currentUser.email)
      .get();
      
      bool isNotPresent=snapshot.size==0;

      if(isNotPresent){
        await FirebaseFirestore.instance.collection('Favourite_list').add(
          {
            'mid':widget.id,
            'email':_currentUser.email,
            'posterLink':widget.posterLink,
            'imdb':widget.imdb,
            'title':widget.title,
            'year':widget.year
          }
        );
        updateMessage('Added');
      }else{
        updateMessage('Already added');
      }
      
    }on FirebaseException catch(e){
      print(e);
    }
   
  }

  void updateMessage(String message){
    setState(() {
      text=message;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:addToList,
      child: Row(children: [
                    const Icon(Icons.add_circle_outline),
                    const Gap(10),
                    Text(text)
                  ],),
    );
  }
}