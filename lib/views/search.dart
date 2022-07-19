import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/views/full_screen.dart';
import 'package:wallpaper_app/views/widget/widget.dart';
import 'package:http/http.dart'as http;
class Search extends StatefulWidget {
 final String query;
  Search( {required this.query});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
 List queryWall =[];
 int page =1;
 Search(String query)async{
      await http.get(Uri.parse(    "https://api.pexels.com/v1/search?query=$query&per_page=80"),
    headers:{
      "Authorization": apiKey
      },
      ).then((value) {
        Map result =jsonDecode(value.body);
        setState(() {
          print(value.body.toString());
      queryWall=result['photos'];
    });
      });}
      void initState() {
    Search(widget.query);
    
    super.initState();
    
    
  }
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         iconTheme: IconThemeData(
    color: Colors.black, 
  ),
        title: BrandName(),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),

      body: Container(

                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                        
                          child: Container(
                            
                            
                            padding:EdgeInsets.symmetric(horizontal: 20),
                            
                            child:  Text('Search result for'+'"'+widget.query+'"',style: TextStyle(fontSize: 30),)
                          ),
                        
                      ),
                     

                      
                     
                     SizedBox(height:20 ,),
                     Expanded(
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 16),
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                         child: NotificationListener<ScrollNotification>(

                          onNotification: (scrollNotification){
                            if(scrollNotification is ScrollEndNotification){
                             // loadmore();
                              
                            }
                            return true;
                          },
                           child: GridView.builder(
                             shrinkWrap: true,
                             itemCount: queryWall.length,
                           
                           itemBuilder: (BuildContext context, int index) {return InkWell(
                            onTap: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: ((context) => FullScreen(imageurl:queryWall[index]['src']['large2x']))));

                            },
                             child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(16)
                              ),
                               child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(queryWall[index]['src']['large2x'],fit: BoxFit.cover,)),
                             ),
                           );  },
                           gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                                 crossAxisSpacing: 6,
                                                 crossAxisCount: 2,
                                                 childAspectRatio: 2 / 3,
                                                 mainAxisSpacing: 6),
                           
                           ),
                         ),
                       ),
                     ),
                     
                    ],
                  ),
    ));
    
  }
}