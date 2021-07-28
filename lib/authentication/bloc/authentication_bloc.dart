import 'dart:async';
import 'dart:ffi';
import 'dart:html';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required String email,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _email = email,
        super(AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(AuthenticationStatusChanged(status,email)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final String _email;

  late StreamSubscription<AuthenticationStatus>
  _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event,);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event,
      ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : AuthenticationState.unauthenticated();
      default:
        return AuthenticationState.unknown();
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser(_email);
      return user;
    } on Exception {
      return null;
    }
  }
}