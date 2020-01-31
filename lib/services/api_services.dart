import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:absensi_selfie_2020_java/models/response_login.dart';
import 'package:absensi_selfie_2020_java/models/response_report.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:path/path.dart';

class ApiService {
  final String baseUrl="http://api.absensi-selfie.pptik.id:5006";
  Client client = Client();

  Future<ResponseLogin>attemptLogin(String email, String password)async{
    final response = await client.post('$baseUrl/users/login',
        body: {"EMAIL":email,"ID_CARD":password}
    );


    if(response.statusCode == 200){
      print(responseLoginFromJson(response.body));
      return responseLoginFromJson(response.body);
    }else{
      print("failed");
      return null;
    }
  }

  Future<ResponseReport> reportPresent(File image, String company, String guid, String name, String longitude,
      String latitude, String address, String local_image, String status, String position, String unit, String timestamp)async{

    String base64Image = base64Encode(image.readAsBytesSync());
    String filename = image.path.split("/").last;
    var length = await image.length();
    var stream = new http.ByteStream( DelegatingStream.typed(image.openRead()));
    var request   = new http.MultipartRequest("POST", Uri.parse('$baseUrl/users/report/create'));
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(image.path));
    request.files.add(multipartFile);
    request.fields['COMPANY']=company;
    request.fields['GUID']=guid;
    request.fields['NAME']=name;
    request.fields['LONG']=longitude;
    request.fields['LAT']=latitude;
    request.fields['ADDRESS']=address;
    request.fields['LOCAL_IMAGE']=local_image;
    request.fields['STATUS']=status;
    request.fields['POSITION']=position;
    request.fields['UNIT']=unit;
    request.fields['TIMESTAMP']=timestamp;

    final response = await request.send();

    if(response.statusCode == 200){
      var results ;
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        results = value;
      });
      return results;
    }else{
      print("failed");
      return null;
    }
  }
}