import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviez/utils/theme_colors.dart';
import 'package:moviez/widgets/movie_card.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final _currentUser=FirebaseAuth.instance.currentUser!;

  Stream<QuerySnapshot> getList(){
    return FirebaseFirestore.instance.collection('Favourite_list').where('email',isEqualTo: _currentUser.email).snapshots();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.darkColor,
      appBar: AppBar(
        backgroundColor: ThemeColor.darkColor,
        elevation: 0,
        title: const Text('Favourite List'),
      ),
      body: StreamBuilder(
        stream:getList(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text('Error');
          }else if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator(color: Colors.white));
          }else{
            final favouriteData=snapshot.data!.docs;
            return ListView(
              children: List.generate(favouriteData.length, (index){
                final data=favouriteData[index].data() as Map<String,dynamic>;
                return MyCard(
                  id: data['mid'], 
                  poster: data['posterLink'], 
                  imdb: data['imdb'].toString(), 
                  year: data['year'], 
                  title: data['title'],
                  removeBtn: true);
              }),
            );
          }
        },
      )
    );
  }
}