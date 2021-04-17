import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/utilities/my_navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MemoriesAroundScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemoriesAroundScreenState();
}

class _MemoriesAroundScreenState extends State<MemoriesAroundScreen> {
  bool _serviceEnabled;
  LocationPermission permission;
  StreamSubscription<Position> positionStream;

  FirebaseMessaging fcm;

  bool _settingsOpened = false;

  Position _currentPosition;

  bool _locationSettingsOpened = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ObjectFactory()
        .firebaseManager
        .firebaseAnalyticsObserver
        .analytics
        .logAppOpen();
    _determinePosition();

    _listeners();
  }

  @override
  void dispose() {
    if (positionStream != null) positionStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memories around me"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _determinePosition();
              }),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: BlocConsumer<MemoriesCubit, MemoriesState>(
          listener: (context, state) {
            if (state is MemoriesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is MemoriesInitial) {
              return buildInitialInput();
            } else if (state is MemoriesLoading) {
              return buildLoading();
            } else if (state is MemoriesLoaded) {
              return buildMemoryList(state.memoriesResponse.memoriesAround);
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            if (_currentPosition != null) {
              MyNavigator.goToCreateMemory(context,
                  latitude: _currentPosition.latitude,
                  longitude: _currentPosition.longitude);
            }
          }),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: Text('No memories found around you!'),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  buildMemoryList(List<Memory> memoriesAround) {
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: memoriesAround.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(memoriesAround[index].title),
              subtitle: Text(memoriesAround[index].penName),
              trailing: Text(memoriesAround[index].distance),
              onTap: () => MyNavigator.goToMemoryDetails(context,
                  memory: memoriesAround[index]),
            ),
          );
        });
  }

  void _listeners() async {
    fcm = await ObjectFactory().firebaseManager.firebaseMessaging;

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage = await fcm.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null && initialMessage?.data['type'] == 'chat') {
      print(initialMessage.data['type']);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print(message);
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  void _determinePosition() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text('Permissions required'),
                content: Text(
                    'Location permissions are required for seamless experience.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        if (_settingsOpened) {
                          _determinePosition();
                        }
                      },
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        _settingsOpened = await Geolocator.openAppSettings();
                      },
                      child: Text('Allow'))
                ],
              );
            });
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // _currentPosition = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.medium);
      // _fetchMemories(_currentPosition);
      positionStream = Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.medium,
              distanceFilter: 10,
              intervalDuration: Duration(minutes: 2))
          .listen((Position position) async {
        _currentPosition = position;
        _fetchMemories(position);
      });
    }
  }

  void _fetchMemories(Position currentPosition) async {
    if (currentPosition != null) {
      print(currentPosition == null
          ? 'Unknown'
          : currentPosition.latitude.toString() +
              ', ' +
              currentPosition.longitude.toString());

      BlocProvider.of<MemoriesCubit>(context).getMemoriesAround(
          currentPosition.latitude, currentPosition.longitude);
    }
  }
}
