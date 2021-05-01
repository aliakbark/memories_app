// To parse this JSON data, do
//
//     final memory = memoryFromJson(jsonString);

import 'dart:convert';

Memory memoryFromJson(String str) => Memory.fromJson(json.decode(str));

String memoryToJson(Memory data) => json.encode(data.toJson());

class Memory {
  Memory({
    this.lanternId,
    required this.penName,
    required this.typeOfEmotion,
    this.description,
    required this.latitude,
    required this.title,
    required this.longitude,
    required this.timestamp,
    this.distance,
  });

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        lanternId: json["lantern_id"] == null ? null : json["lantern_id"],
        penName: json["pen_name"] == null ? null : json["pen_name"],
        typeOfEmotion:
            json["type_of_emotion"] == null ? null : json["type_of_emotion"],
        description: json["description"] == null ? null : json["description"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        title: json["title"] == null ? null : json["title"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        timestamp: json["timestamp"] == null ? null : json["timestamp"],
        distance: json["distance"] == null ? null : json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "lantern_id": lanternId == null ? null : lanternId,
        "pen_name": penName == null ? null : penName,
        "type_of_emotion": typeOfEmotion == null ? null : typeOfEmotion,
        "description": description == null ? null : description,
        "latitude": latitude == null ? null : latitude,
        "title": title == null ? null : title,
        "longitude": longitude == null ? null : longitude,
        "timestamp": timestamp == null ? null : timestamp,
        "distance": distance == null ? null : distance,
      };

  String? lanternId;
  String penName;
  String typeOfEmotion;
  String? description;
  String latitude;
  String title;
  String longitude;
  String timestamp;
  String? distance;
}
