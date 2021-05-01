import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:memories_app/src/blocs/app/app_bloc.dart';
import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/managers/memories.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/resources/repositories/memories_repository.dart';
import 'package:memories_app/src/utilities/my_navigator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

class MemoriesAroundScreen extends StatefulWidget {
  MemoriesAroundScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MemoriesAroundScreenState();

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                MemoriesCubit(FakeMemoryRepository()),
            child: MemoriesAroundScreen()));
  }
}

class _MemoriesAroundScreenState extends State<MemoriesAroundScreen> {
  bool? _serviceEnabled;
  LocationPermission? permission;
  StreamSubscription<Position>? positionStream;

  FirebaseMessaging? fcm;

  bool _settingsOpened = false;

  Position? _currentPosition;

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
    if (positionStream != null) positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    print(user.toString());
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              user.photo ?? '',
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        title: Text('${user.name}'),
        actions: [
          // IconButton(
          //     icon: Icon(Icons.refresh),
          //     onPressed: () {
          //       _determinePosition();
          //     }),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          ),
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
          builder: (BuildContext context, MemoriesState state) {
            if (state is MemoriesInitial) {
              return buildInitialInput();
            } else if (state is MemoriesLoading) {
              return buildLoading();
            } else if (state is MemoriesLoaded) {
              return buildMemoryList(
                  state.memoriesResponse.memoriesAround ?? []);
            } else {
              // (state is WeatherError)
              return buildInitialInput();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentPosition != null) {
            MyNavigator.goToCreateMemory(context,
                latitude: _currentPosition!.latitude,
                longitude: _currentPosition!.longitude);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: Text('No memories found around you!'),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView buildMemoryList(List<Memory> memoriesAround) {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: memoriesAround.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(memoriesAround[index].title),
              subtitle: Text(memoriesAround[index].penName),
              trailing: Text(memoriesAround[index].distance ?? ''),
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
    final initialMessage = await fcm?.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null && initialMessage.data['type'] == 'chat') {
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
      context.read<MemoriesCubit>().getMemoriesAround(
          currentPosition.latitude, currentPosition.longitude);
      // BlocProvider.of<MemoriesCubit>(context).getMemoriesAround(
      //     currentPosition.latitude, currentPosition.longitude);
    }
  }
}
