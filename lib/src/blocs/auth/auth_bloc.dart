import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          const AuthState.unknown(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) async => Future.delayed(
      const Duration(seconds: 3), () => add(AuthUserChanged(user)));

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AuthLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AuthState _mapUserChangedToState(AuthUserChanged event, AuthState state) {
    return event.user.isNotAnonymous
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
