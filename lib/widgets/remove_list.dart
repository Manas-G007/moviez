import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RemoveList extends StatelessWidget {
  final int id;
  const RemoveList({super.key,
  required this.id});

  @override
  Widget build(BuildContext context) {
    final thisUser=FirebaseAuth.instance.currentUser!;

    void removeItem() async{
      QuerySnapshot<Map<String,dynamic>> snapshot=await FirebaseFirestore.instance.collection('Favourite_list')
      .where('email',isEqualTo: thisUser.email)
      .where('mid',isEqualTo: id)
      .get();

      await snapshot.docs.first.reference.delete();
    }

    return GestureDetector(
      onTap:removeItem,
      child:const Row(
            children: [
                Icon(Icons.remove_circle_outline,color:Colors.red),
                Gap(10),
                Text('remove')
              ],),
    );
  }
}