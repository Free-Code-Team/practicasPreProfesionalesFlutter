part of 'usuario_bloc.dart';

@immutable
abstract class UsuarioState extends Equatable{}

class ListadoDeUsuariosState extends UsuarioState {
  final List<Usuario> usuarios;
  ListadoDeUsuariosState(this.usuarios);
  @override
  List<Object?> get props => [usuarios];
}

class CargandoUsuariosState extends UsuarioState {
  @override
  List<Object?> get props => [];
}

class ErrorListadoDeUsuariosState extends UsuarioState {
  final String error;
  ErrorListadoDeUsuariosState(this.error);
  @override
  List<Object?> get props => [error];
}
