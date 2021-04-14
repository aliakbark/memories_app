import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/resources/repositories/memories_repository.dart';
import 'package:memories_app/src/ui/screens/memories/memories_around_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MemoriesCubit(FakeMemoryRepository()),
        child: MemoriesAroundScreen(),
      ),
    );
  }
}
