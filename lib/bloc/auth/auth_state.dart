part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();
}

// Cuando el usuario presiona el botón de inicio de sesión o registro, el estado cambia primero a cargando y luego a Autenticado.
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

// Cuando el usuario se autentica, el estado cambia a Autenticado.
class Authenticated extends AuthState {
  final String? rol;

  const Authenticated({required this.rol});

  @override
  List<Object?> get props => [rol];
}

// Este es el estado inicial del bloque. Cuando el usuario no está autenticado, el estado cambia a No autenticado.
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// Si ocurre algún error, el estado cambia a AuthError.
class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
