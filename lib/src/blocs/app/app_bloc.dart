import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.theme(themeMode: ThemeMode.light));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppThemeChanged) {
      yield _mapThemeChangedToState(event, state);
    }
  }

  AppState _mapThemeChangedToState(AppThemeChanged event, AppState state) {
    return event.isDarkMode
        ? const AppState.theme(themeMode: ThemeMode.dark)
        : const AppState.theme(themeMode: ThemeMode.light);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
