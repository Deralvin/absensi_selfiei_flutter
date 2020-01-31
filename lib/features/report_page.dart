
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'dart:async';
import 'package:compressimage/compressimage.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:imagebutton/imagebutton.dart';
import 'package:location/location.dart';

class ReportPage extends StatefulWidget{
  _ReportPageState createState()=> _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{

  bool visibilityImage = false;
  File _image;
  String _address;
  var location = new Location();
  var longitude, latitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.onLocationChanged().listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      setState(() {
        longitude = currentLocation.longitude;
        latitude = currentLocation.latitude;
      });
    });
  }


  Future getImage(bool isCamera)async{
    File image;
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

    }

    setState((){
      _image= image;
      print(image);
      print(_image.path);
      visibilityImage = true;
    });
    get_address();

    print("FILE SIZE BEFORE: " + image.lengthSync().toString());
    await CompressImage.compress(imageSrc: image.path, desiredQuality: 13); //desiredQuality ranges from 0 to 100
    print("FILE SIZE  AFTER: " + image.lengthSync().toString());

  }


  Widget show_image(){
    return Column(
      children: <Widget>[
        Image.file(_image,height: 300.0,width: 300.0,),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child:Row(
            children: <Widget>[
              Expanded(
                child:Text("Alamat : "),

              ),
              Expanded(
                flex: 6,
                child:             Text(
                  "Jl. Pelajar Pejuang 45 No.63, Lkr. Sel., Kec. Lengkong, Kota Bandung, Jawa Barat 40263, Indonesia",

                ),
              )
            ],
          ),
        ),
              RaisedButton(
                         onPressed: () {},
                         textColor: Colors.white,
                         padding: const EdgeInsets.all(0.0),
                         child: Container(
                           decoration: const BoxDecoration(
                             gradient: LinearGradient(
                               colors: <Color>[
                                 Color(0xFF0D47A1),
                                 Color(0xFF1976D2),
                                 Color(0xFF42A5F5),
                               ],
                             ),
                           ),
                           padding: const EdgeInsets.all(10.0),
                           child: const Text(
                             'Gradient Button',
                             style: TextStyle(fontSize: 20)
                           ),
                         ),
                       ),
      ],

    );
  }

  void get_address()async{
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    setState(() {
      _address = first.addressLine;
    });
    print(first.addressLine);
  }


  Widget add_image(){
    return Column(
      children: <Widget>[
        ImageButton(
          children: <Widget>[],
          width: 300,
          height: 300,
          paddingTop: 5,
          pressedImage: Image.asset(
            "assets/images/background.png",
          ),
          unpressedImage: Image.asset("assets/images/frame.png"),
          onTap: ()async {
              getImage(true);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Take A Picture",
          style: TextStyle(
            fontSize: 17
          ),
        )
      ],

    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Present"),
      ),
      body:Center(

        child:  Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            visibilityImage ? show_image():add_image(),
          ],
        ),
      )

      );
  }

}