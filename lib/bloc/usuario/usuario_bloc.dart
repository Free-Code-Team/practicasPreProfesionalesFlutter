import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:practicas_pre_profesionales_flutter/models/usuario.dart';
import 'package:practicas_pre_profesionales_flutter/repositories/auth_repository.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {

  final AuthRepository _authRepository;

  UsuarioBloc(this._authRepository) : super(CargandoUsuariosState()) {
    on<ListarUsuariosEvent>((event, emit) async {
      emit(CargandoUsuariosState());
      List<Usuario> usuarios = await _authRepository.getUsers();
      emit(ListadoDeUsuariosState(usuarios));
    });
  }
}
