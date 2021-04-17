import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/ui/widgets/buttons/custom_raised_button.dart';
import 'package:memories_app/src/utilities/constants.dart';
import 'package:provider/provider.dart';

class CreateMemoryScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  CreateMemoryScreen({this.latitude, this.longitude});

  @override
  _CreateMemoryScreenState createState() => _CreateMemoryScreenState();
}

class _CreateMemoryScreenState extends State<CreateMemoryScreen> {
  String _chosenValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            FutureBuilder<List<Placemark>>(
                future: placemarkFromCoordinates(
                    widget.latitude, widget.longitude,
                    localeIdentifier: Memories.defaultLocale.toString()),
                builder: (BuildContext ctxt,
                    AsyncSnapshot<List<Placemark>> snapshot) {
                  return RichText(
                    text: TextSpan(
                        text: 'Your location is auto detected as \n',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                              text:
                                  '${snapshot.hasData ? _getAddressText(snapshot?.data?.first) : 'Unknown'}',
                              style: Theme.of(context).textTheme.subtitle2),
                        ]),
                  );
                }),
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

  String _getAddressText(Placemark placemark) {
    return '${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}';
  }
}
