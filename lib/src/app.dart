import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories_app/src/blocs/app/app_bloc.dart';
import 'package:memories_app/src/cubits/memories_cubit.dart';
import 'package:memories_app/src/managers/object_factory.dart';
import 'package:memories_app/src/resources/repositories/memories_repository.dart';
import 'package:memories_app/src/ui/screens/auth/login_screen.dart';
import 'package:memories_app/src/ui/screens/auth/splash_screen.dart';
import 'package:memories_app/src/ui/screens/memories/memories_around_screen.dart';
import 'package:memories_app/src/utilities/constants.dart';
import 'package:memories_app/src/utilities/my_app_theme.dart';
import 'package:provider/provider.dart';

import 'package:authentication/authentication.dart';

class App extends StatelessWidget {
  App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider<AuthenticationRepository>(
        //     create: (context) => AuthenticationRepository()),
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (BuildContext context) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          // BlocProvider<BlocB>(
          //   create: (BuildContext context) => BlocB(),
          // ),
        ],
        child: BlocConsumer<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  MemoriesAroundScreen.route(),
                  (route) => false,
                );
                break;
              case AppStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
              default:
                _navigator.pushAndRemoveUntil<void>(
                  LoginScreen.route(),
                  (route) => false,
                );
                break;
            }
          },
          listenWhen: (previous, current) {
            // return true/false to determine whether or not
            // to invoke listener with state
            return previous.status != current.status;
          },
          builder: (BuildContext context, AppState state) {
            return MaterialApp(
              navigatorKey: _navigatorKey,
              navigatorObservers: <NavigatorObserver>[
                ObjectFactory().firebaseManager.firebaseAnalyticsObserver
              ],
              debugShowCheckedModeBanner: false,
              theme: MyAppTheme.lightTheme,
              darkTheme: MyAppTheme.darkTheme,
              // themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
              themeMode: ThemeMode.light,
              // onGenerateRoute: (_) => SplashScreen.route(),
              onGenerateRoute: (_) => _navigate(state.status),
            );
          },
        ),
      ),
    );
    // return ChangeNotifierProvider(
    //   create: (_) => appState,
    //   child: Consumer<AppState>(
    //     builder: (context, appState, child) {
    //       return MaterialApp(
    //         navigatorKey: navigatorKey,
    //         debugShowCheckedModeBanner: false,
    //         theme: MyAppTheme.lightTheme,
    //         darkTheme: MyAppTheme.darkTheme,
    //         themeMode: appState.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
    //         navigatorObservers: <NavigatorObserver>[
    //           ObjectFactory().firebaseManager.firebaseAnalyticsObserver
    //         ],
    //         home: BlocProvider(
    //           create: (context) => MemoriesCubit(FakeMemoryRepository()),
    //           child: LoginScreen(),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  _navigate(AppStatus status) {
    switch (status) {
      case AppStatus.authenticated:
        return MemoriesAroundScreen.route();

      case AppStatus.unauthenticated:
        return LoginScreen.route();

      default:
        return LoginScreen.route();
    }
  }
}
