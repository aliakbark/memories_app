// To parse this JSON data, do
//
//     final memoriesRequest = memoriesRequestFromJson(jsonString);

import 'dart:convert';

import 'package:memories_app/src/models/base_request_header.dart';

MemoriesRequest memoriesRequestFromJson(String str) =>
    MemoriesRequest.fromJson(json.decode(str));

String memoriesRequestToJson(MemoriesRequest data) =>
    json.encode(data.toJson());

class MemoriesRequest {
  MemoriesRequest({
    this.requestHeader,
    this.lanternsAround,
  });

  BaseRequestHeader requestHeader;
  LanternsAround lanternsAround;

  factory MemoriesRequest.fromJson(Map<String, dynamic> json) =>
      MemoriesRequest(
        requestHeader: json["requestHeader"] == null
            ? null
            : BaseRequestHeader.fromJson(json["requestHeader"]),
        lanternsAround: json["lanternsAround"] == null
            ? null
            : LanternsAround.fromJson(json["lanternsAround"]),
      );

  Map<String, dynamic> toJson() => {
        "requestHeader": requestHeader == null ? null : requestHeader.toJson(),
        "lanternsAround":
            lanternsAround == null ? null : lanternsAround.toJson(),
      };
}

class LanternsAround {
  LanternsAround({
    this.latitude,
    this.longitude,
  });

  String latitude;
  String longitude;

  factory LanternsAround.fromJson(Map<String, dynamic> json) => LanternsAround(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}
