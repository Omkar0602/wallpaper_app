
import 'package:wallpaper_app/views/home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';

Widget BrandName(){
  return Row(
    children: [
      Text("Wallpaper",style: TextStyle(color: Colors.black87),),
      Text("Hub",style: TextStyle(color: Colors.blue),),
      Expanded(child: Container()),
      Text("-by Omkar0602",style: TextStyle(color: Colors.black,fontSize: 20),),

    ],
  );
}
