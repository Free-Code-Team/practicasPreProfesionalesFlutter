part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class CargandoState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AutenticadoConExitoState extends AuthState {
  final Usuario usuario;
  AutenticadoConExitoState(this.usuario);
  @override
  List<Object?> get props => [usuario];
}

class DesautenticadoConExitoState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final String error;
  ErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class DesautenticadoState extends AuthState {
  @override
  List<Object?> get props => [];
}