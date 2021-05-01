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
    required this.requestHeader,
    required this.lanternsAround,
  });

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
        "requestHeader": requestHeader == null ? null : requestHeader?.toJson(),
        "lanternsAround":
            lanternsAround == null ? null : lanternsAround?.toJson(),
      };

  BaseRequestHeader? requestHeader;
  LanternsAround? lanternsAround;
}

class LanternsAround {
  LanternsAround({
    required this.latitude,
    required this.longitude,
  });

  factory LanternsAround.fromJson(Map<String, dynamic> json) => LanternsAround(
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };

  String latitude;
  String longitude;
}
