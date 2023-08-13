import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moviez/utils/theme_colors.dart';
import 'package:moviez/widgets/movie_card.dart';
import 'package:http/http.dart' as http;

import '../utils/link_uri.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController=TextEditingController();

  List<Map<String,dynamic>> searchList=[];

  Future<void> fetchMovieData(String searchTerm) async {
  final response = await http.get(Uri.parse('$searchAPI$searchTerm')); // Replace with your API URL
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        searchList=List<Map<String,dynamic>>.from(jsonData['results']);
        
      });
    } else {
      print('Failed Status code: ${response.statusCode}');
    }
  }
  
  void searchData(){
    fetchMovieData(_searchController.text);
  }
  @override
  void initState(){
    super.initState();
    _searchController.addListener(searchData);
  }
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.darkColor,
      appBar: AppBar(
        backgroundColor: ThemeColor.darkColor,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(fontSize: 22,color: Colors.white),
          decoration:const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search ...',
            hintStyle: TextStyle(fontSize: 22,color: Colors.white),
            suffixIcon: Icon(Icons.search,size:26,color:Colors.white)
          ),
        ),
      ),
      body:ListView(
        children:List.generate(searchList.length, (index){
          final movie=searchList[index];
          return MyCard( 
                  id:movie['id'],
                  poster: movie['poster_path'], 
                  imdb: movie['vote_average'].toString(), 
                  year: movie['release_date'], 
                  title: movie['title'],
                  removeBtn: false);
        })
      )
    );
  }
}