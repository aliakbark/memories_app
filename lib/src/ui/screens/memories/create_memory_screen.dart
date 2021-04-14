import 'package:flutter/material.dart';
import 'package:memories_app/src/ui/widgets/buttons/custom_raised_button.dart';
import 'package:memories_app/src/utilities/constants.dart';

class CreateMemoryScreen extends StatefulWidget {
  @override
  _CreateMemoryScreenState createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends State<CreateMemoryScreen> {
  String _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your memory'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("How are you feeling?"),
                DropdownButton<String>(
                  value: _chosenValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),
                  items: Constants.emotionList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: Text(
                    "Select",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            CustomRaisedButton(
              child: Text('CREATE'),
              color: Colors.blueAccent,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
