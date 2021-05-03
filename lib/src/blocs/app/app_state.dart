part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    this.themeMode = ThemeMode.light,
  });

  const AppState.theme({required ThemeMode themeMode})
      : this._(themeMode: themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}
