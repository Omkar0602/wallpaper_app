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
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                            decoration: BoxDecoration(
                            color: Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                ),
                SizedBox(height: 45,)
              ],
            ),
          ),
          Container(
          child: Column(
           children: [
            Expanded(child: Container()),
            InkWell(
              onTap: (){
                _save();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border:
                                    Border.all(color: Colors.white24, width: 1),
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0x36FFFFFF),
                                      Color.fromARGB(15, 18, 17, 17)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight)
                   
                    
                  ),
                  child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "Set Wallpaper",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text("Image will be saved in gallery",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white70),
                                ),
                                
                              ],
                            ),
                ),
              ),
            ),
            
            InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
            SizedBox(height: 15,),
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