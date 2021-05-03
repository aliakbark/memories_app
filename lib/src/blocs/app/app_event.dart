part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppThemeChanged extends AppEvent {
  const AppThemeChanged(this.isDarkMode);

  final bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode];
}
