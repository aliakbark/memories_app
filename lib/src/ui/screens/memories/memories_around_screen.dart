import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/models/memory.dart';
import 'package:memories_app/src/utilities/my_navigator.dart';

class MemoriesAroundScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MemoriesAroundScreenState();
}

class _MemoriesAroundScreenState extends State<MemoriesAroundScreen> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchMemories();
  }

  @override
  void dispose() {
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
                _fetchMemories();
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
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
          onPressed: () => MyNavigator.goToCreateMemory(context)),
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

  void _fetchMemories() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await location.changeSettings(
        accuracy: LocationAccuracy.balanced,
        interval: 60000,
        distanceFilter: 10);

    location.onLocationChanged.listen((LocationData currentLocation) {
      print('${DateTime.now()} :\n $currentLocation');
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        BlocProvider.of<MemoriesCubit>(context).getMemoriesAround(
            currentLocation.latitude, currentLocation.longitude);
      }
    });
  }
}
