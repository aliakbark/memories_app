// To parse this JSON data, do
//
//     final memoriesResponse = memoriesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:memories_app/src/models/base_response_header.dart';
import 'package:memories_app/src/models/memory.dart';

MemoriesResponse memoriesResponseFromJson(String str) =>
    MemoriesResponse.fromJson(json.decode(str));

String memoriesResponseToJson(MemoriesResponse data) =>
    json.encode(data.toJson());

class MemoriesResponse {
  MemoriesResponse({
    required this.responseHeader,
    required this.memoriesAround,
  });

  BaseResponseHeader? responseHeader;
  List<Memory>? memoriesAround;

  factory MemoriesResponse.fromJson(Map<String, dynamic> json) =>
      MemoriesResponse(
        responseHeader: json["responseHeader"] == null
            ? null
            : BaseResponseHeader.fromJson(json["responseHeader"]),
        memoriesAround: json["memoriesAround"] == null
            ? null
            : List<Memory>.from(
                json["memoriesAround"].map((x) => Memory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseHeader":
            responseHeader == null ? null : responseHeader?.toJson(),
        "memoriesAround": memoriesAround == null
            ? null
            : List<Memory>.from(memoriesAround!.map((x) => x.toJson())),
      };
}
