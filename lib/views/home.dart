import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/views/categories.dart';
import 'package:wallpaper_app/views/widget/widget.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  List<CategoriesModel> categories = [];
  void initState() {
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
                  elevation: 0.0),

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
                                  decoration: InputDecoration(
                                    hintText: "Search Wallpaper",
                                    border: InputBorder.none,
                                    
                                  ),
                                ),
                              ),
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height:20 ,),

                      
                     Container(
                      height: 80,
                      
                       child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,itemCount: categories.length,
                        itemBuilder: (context, index) {
                            return CategoriesTitle(title: categories[index].categoriesName, imgUrl:categories[index].imgUrl );
                          },),
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
    return Container(
      height: 50,
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
              height: 80,
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
    );
  }
}