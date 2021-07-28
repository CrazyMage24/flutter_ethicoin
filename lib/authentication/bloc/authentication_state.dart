part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final value = "";
  final value2 = 0;
  AuthenticationState._({
    this.status = AuthenticationStatus.unknown,

    // valami baja mindig van a konstanssal
    // user.dart
    this.user = User.empty();
  });

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  AuthenticationStatus status;
  User user;

  @override
  List<Object> get props => [status, user];
}