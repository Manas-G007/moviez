import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:moviez/widgets/add_list.dart';
import 'package:moviez/widgets/my_text.dart';
import 'package:moviez/widgets/remove_list.dart';

import '../utils/link_uri.dart';

class MyCard extends StatelessWidget {
  final int id;
  final String? poster;
  final String imdb;
  final String year;
  final String title;
  final bool removeBtn;
  const MyCard({super.key,
  required this.id,
  required this.poster,
  required this.imdb,
  required this.year,
  required this.title,
  required this.removeBtn});

  @override
  Widget build(BuildContext context) {

    return Container(
              margin: const EdgeInsets.all(10).copyWith(bottom:5),
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Colors.white
              ),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image:DecorationImage(
                        image:NetworkImage(checkPath(poster)),
                        fit:BoxFit.cover,
                      )
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: 'IMDB ${getSubString(imdb,3)} ($year)', size: 16,color:Colors.black),
                          const Gap(10),
                          MyText(text: 
                            getSubString(title, 30)
                          , size: 22,color:Colors.black),
                          const Gap(10),
                          removeBtn?
                          RemoveList(
                            id: id,
                          ):
                          AddList(
                            id: id,
                            posterLink: checkPath(poster), 
                            imdb: double.parse(imdb), 
                            title: title, 
                            year: year)
                          
                        ],
                      ),
                    ),
                  )
                  
                ],
              ),
            );
  }
}

String getSubString(String text,int limit){
  return text.length>limit?text.substring(0,limit):text;
}

String checkPath(String? path){
  if(path!=null){
    return '$imgPath$path';
  }else{
    return 'https://picsum.photos/200';
  }
}