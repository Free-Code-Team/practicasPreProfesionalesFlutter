part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class IngresarEvent extends AuthEvent {
  final String email;
  final String password;

  IngresarEvent(this.email, this.password);
}

class RegistrarEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String rol;
  final String estado;
  final String token;

  RegistrarEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.estado,
    required this.rol,
    required this.token,
  });
}

class AutenticarConGoogleEvent extends AuthEvent {}

class AutenticarEvent extends AuthEvent {
  final String uid;
  AutenticarEvent(this.uid);
}

class DesautenticarEvent extends AuthEvent {}


class AutenticarConGoogle extends AuthEvent {}
