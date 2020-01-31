import 'package:absensi_selfie_2020_java/features/report_page.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget{
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage>{
  var location = new Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    location.onLocationChanged().listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
    });
  }

  Widget image_present(){
    return
      Padding(
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {

          },
          child: Container(
            height: 150.0,
            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('images/hacker.jpeg'),
                    fit: BoxFit.cover),
                borderRadius:
                BorderRadius.all(Radius.circular(4.0)),
                boxShadow: [
                  BoxShadow(blurRadius: 7.0, color: Colors.black)
                ]),
          ),
        ),
      );
  }

  Widget cardview (){
    return Container(
      height: 200,
      child: Card(
        elevation: 4,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: image_present(),
            ),
            Expanded(
              child:
              GestureDetector(
                onTap: () {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext conext) {
                      return AlertDialog(
                        title: Text('Not in stock'),
                        content:
                        const Text('This item is no longer available'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child:information_user(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget information_user(){
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[

            Text("Muhammad Alvin Rizqi Ramadhan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),),
            Text("Jl. Pelajar Pejuang 45 No. 65,Lkr. Sel., Lengkong,Kota Bandung, Jawa Barat 40263, Lkr. Sel., Kec. Lengkong, Kota Bandung, Jawa Barat 40264",

            ),
            SizedBox(
              height: 20,
            ),

            Text("17 Januari 2020 08:20:29",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )
          ],
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement bu ild
    return Scaffold(
      appBar: AppBar(
        title: Text("History Present"),
        elevation: 10,
      ),
      body:ListView(
        padding: const EdgeInsets.all(9),
        children: <Widget>[
          cardview(),
          cardview(),
          cardview(),
          cardview(),
          cardview(),
          cardview(),
          cardview(),
          cardview(),
          cardview(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> ReportPage(),
            )
          );
        },
      ),
    );
  }

}