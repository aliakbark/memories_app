import 'package:flutter/material.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/ui/screens/memories/create_memory_screen.dart';
import 'package:memories_app/src/ui/screens/memories/memory_details_screen.dart';

class MyNavigator {
  static Future<dynamic> goToMemoryDetails(BuildContext context,
      {required Memory memory}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoryDetailsScreen(memory: memory)));
  }

  static Future<dynamic> goToCreateMemory(BuildContext context,
      {required double latitude, required double longitude}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateMemoryScreen(
                  latitude: latitude,
                  longitude: longitude,
                )));
  }
}
