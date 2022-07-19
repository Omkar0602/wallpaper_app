import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({required this.imageurl});
 final String imageurl;
  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
 var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ 
          Expanded(child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            child: Image.network(widget.imageurl,fit: BoxFit.cover,),
          )),
          Container(
          child: Column(
           children: [
            Expanded(child: Container()),
            InkWell(
              onTap: (){
                _save();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey,
                   
                    
                  ),
                  child: Text("Set Wallpaper",style: TextStyle(fontSize: 20),),
                ),
              ),
            )
           ],
          ),
        ),
      ]),
    );
  }
  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imageurl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
    } else {
     /* PermissionStatus permission = */await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
}