import 'package:bloc/bloc.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(DesautenticadoState()) {
    on<IngresarEvent>((event, emit) async {
      emit(CargandoState());
      try {
        Usuario? data = await _authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        if (data == null) {
          emit(ErrorState('Error no se pudo ingresar al sistema'));
          emit(DesautenticadoState());
        } else {
          emit(AutenticadoConExitoState(data));
        }
      } catch (e) {
        emit(ErrorState(e.toString()));
        emit(DesautenticadoState());
      }
    });
    on<RegistrarEvent>((event, emit) async {
      emit(CargandoState());
      try {
        Usuario? data = await _authRepository.signUp(
          email: event.email,
          password: event.password,
          rol: event.rol,
          estado: event.estado,
          name: event.name
        );
        emit(AutenticadoConExitoState(data!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<AutenticarConGoogleEvent>((event, emit) async {});

    on<AutenticarEvent>((event, emit) async {
      emit(CargandoState());
      try {
        Usuario? data = await _authRepository.getUser(event.uid);
        emit(AutenticadoConExitoState(data!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });

    on<DesautenticarEvent>((event, emit) async {
      await _authRepository.signOut();
      emit(DesautenticadoState());
    });

    on<AutenticarConGoogle>((event, emit) async {
      try {
        Usuario usuario = Usuario(uid: '1111', name: 'saul', email: 'saul', estado: 'aaa', rol: 'Desconocido');
        await _authRepository.signInWithGoogle();
        emit(AutenticadoConExitoState(usuario));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
