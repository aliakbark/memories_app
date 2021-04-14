import 'package:flutter/material.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/ui/screens/memories/create_memory_screen.dart';
import 'package:memories_app/src/ui/screens/memories/memory_details_screen.dart';

class MyNavigator {
  static goToMemoryDetails(BuildContext context, {Memory memory}) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoryDetailsScreen(memory: memory)));
  }

  static goToCreateMemory(BuildContext context) {
    return Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateMemoryScreen()));
  }
}
