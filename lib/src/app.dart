import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:memories_app/src/resources/repositories/memories_repository.dart';
import 'package:memories_app/src/ui/screens/memories/memories_around_screen.dart';
import 'package:memories_app/src/utilities/app_state.dart';
import 'package:memories_app/src/utilities/my_app_theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final AppState appState;

  App({this.appState});



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => appState,
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: MyAppTheme.lightTheme,
            darkTheme: MyAppTheme.darkTheme,
            themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
            navigatorObservers: <NavigatorObserver>[
              ObjectFactory().firebaseManager.firebaseAnalyticsObserver
            ],
            home: BlocProvider(
              create: (context) => MemoriesCubit(FakeMemoryRepository()),
              child: MemoriesAroundScreen(),
            ),
          );
        },
      ),
    );
  }
}
