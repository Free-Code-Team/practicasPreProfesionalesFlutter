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
        emit(AutenticadoConExitoState(data!));
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
    on<RegistrarEvent>((event, emit) async {
      emit(CargandoState());
      try {
        Usuario? data = await _authRepository.signUp(
          email: event.email,
          password: event.password,
          rol: event.rol,
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
  }
}
