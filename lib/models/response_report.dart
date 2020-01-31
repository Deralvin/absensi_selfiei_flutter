// To parse this JSON data, do
//
//     final responseReport = responseReportFromJson(jsonString);

import 'dart:convert';

ResponseReport responseReportFromJson(String str) => ResponseReport.fromJson(json.decode(str));

String responseReportToJson(ResponseReport data) => json.encode(data.toJson());

class ResponseReport {
  String status;
  Data data;

  ResponseReport({
    this.status,
    this.data,
  });

  factory ResponseReport.fromJson(Map<String, dynamic> json) => ResponseReport(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String company;
  String guid;

  Data({
    this.name,
    this.company,
    this.guid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["NAME"],
    company: json["COMPANY"],
    guid: json["GUID"],
  );

  Map<String, dynamic> toJson() => {
    "NAME": name,
    "COMPANY": company,
    "GUID": guid,
  };
}
