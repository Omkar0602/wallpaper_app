

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/categoriescreen.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/views/widget/widget.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  @override
  List<CategoriesModel> categories = [];
  List wallpapers =[];
  
  int page=1;

  getTrendingWallpaper()async{
      await http.get(Uri.parse(  "https://api.pexels.com/v1/curated?per_page=80"),
    headers:{
      "Authorization": apiKey
      },
      ).then((value) {
        Map result =jsonDecode(value.body);
        setState(() {
      wallpapers=result['photos'];
    });
      });
    
    
  }
  loadmore()async{
    setState(() {
      page =page +1;
    });
    String url='https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
    await http.get(Uri.parse(url),
    headers:{
      "Authorization": apiKey
      },
      ).then((value){
        Map result =jsonDecode(value.body);
        setState(() {
      wallpapers.addAll(result['photos']) ;
    });
      });

  }
    ScrollController _scrollController = new ScrollController();
    TextEditingController _query =new TextEditingController();

  void initState() {
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();
    
    
  }
  @override
  Widget build(BuildContext context) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(title: BrandName(),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  elevation: 0.0,
                  ),
                  

                  body: Container(

                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(255, 231, 233, 237) 
                          ),
                          padding:EdgeInsets.symmetric(horizontal: 20),
                          
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _query,
                                  decoration: InputDecoration(
                                    hintText: "Search Wallpaper",
                                    border: InputBorder.none,
                                    
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Search(query: _query.text))));
                                },
                                child: Icon(Icons.search)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:20 ,),

                      
                     Container(
                      height: 60,
                      
                       child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,itemCount: categories.length,
                        itemBuilder: (context, index) {
                            return CategoriesTitle(title: categories[index].categoriesName, imgUrl:categories[index].imgUrl );
                          },),
                     ),
                     SizedBox(height:20 ,),
                     Expanded(
                       child: Container(
                         padding: EdgeInsets.symmetric(horizontal: 16),
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                         child: NotificationListener<ScrollNotification>(

                          onNotification: (scrollNotification){
                            if(scrollNotification is ScrollEndNotification){
                              loadmore();
                              
                            }
                            return true;
                          },
                           child: GridView.builder(
                             shrinkWrap: true,
                             itemCount: wallpapers.length,
                           
                           itemBuilder: (BuildContext context, int index) {return Container(
                             child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(wallpapers[index]['src']['large2x'],fit: BoxFit.cover,)),
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
                ),
              );
  }
}

class CategoriesTitle extends StatelessWidget {
  
  final String imgUrl,title;
  
 CategoriesTitle({required this.title,required this.imgUrl});
  @override

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategorieWallpaper(categorie: title)));
      },
      child: Container(
        height: 60,
        width: 150,
        padding: EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            Container(
              
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                
                image: DecorationImage(
                  fit: BoxFit.cover,
                  
                  image: NetworkImage(imgUrl,))
              ),
             
            ),
             Container(
                height: 60,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
                
               
              ),
        
        alignment: Alignment.center,
                
                child: Text(title,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            
          ],
        ),
      ),
    );
  }
}