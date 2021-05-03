import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories_app/src/blocs/app/app_bloc.dart';
import 'package:memories_app/src/blocs/auth/auth_bloc.dart';
import 'package:memories_app/src/cubits/memories/memories_cubit.dart';
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

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  final AuthenticationRepository _authenticationRepository;

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
          BlocProvider<AppBloc>(create: (BuildContext context) => AppBloc()),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) =>
                AuthBloc(authenticationRepository: _authenticationRepository),
          ),
        ],
        child: BlocBuilder<AppBloc, AppState>(
          buildWhen: (previous, current) {
            return previous.themeMode != current.themeMode;
          },
          builder: (BuildContext context, AppState appState) {
            return MaterialApp(
              navigatorKey: _navigatorKey,
              navigatorObservers: <NavigatorObserver>[
                ObjectFactory().firebaseManager.firebaseAnalyticsObserver
              ],
              debugShowCheckedModeBanner: false,
              theme: MyAppTheme.lightTheme,
              darkTheme: MyAppTheme.darkTheme,
              themeMode: appState.themeMode,
              builder: (context, child) {
                return MultiBlocListener(
                  listeners: [
                    BlocListener<AuthBloc, AuthState>(
                      listenWhen: (previous, current) =>
                          previous.status != current.status,
                      listener: (context, state) {
                        switch (state.status) {
                          case AuthStatus.authenticated:
                            _navigator.pushAndRemoveUntil<void>(
                              MemoriesAroundScreen.route(),
                              (route) => false,
                            );
                            break;
                          case AuthStatus.unauthenticated:
                            _navigator.pushAndRemoveUntil<void>(
                              LoginScreen.route(),
                              (route) => false,
                            );
                            break;
                          default:
                            break;
                        }
                      },
                    ),
                  ],
                  child: child!,
                );
              },
              onGenerateRoute: (_) => SplashScreen.route(),
            );
          },
        ),
      ),
    );
  }
}
