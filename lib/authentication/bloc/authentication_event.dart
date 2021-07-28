part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status, this.email);

  final AuthenticationStatus status;
  final String email;

  @override
  List<Object> get props => [status,email];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}