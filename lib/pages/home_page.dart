import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviez/pages/favourite_page.dart';
import 'package:moviez/pages/search_page.dart';
import 'package:moviez/utils/link_uri.dart';
import 'package:moviez/utils/theme_colors.dart';
import 'package:moviez/widgets/movie_card.dart';
import 'package:moviez/widgets/my_text.dart';
import 'package:http/http.dart' as http;
import 'package:moviez/widgets/sort_btn.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController=ScrollController();

  List<Map<String,dynamic>> movieList=[];
  int page=1;
  int limit=6;

  Future<void> fetchMovieData() async {
  final response = await http.get(Uri.parse('$popularAPI$page')); // Replace with your API URL
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        movieList+=List<Map<String,dynamic>>.from(jsonData['results']);
        // popularity sort will be pointless if i don't shuffle
        // because api already provide sorted by popularity
        if(movieList.length<=20){
          // less than 20 because after that next page data
          // will not shuffle to make smooth scrolling
          movieList.shuffle();
        }
      });
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  void sortList(String type){
    // print('tap');
    setState(() {
       movieList.sort((a,b)=>
        b[type].compareTo(a[type]));
    });
   
  }
  
  void updateLimit(){
    setState(() {
      // just to make series from 6,11,16
      // to 6,10,15,20 to fix out of index error
      if(limit==6){
        limit+=4;
      }else{
        limit+=5;
      }
      if(limit%20==0){
        page++;
        fetchMovieData();
      }
    });
  }

  void _scrollListener(){
    if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
        Future.delayed(const Duration(seconds: 2),(){
            updateLimit();
        });
    }
  }

  void logoutUser() async{
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState(){
    super.initState();

    fetchMovieData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.darkColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeColor.darkColor,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyText(text: 'Moviez', size: 24),
            Row(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context) => const SearchPage())
                    );
                  },
                  child: const Icon(Icons.search)),
                const Gap(10),
                GestureDetector(
                  onTap:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>const FavouritePage())
                    );
                  },
                  child: const Icon(Icons.list_alt_outlined)),
                const Gap(10),
                GestureDetector(
                  onTap:logoutUser,
                  child: const Icon(Icons.exit_to_app))
              ],
            )
          ],
        ),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:const EdgeInsets.symmetric(horizontal:15),
              child: Row(
                children: [
                  const MyText(text: 'Sort By :',size:20,color:Colors.white),
                  Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          sortList('release_date');
                        },
                        child: const MySortBtn(text: 'Year')),
                      GestureDetector(
                        onTap:(){
                          sortList('popularity');
                        },
                        child:const MySortBtn(text: 'Popularity')),
                      GestureDetector(
                        onTap:(){
                          sortList('vote_average');
                        },
                        child:const MySortBtn(text: 'IMDB'))
                    ],
                  ), 
                ],),
            ),
          ),
          Column(
              children: List.generate(movieList.isEmpty?0:limit, (index){
                final movie=movieList[index];
                if(index<limit-1){
                  return MyCard(
                        id: movie['id'],
                        poster: movie['poster_path'], 
                        imdb: movie['vote_average'].toString(), 
                        year: movie['release_date'], 
                        title: movie['title'],
                        removeBtn: false,);
                }else{
                  return const CircularProgressIndicator(color: Colors.white,);
                }               
              })),
        ],
      )
    );
  }

}

// Movie name, poster, year, IMDB rating