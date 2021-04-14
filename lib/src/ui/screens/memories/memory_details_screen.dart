import 'package:flutter/material.dart';
import 'package:memories_app/src/models/memory.dart';

class MemoryDetailsScreen extends StatefulWidget {
  final Memory memory;

  MemoryDetailsScreen({this.memory});

  @override
  _MemoryDetailsScreenState createState() => _MemoryDetailsScreenState();
}

class _MemoryDetailsScreenState extends State<MemoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory details'),
      ),
      body: Container(
        child: Center(
          child: Text("Details page \n ${widget.memory.toJson()}"),
        ),
      ),
    );
  }
}
