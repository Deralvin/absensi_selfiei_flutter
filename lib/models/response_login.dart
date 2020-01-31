// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  String status;
  Data data;

  ResponseLogin({
    this.status,
    this.data,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  dynamic phoneNumber;
  String id;
  String name;
  String email;
  String position;
  String idCard;
  String company;
  String timestamp;
  String localImage;
  String guid;
  String image;

  Data({
    this.phoneNumber,
    this.id,
    this.name,
    this.email,
    this.position,
    this.idCard,
    this.company,
    this.timestamp,
    this.localImage,
    this.guid,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phoneNumber: json["PHONE_NUMBER"],
    id: json["_id"],
    name: json["NAME"],
    email: json["EMAIL"],
    position: json["POSITION"],
    idCard: json["ID_CARD"],
    company: json["COMPANY"],
    timestamp: json["TIMESTAMP"],
    localImage: json["LOCAL_IMAGE"],
    guid: json["GUID"],
    image: json["IMAGE"],
  );

  Map<String, dynamic> toJson() => {
    "PHONE_NUMBER": phoneNumber,
    "_id": id,
    "NAME": name,
    "EMAIL": email,
    "POSITION": position,
    "ID_CARD": idCard,
    "COMPANY": company,
    "TIMESTAMP": timestamp,
    "LOCAL_IMAGE": localImage,
    "GUID": guid,
    "IMAGE": image,
  };
}
